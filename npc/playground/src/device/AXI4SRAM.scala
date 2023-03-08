package device

import chisel3._
import chisel3.util._
import cyhcore.HasCyhCoreParameter

// ================================================
// 将IFU的取指接口改造成AXI-Lite
// 1. 用RTL编写一个AXI-Lite的SRAM模块, 地址位宽为32bit, 数据位宽为64bit
// 2. 收到读请求后, 通过DPI-C调用pmem_read(), 并延迟一周期返回读出的数据
    // IFU每次取指都要等待一个周期, 才能取到指令交给IDU
// ================================================

// 3. 当从机（slave）接收到读请求（ar-valid）且处于空闲状态则产生返还给主机（master）读准备(ar-ready)信号
// 表明可以进行读取操作，这时就完成了一次读地址的握手，
// 4. 从机（slave）开始准备需要返回的数据（r-data）、读返回请求（r-valid）、(读完成（r-last），读完成不需要，AXILite没有) 
// 5. 主机此时也跳变到下一个读数据状态，产生并发出可以读取返回数据的状态读准备（r-ready），当主机的r-valid & r-ready
// 完成握手，主机得到需要的数据（r-data），
// 6. 当主机接收到读完成（r-last）则完成了一次读事务同时状态跳变到空闲状态，并且产生读完成信号（ready），
// 将指令数据（inst）返还给取指模块（IF）。

class AXI4SRAMnew extends BlackBox with HasBlackBoxInline with HasCyhCoreParameter {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())

    val pc_valid = Input(Bool())
    val pc = Input(UInt(XLEN.W))
    val pc_ready = Output(Bool())

    val inst_valid = Output(Bool())
    val inst = Output(UInt(INST_LEN.W))
    val inst_ready = Input(Bool())

  })

  setInline("AXI4SRAMnew.v",
            s"""
              |module AXI4SRAMnew (
              |           input clk,
              |           input rst,
              |           // AXI4-Lite ar channel
              |           input pc_valid, // always true
              |           input [${XLEN}-1:0] pc,
              |           output reg pc_ready, 
              |           // AXI4-Lite r channel
              |           output reg inst_valid,
              |           output reg [${INST_LEN} - 1:0] inst,
              |           input inst_ready);
              | 
              |  // expose pc to cpp simulation environment
              |  import "DPI-C" function void set_pc(input logic [${XLEN}-1:0] a []);
              |  initial set_pc(pc);  
              |
              |  // for mem_r
              |  import "DPI-C" function void pmem_read(input longint raddr, output longint rdata);
              |
              |  // ar 读地址握手
              |  always@(posedge clk) begin
              |    if(rst) begin
              |      pc_ready <= 1'b0;
              |    end
              |    else begin
              |      if(pc_valid) begin
              |        pc_ready <= 1'b1; // 等对方 valid 后再拉高 ready, 则在对方 valid 后，延迟一周期 fire
              |      end
              |      else begin
              |        pc_ready <= 1'b0;
              |      end
              |    end
              |  end
              |
              |  logic [${XLEN}-1:0] axi_raddr; // 读地址寄存器，用来储存读地址 --- 因为我们要先完成读地址传输，再开始读数据
              |  logic axi_need_read; // 表示需要读, 一个1位寄存器，也可以叫 flag
              |   
              |  // 处理"读地址"寄存器和"需要读"寄存器
              |  always @(posedge clk) begin
              |    if(rst) begin
              |      axi_raddr <= '0;
              |      axi_need_read <= 1'b0;
              |    end
              |    else begin
              |      if(pc_valid & pc_ready) begin // 当 读地址 通道 fire 时，让 axi_raddr 储存读地址
              |        axi_raddr <= pc;
              |        axi_need_read <= 1'b1; // 同时，把 "需要读寄存器" 置为1
              |      end
              |      else begin
              |        axi_need_read <= 1'b0; // 其它时候，读地址寄存器保持不变
              |      end
              |    end
              |  end
              |
              |  // AXI read data section 读数据一节
              |  // 这里包括了读数据握手  也包括了读数据通道  --- TODO: 个人认为这里提到的方法要延迟两个周期，原因是 读地址ready 信号需要等待 读地址 valid 信号
              |  logic axi_wait_for_ready; // Read wait mode, waiting for master ready signal 等待来自Master的读ready信号
              |  logic [${XLEN}-1:0] axi_data_to_read; // 要读的data，来自寄存器
              |  reg [${XLEN}-1:0]	inst_aux;
              |
              |  always @(posedge clk) begin
              |    if(rst) begin
              |      inst_valid <= 1'b0; // 重置时，读valid，读数据 都为0
              |      inst_aux <= {${XLEN}{1'b0}};
              |      axi_wait_for_ready <= 1'b0; // 等待 ready 信号也为0
              |    end
              |    else begin
              |      if(axi_wait_for_ready) begin // 如果现在正在等待来自 Master 的 ready信号
              |        if(inst_ready) begin // 且接收到了 rready 信号
              |          inst_aux <= axi_data_to_read; // 那么就把要读的数据传给 rdata 信号
              |          inst_valid <= 1'b0; // 同时，在下一周期置 rvalid 为有效
              |          axi_wait_for_ready <= 1'b0; // exit wait for read mode // 然后，退出正在等待模式
              |        end
              |        else begin
              |          inst_valid <= 1'b1; 
              |          // 如果还没有接收到 rready 信号，则 inst_valid 为 1
              |        end
              |      end
              |      else begin  // 如果现在不是正在等待模式
              |        if(axi_need_read & inst_ready) begin // 如果现在需要读（读地址通道刚刚fire）信号和 主机的 rready 信号都为真
              |          inst_aux <= axi_data_to_read; // 那么就把要读的数据传给 rdata 信号
              |          inst_valid <= 1'b1; // 同时，在下一个时钟上升沿，把rvalid置为1
              |        end
              |        else if(axi_need_read) begin // 如果需要读信号为1, 而 主机的 rready 信号为假 ---------------------------------------------------- <- 199行错了 应该是先拉高RVALID等待RREADY，不好意思。
              |          // wait ready signal for read
              |          axi_wait_for_ready <= 1'b1;  // 那么进入 等待 ready 模式
              |          inst_valid <= 1'b0; // 同时 rvalid 置为0
              |        end
              |        else begin
              |          inst_valid <= 1'b0; // 其它情况，保持 rvalid 为0，因为我们没有把握这个时候 rdata 是正确的
              |        end
              |      end
              |    end
              |  end
              |  
              |  // AXI read
              |  always @(*) begin
              |    if(~rst) 
              |      pmem_read(pc, axi_data_to_read);
              |    else
              |      axi_data_to_read = '0;
              |  end
              |
              |  // inst selection	
              |  always@(*) 
              |    case(pc[2:0])
              |      3'h0: inst = inst_aux[${INST_LEN}-1:0];
              |      3'h4: inst = inst_aux[${XLEN}-1:${INST_LEN}];
              |      default: begin inst = '0; assert(0); end
              |    endcase
              |
              |  //  ------------------------------------ inst reading ---- end
              |
              |endmodule
            """.stripMargin)

}

class AXI4SRAM extends BlackBox with HasBlackBoxInline with HasCyhCoreParameter {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val pc = Input(UInt(XLEN.W))
    val inst = Output(UInt(INST_LEN.W))
  })

  setInline("AXI4SRAM.v",
            s"""
              |module AXI4SRAM (
              |           input clk,
              |           input rst,
              |           input [${XLEN}-1:0] pc,
              |           output reg [${INST_LEN} - 1:0] inst);
              |
              |  // expose pc to cpp simulation environment
              |  import "DPI-C" function void set_pc(input logic [${XLEN}-1:0] a []);
              |  initial set_pc(pc);  
              |
              |  // for mem_r
              |  import "DPI-C" function void pmem_read(input longint raddr, output longint rdata);
              |  //  ------------------------------------ inst reading ---- start
              |  // Define the state enumeration
              |  typedef enum logic [1:0] {
              |    IDLE,
              |    BUSY
              |  } state_t;
              |  // Define the state variable
              |  reg state;
              |
              |  // for inst read from pmem // TODO: the pmem_read implementation will be changed greatly after implement BUS
              |  reg [${XLEN}-1:0]	inst_aux;
              |  always@(*) begin
              |    if(~rst)
              |      pmem_read(pc, inst_aux); 
              |    else
              |      inst_aux = '0; 
              |  end
              |  // inst selection	
              |  always@(*) 
              |    case(pc[2:0])
              |      3'h0: inst = inst_aux[${INST_LEN}-1:0];
              |      3'h4: inst = inst_aux[${XLEN}-1:${INST_LEN}];
              |      default: begin inst = '0; assert(0); end
              |    endcase
              |  //  ------------------------------------ inst reading ---- end
              |
              |endmodule
            """.stripMargin)

}











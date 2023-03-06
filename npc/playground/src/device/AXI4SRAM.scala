package device

import chisel3._
import chisel3.util._
import cyhcore.HasCyhCoreParameter

// class AXI4SRAMnew extends AXI4SlaveModule {
//   val idle :: reading_data :: Nil = Enum(2)
//   val state  = RegInit(idle)

//   // 3. 当从机（slave）接收到读请求（ar-valid）且处于空闲状态则产生返还给主机（master）读准备(ar-ready)信号
//   // 表明可以进行读取操作，这时就完成了一次读地址的握手，
//   when(state === idle && in.ar.valid) {
//     in.ar.ready     := true.B 
//     in.r.bits.data  := 
//     in.r.bits.valid := true.B
//     state           := reading_data
//     // state := reading_request TODO: we are here
//   } .otherwise {
//   }

// }

// ================================================
// 将IFU的取指接口改造成AXI-Lite
// 1. 用RTL编写一个AXI-Lite的SRAM模块, 地址位宽为32bit, 数据位宽为64bit
// 2. 收到读请求后, 通过DPI-C调用pmem_read(), 并延迟一周期返回读出的数据
    // IFU每次取指都要等待一个周期, 才能取到指令交给IDU
// ================================================

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

  setInline("AXI4SRAM.v",
            s"""
              |module AXI4SRAM (
              |           input clk,
              |           input rst,
              |
              |           input [] pc_valid,
              |           input [${XLEN}-1:0] pc,
              |           output reg [] pc_ready,
              | 
              |           output reg inst_valid,
              |           output reg [${INST_LEN} - 1:0] inst,
              |           input  inst_ready);
              | 
              |  // expose pc to cpp simulation environment
              |  import "DPI-C" function void set_pc(input logic [${XLEN}-1:0] a []);
              |  initial set_pc(pc);  
              |
              |  // for mem_r
              |  import "DPI-C" function void pmem_read(input longint raddr, output longint rdata);
// 3. 当从机（slave）接收到读请求（ar-valid）且处于空闲状态则产生返还给主机（master）读准备(ar-ready)信号
// 表明可以进行读取操作，这时就完成了一次读地址的握手，
// 4. 从机（slave）开始准备需要返回的数据（r-data）、读返回请求（r-valid）、(读完成（r-last），读完成不需要，AXILite没有) 
// 5. 主机此时也跳变到下一个读数据状态，产生并发出可以读取返回数据的状态读准备（r-ready），当主机的r-valid & r-ready
// 完成握手，主机得到需要的数据（r-data），
// 6. 当主机接收到读完成（r-last）则完成了一次读事务同时状态跳变到空闲状态，并且产生读完成信号（ready），
// 将指令数据（inst）返还给取指模块（IF）。
              |  // Define the state enumeration
              |  // typedef enum logic [1:0] {
              |  //   IDLE,
              |  //   BUSY
              |  // } state_t;
              |  
              |  // Define the state variable
              |  // reg state;
    // val clk = Input(Clock())
    // val rst = Input(Bool())

    // val pc_valid = Input(Bool())
    // val pc = Input(UInt(XLEN.W))

    // val inst_ready = Input(Bool())
              |
              |  reg [${XLEN}-1:0]	inst_aux;
              |
              |  // Define the state transition logic
              |  always @(posedge clk) begin
              |    if (rst) begin
              |      pc_ready <= 1'b0;
              |      inst_valid <= 1'b0;
              |      inst_aux = '0; 
              |    end 
              |    else begin
              |      if(pc_valid) begin
              |        pc_ready <= 1'b1;
              |        inst_valid <= 1'b1;
              |        pmem_read(pc, inst_aux); 
              |      end
              |      else begin
              |        pc_ready <= 1'b0;
              |        // do nothing, 
              |      end
              |    end
              |  end
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











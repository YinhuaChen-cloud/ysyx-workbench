package device

import chisel3._
import chisel3.util._

import cyhcore.HasCyhCoreParameter
import bus.simplebus._
import bus.axi4._

// 因为 SRAM 属于外设，不属于 core，不建议直接 extends CyhCoreModule
// 注意：我认为 AXI4SRAM 和 READ_INST 模块之间的连接，不需要再用总线了
// 连接AXI4SRAM的可能是 AXI4 总线，也可能是 AXI4Lite 总线，通过参数 _type 指明
class AXI4SRAM[T <: AXI4Lite](_type: T = new AXI4) extends AXI4SlaveModule(_type) {

  // AXI4SRAM 需要处理的信号包括:
  // 1. ar_addr ar_valid ar_ready ar_prot
  // 2. r_data r_valid r_ready r_resp

  val sramhelper = Module(new SRAMHelper) // 封装DPIC代码的模块
  sramhelper.io.clk     := clock
  sramhelper.io.rst     := reset
  sramhelper.io.isRead  := axislave.ar.fire
  sramhelper.io.addr    := axislave.ar.bits.addr

  // 输出有：ar_ready, r_data, r_valid, r_resp 其中除了 r_data，都已经在 AXI4Slave 中处理了

  axislave.r.bits.data := sramhelper.io.inst 

  // 和 IFU handshake -----------------------------------------------
  // io.imem.resp.valid   := io.imem.req.valid // TODO: 由于可以在一拍内读完内存，所以目前输出valid = 输入valid
  // io.imem.req.ready    := true.B // TODO: 有自信在每一拍都能完成指令读取

}

// 封装DPIC代码的模块
class SRAMHelper extends BlackBox with HasBlackBoxInline with HasCyhCoreParameter {

  val V_MACRO_XLEN     = XLEN
  val V_MACRO_PC_LEN   = PC_LEN
  val V_MACRO_ADDR_LEN = PAddrBits
  val V_MACRO_INST_LEN = INST_LEN

  val io = IO(new Bundle {
    val clk    = Input(Clock())
    val rst    = Input(Bool())
    val isRead = Input(Bool())  // 可以认为是读内存的使能信号
    val addr   = Input(UInt(V_MACRO_ADDR_LEN.W)) 
    val inst   = Output(UInt(V_MACRO_INST_LEN.W))
  })

  setInline("SRAMHelper.v",
            s"""
              |module SRAMHelper (
              |           input clk,
              |           input rst,
              |           input isRead,
              |           input [${V_MACRO_ADDR_LEN}-1:0] addr,
              |           output reg [${V_MACRO_INST_LEN}-1:0] inst);
              |
              |  wire [${V_MACRO_PC_LEN}-1:0] external_pc;
              |  assign external_pc[${V_MACRO_ADDR_LEN}-1:0] = addr;
              |
              |  // always@(*) begin
              |  //   $$display("external_pc is %x", external_pc);
              |  // end
              |
              |  // for mem_r
              |  import "DPI-C" function void pmem_read(input longint raddr, output longint rdata);
              |  //  ------------------------------------ inst reading ---- start
              |  // for inst read from pmem // TODO: the pmem_read implementation will be changed greatly after implement BUS
              |  reg [${V_MACRO_XLEN}-1:0]	inst_aux;
              |  always@(*) begin
              |    if(~rst & isRead)
              |      pmem_read(external_pc, inst_aux); 
              |    else
              |      inst_aux = '0; 
              |  end
              |  // inst selection	
              |  always@(*) 
              |    case(external_pc[2:0])
              |      3'h0: inst = inst_aux[${V_MACRO_INST_LEN}-1:0];
              |      3'h4: inst = inst_aux[${V_MACRO_XLEN}-1:${V_MACRO_INST_LEN}];
              |      default: begin inst = '0; assert(0); end
              |    endcase
              |  //  ------------------------------------ inst reading ---- end
              |
              |endmodule
            """.stripMargin)

}

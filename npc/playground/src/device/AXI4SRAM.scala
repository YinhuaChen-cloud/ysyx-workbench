package device

import chisel3._
import chisel3.util._

import cyhcore.HasCyhCoreParameter
import bus.simplebus._

// 因为 SRAM 属于外设，不属于 core，不建议直接 extends CyhCoreModule
// 注意：我认为 AXI4SRAM 和 READ_INST 模块之间的连接，不需要再用总线了
class AXI4SRAM extends Module with HasCyhCoreParameter {
  val io = IO(new Bundle {
    val imem = Flipped(new SimpleBusUC)
  })

  // TODO: 等下试试 io 命名简化法

  val read_inst = Module(new READ_INST)
  read_inst.io.clk  := clock
  read_inst.io.rst  := reset
  read_inst.io.addr := io.imem.req.addr

  io.imem.resp.rdata := read_inst.io.inst // TODO: rdata 是 64 位，而inst是32位,这里后边可能要修改

}

class READ_INST extends BlackBox with HasBlackBoxInline with HasCyhCoreParameter {

  val V_MACRO_XLEN     = XLEN
  val V_MACRO_PC_LEN   = PC_LEN
  val V_MACRO_ADDR_LEN = PAddrBits
  val V_MACRO_INST_LEN = INST_LEN

  val io = IO(new Bundle {
    val clk  = Input(Clock())
    val rst  = Input(Bool())
    val addr = Input(UInt(V_MACRO_ADDR_LEN.W)) // TODO: 这个后边换成 32 位的
    val inst = Output(UInt(V_MACRO_INST_LEN.W))
  })

  setInline("READ_INST.v",
            s"""
              |module READ_INST (
              |           input clk,
              |           input rst,
              |           input [${V_MACRO_ADDR_LEN}-1:0] addr,
              |           output reg [${V_MACRO_INST_LEN}-1:0] inst);
              |
              |  wire [${V_MACRO_PC_LEN}-1:0] external_pc;
              |  assign external_pc = addr;
              |
              |  // expose pc to cpp simulation environment
              |  import "DPI-C" function void set_pc(input logic [${V_MACRO_PC_LEN}-1:0] a []);
              |  initial set_pc(external_pc);  
              |
              |  // for mem_r
              |  import "DPI-C" function void pmem_read(input longint raddr, output longint rdata);
              |  //  ------------------------------------ inst reading ---- start
              |  // for inst read from pmem // TODO: the pmem_read implementation will be changed greatly after implement BUS
              |  reg [${V_MACRO_XLEN}-1:0]	inst_aux;
              |  always@(*) begin
              |    if(~rst)
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











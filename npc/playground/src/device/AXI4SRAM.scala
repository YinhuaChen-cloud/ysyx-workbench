package device

import chisel3._
import chisel3.util._
import chisel3.experimental._

import cyhcore.HasCyhCoreParameter
import bus.simplebus._

// 因为 SRAM 属于外设，不属于 core，不建议直接 extends CyhCoreModule
class AXI4SRAM extends Module with HasCyhCoreParameter {
  val io = IO(new Bundle {
    val imem = Flipped(new SimpleBusUC)
  })

  // TODO: 等下试试 io 命名简化法

  val read_inst = Module(new READ_INST)
  read_inst.io.clk := clock
  read_inst.io.rst := reset
  read_inst.io.pc  := io.imem.req.addr

  io.imem.resp.rdata := read_inst.io.inst // TODO: rdata 是 64 位，而inst是32位,这里后边可能要修改

}

class READ_INST extends BlackBox with HasBlackBoxInline with HasCyhCoreParameter {
  val MACRO_XLEN = 64
  val io = IO(new Bundle {
    val clk  = Input(Clock())
    val rst  = Input(Bool())
    val pc = Input(UInt(MACRO_XLEN.W)) // TODO: 这个后边换成 32 位的
    val inst = Output(UInt(INST_LEN.W))
  })

  setInline("READ_INST.v",
            s"""
              |module READ_INST (
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











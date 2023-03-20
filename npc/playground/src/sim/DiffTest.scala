package sim

import chisel3._
import chisel3.util._
import cyhcore.HasCyhCoreParameter

class DiffTest extends BlackBox with HasBlackBoxInline with HasCyhCoreParameter {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val pc  = Input(UInt(PC_LEN.W)) 
    val regfile = Input(UInt((NR_GPRS * XLEN).W))
  })

  setInline("DiffTest.v",
            s"""
              |module DiffTest (
              |           input clk,
              |           input rst,
              |           input [${PC_LEN}-1:0] pc,
              |           input [${NR_GPRS} * ${XLEN} - 1:0] regfile);
              |
              |  // expose pc to cpp simulation environment
              |  import "DPI-C" function void set_pc(input logic [${PC_LEN}-1:0] a []);
              |  initial set_pc(pc);  
              |
              |  // expose regfile for difftest
              |  import "DPI-C" function void set_gpr_ptr(input logic [${XLEN}-1:0] a []);
              |  wire [${XLEN}-1:0] regs [${NR_GPRS}-1:0];
              |  genvar i;
              |  generate
              |    for(i = 0; i < ${NR_GPRS}; i = i+1) begin
              |      assign regs[i] = regfile[(i+1)*${XLEN} - 1 : i*${XLEN}]; 
              |    end
              |  endgenerate
              |  initial set_gpr_ptr(regs);
              |
              |endmodule
            """.stripMargin)

}



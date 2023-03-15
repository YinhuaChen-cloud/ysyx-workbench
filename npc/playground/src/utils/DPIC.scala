package utils

import chisel3._
import chisel3.util._
import cyhcore.HasCyhCoreParameter

class DPIC extends BlackBox with HasBlackBoxInline with HasCyhCoreParameter {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val isEbreak = Input(Bool())
    val inv_inst  = Input(Bool())
  })

  setInline("DPIC.v",
            s"""
              |module DPIC (
              |           input clk,
              |           input rst,
              |           input isEbreak,
              |           input inv_inst);
              |
              |  // only cpp simulation environment can execute ebreak()
              |  import "DPI-C" function void ebreak();
              |  always@(*) begin
              |    if(isEbreak)
              |      ebreak();   
              |  end
              |
              |  // used to report invalid inst error
              |  import "DPI-C" function void invalid();
              |    always@(posedge clk)
              |      if (~rst && inv_inst)
              |        invalid();
              |
              |endmodule
            """.stripMargin)

}



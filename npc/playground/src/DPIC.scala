import chisel3._
import chisel3.util._
import chisel3.experimental._

class DPIC (xlen: Int = 64) extends ExtModule(Map("XLEN" -> xlen)) with HasExtModuleInline {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val pc = Input(UInt(xlen.W))
  })

  setInline("DPIC.v",
            s"""
            |import "DPI-C" function void set_pc(input logic [XLEN-1:0] a []);
            |module DPIC #(XLEN=64) (
            |           input clk,
            |           input rst,
            |           input [XLEN-1:0] pc);
            |  
            |  initial set_pc(pc);  
            |
            |endmodule
            """.stripMargin)

}


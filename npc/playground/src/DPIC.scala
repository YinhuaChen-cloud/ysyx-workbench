import chisel3._
import chisel3.util.HasBlackBoxInline

import chisel3.util._

class DPIC (xlen: Int = 64) extends BlackBox with HasBlackBoxInline {
  val io = IO(new Bundle {
    val pc = Input(UInt(xlen.W))
  })

  setInline("DPIC.v",
            """
            |import "DPI-C" function void set_pc(input logic [XLEN-1:0] a []);
            |initial set_pc(pc);  
            """.stripMargin)

}





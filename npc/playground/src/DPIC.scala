import chisel3._
import chisel3.util._
import chisel3.experimental._
import Conf._

class DPIC (implicit val conf: Configuration) extends ExtModule(Map("XLEN" -> conf.xlen)) with HasExtModuleInline {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val pc = Input(UInt(conf.xlen.W))
    val isEbreak = Input(Bool())
  })

  setInline("DPIC.v",
            s"""
              |module DPIC #(XLEN=64) (
              |           input io_clk,
              |           input io_rst,
              |           input [XLEN-1:0] io_pc,
              |           input io_isEbreak);
              |  
              |  import "DPI-C" function void set_pc(input logic [XLEN-1:0] a []);
              |  initial set_pc(io_pc);  
              |
              |  import "DPI-C" function void ebreak();
              |  always@(*) begin
              |    if(io_isEbreak)
              |      ebreak();   
              |  end
              |
              |endmodule
            """.stripMargin)

}


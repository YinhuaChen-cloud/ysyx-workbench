import chisel3._
import chisel3.util._
import chisel3.experimental._
import Conf._

class DPIC (implicit val conf: Configuration) 
extends ExtModule(Map("XLEN" -> conf.xlen, "NR_REG" -> conf.nr_reg)) 
with HasExtModuleInline {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val pc = Input(UInt(conf.xlen.W))
    val isEbreak = Input(Bool())
    val inv_inst  = Input(Bool())
    val regfile = Input(Vec(conf.nr_reg, UInt(conf.xlen.W)))
  })

  setInline("DPIC.v",
            s"""
              |module DPIC #(XLEN=64, NR_REG=32) (
              |           input io_clk,
              |           input io_rst,
              |           input [XLEN-1:0] io_pc,
              |           input io_isEbreak,
              |           input io_inv_inst,
              |           input [XLEN-1:0] io_regfile[NR_REG-1:0]);
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
              |  import "DPI-C" function void invalid();
              |    always@(posedge io_clk)
              |      if (~io_rst && io_inv_inst)
              |        invalid();
              |
              |  import "DPI-C" function void set_gpr_ptr(input logic [XLEN-1:0] a []);
              |  initial set_gpr_ptr(io_regfile);
              |
              |
              |endmodule
            """.stripMargin)

}


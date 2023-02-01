import chisel3._
import chisel3.util._
import chisel3.experimental._
import Conf._

class DPIC (implicit val conf: Configuration) 
extends ExtModule(Map("XLEN" -> conf.xlen, "NR_REG" -> conf.nr_reg, "PC_LEN" -> conf.pc_len)) 
with HasExtModuleInline {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val pc = Input(UInt(conf.pc_len.W))
    val isEbreak = Input(Bool())
    val inv_inst  = Input(Bool())
    val regfile = Input(UInt((conf.nr_reg * conf.xlen).W))
  })

  setInline("DPIC.v",
            s"""
              |module DPIC #(XLEN=${conf.xlen}, NR_REG=${conf.nr_reg}, PC_LEN=${conf.pc_len}) (
              |           input io_clk,
              |           input io_rst,
              |           input [PC_LEN-1:0] io_pc,
              |           input io_isEbreak,
              |           input io_inv_inst,
              |           input [NR_REG * XLEN - 1:0] io_regfile);
              |
              |  import "DPI-C" function void set_pc(input logic [PC_LEN-1:0] a []);
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
              |  wire [XLEN-1:0] regs [NR_REG-1:0];
              |  for(int i = 0; i < NR_REG; i = i+1) begin
              |    assign regs[i] = io_regfile[(i+1)*XLEN - 1 : i*XLEN]; 
              |  end
              |  initial set_gpr_ptr(regs);
              |
              |endmodule
            """.stripMargin)

}

//              |  import "DPI-C" function void set_gpr_ptr(input logic [XLEN-1:0] a []);
//              |  import "DPI-C" function void set_gpr_ptr(input logic [XLEN * NR_REG -1:0] a []);


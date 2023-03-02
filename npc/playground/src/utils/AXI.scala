package utils

import chisel3._
import chisel3.util._
import chisel3.experimental._
import Conf._

class AXI (implicit val conf: Configuration) 
extends ExtModule(Map("XLEN" -> conf.xlen, "NR_REG" -> conf.nr_reg, "PC_LEN" -> conf.pc_len, "INST_LEN" -> conf.inst_len)) 
with HasExtModuleInline {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val isEbreak = Input(Bool())
    val inv_inst  = Input(Bool())
    val regfile = Input(UInt((conf.nr_reg * conf.xlen).W))
  })

  setInline("DPIC.v",
            s"""
              |module DPIC #(XLEN=${conf.xlen}, NR_REG=${conf.nr_reg}, PC_LEN=${conf.pc_len}, INST_LEN=${conf.inst_len}) (
              |           input io_clk,
              |           input io_rst,
              |           input io_isEbreak,
              |           input io_inv_inst,
              |           input [NR_REG * XLEN - 1:0] io_regfile);
              |
              |  // only cpp simulation environment can execute ebreak()
              |  import "DPI-C" function void ebreak();
              |  always@(*) begin
              |    if(io_isEbreak)
              |      ebreak();   
              |  end
              |
              |  // used to report invalid inst error
              |  import "DPI-C" function void invalid();
              |    always@(posedge io_clk)
              |      if (~io_rst && io_inv_inst)
              |        invalid();
              |
              |  // expose regfile for difftest
              |  import "DPI-C" function void set_gpr_ptr(input logic [XLEN-1:0] a []);
              |  wire [XLEN-1:0] regs [NR_REG-1:0];
              |  genvar i;
              |  generate
              |    for(i = 0; i < NR_REG; i = i+1) begin
              |      assign regs[i] = io_regfile[(i+1)*XLEN - 1 : i*XLEN]; 
              |    end
              |  endgenerate
              |  initial set_gpr_ptr(regs);
              |
              |endmodule
            """.stripMargin)

}



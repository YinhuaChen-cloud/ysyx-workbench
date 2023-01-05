//module ysyx_22050039_IFU #(XLEN=64) (
//	input clk,
//	input rst,
//	input pc_wen,
//	input [XLEN-1:0] pc_wdata,
//	output [XLEN-1:0] pc
//);

//  import "DPI-C" function void set_pc(input logic [XLEN-1:0] a []);
//  initial set_pc(pc);  
//
//	wire [XLEN-1:0] next_pc;
//
//  ysyx_22050039_Reg #(XLEN, 32'h80000000) pc_reg (clk, rst, next_pc, pc, 1'b1);
//
//  //TODO: the "pc + 4" here may be a problem
//	assign next_pc = pc_wen ? pc_wdata : pc+4;  

//endmodule

import chisel3._

class IFU (xlen: Int) extends Module {
  val io = IO(new Bundle {
    val pc_wen = Input(Bool())
    val pc_wdata = Input(UInt(xlen.W))
    val pc = Output(UInt(xlen.W))
  })

  val pc_reg = RegInit("h80000000".U(xlen.W))
  pc_reg := Mux(io.pc_wen, io.pc_wdata, pc_reg + 4)
  io.pc := pc_reg

}


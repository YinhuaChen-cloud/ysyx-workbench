//module ysyx_22050039_IFU #(XLEN=64) (
//	input clk,
//	input rst,
//	input pc_wen,
//	input [XLEN-1:0] pc_wdata,
//	output [XLEN-1:0] pc
//);
//
//  import "DPI-C" function void set_pc(input logic [XLEN-1:0] a []);
//  initial set_pc(pc);  
//
//	wire [XLEN-1:0] next_pc;
//
//  ysyx_22050039_Reg #(XLEN, 32'h80000000) pc_reg (clk, rst, next_pc, pc, 1'b1);
//
//  //TODO: the "pc + 4" here may be a problem
//	assign next_pc = pc_wen ? pc_wdata : pc+4;  
//
////	always@(posedge clk)
////		$display("In IFU, pc = 0x%x", pc);
////	always@(posedge clk)
////		$display("In IFU, next_pc = 0x%x", next_pc);
////	always@(posedge clk)
////		$display("In IFU, pc_wen = %d", pc_wen);
//
//endmodule

import chisel3._

class IFU extends Module {
  val io = IO(new Bundle {
    val led   = Output(Bool())
  })

  val x = RegInit(0.U(1.W))
  val CNT_MAX = 25000000.U
  val cnt = RegInit(0.U(32.W))

  when(cnt < CNT_MAX) {
    cnt := cnt + 1.U
  }.otherwise {
    cnt := 0.U
    x := ~x
  }

  io.led := x
}

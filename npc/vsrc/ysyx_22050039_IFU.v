module ysyx_22050039_IFU #(XLEN=64) (
	input clk,
	input rst,
	input pc_wen,
	input [XLEN-1:0] pc_wdata,
	output [XLEN-1:0] pc
);
 // /* verilator lint_off WIDTH */

	wire [XLEN-1:0] next_pc;

  //TODO: the "pc + 1" here may be a problem
  ysyx_22050039_Reg #(XLEN, 32'h80000000) pc_reg (clk, rst, next_pc, pc, 1'b1);

	assign next_pc = pc_wen ? pc_wdata : pc+1;  

endmodule

/* verilator lint_off WIDTH */
module ysyx_22050039_IFU #(XLEN=64) (
	input clk,
	input rst,
	output [XLEN-1:0] pc
);

  //TODO: the "pc + 1" here may be a problem
  ysyx_22050039_Reg #(XLEN, 32'h80000000) pc_reg (clk, rst, pc+1, pc, 1'b1);

endmodule

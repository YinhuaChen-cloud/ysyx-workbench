// May be you can say top == cpu
/* verilator lint_off UNUSED */
module ysyx_22050039_top #(XLEN = 64, INST_LEN = 32) (
  input clk,
  input rst,
	input [INST_LEN-1:0] inst,
	output [XLEN-1:0] pc
);

	ysyx_22050039_IFU #(XLEN) ifu(
		.clk(clk),
		.rst(rst),
		.pc(pc)
	);

endmodule


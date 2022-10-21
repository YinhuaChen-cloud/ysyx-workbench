/* verilator lint_off UNUSED */
module ysyx_22050039_EXU #(XLEN = 64) (
	input clk,
	input rst,
	input [2:0] func,
	input [XLEN-1:0] src1,
	input [XLEN-1:0] src2,
	output [XLEN-1:0] exec_result
);

	wire [XLEN-1:0] addi_result;
	assign addi_result = src1 + src2;

	import "DPI-C" function void ebreak();
	always@(posedge clk)
		if(~rst)
			ebreak();
		else
			;

	assign exec_result = addi_result;

endmodule

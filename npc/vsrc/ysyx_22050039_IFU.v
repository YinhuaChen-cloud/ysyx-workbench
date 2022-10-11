/* verilator lint_off WIDTH */
module ysyx_22050039_IFU #(XLEN=64) (
	input clk,
	input rst,
	output reg [XLEN-1:0] pc
);

	always@(posedge clk)
		if(rst)
			pc <= 32'h8000_0000;
		else
			pc <= pc + 1;

endmodule

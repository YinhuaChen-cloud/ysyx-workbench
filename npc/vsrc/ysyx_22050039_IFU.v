module ysyx_22050039_IFU (
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

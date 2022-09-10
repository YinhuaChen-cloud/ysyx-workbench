module top(
	input clk,
	input rst,
	output reg [7:0] q
);

	wire new_in;
	
	assign new_in = q[4]^q[3]^q[2]^q[0];

	always@(posedge clk)
		if(rst)
			q <= 1;
		else
			q <= {new_in, q[7:1]};

endmodule

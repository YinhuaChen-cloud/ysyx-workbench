module top(
	input clk,
	input rst,
	output [7:0] seg1, // high
	output [7:0] seg2, // low
	output reg [7:0] q
);

	wire new_in;
	
	assign new_in = q[4]^q[3]^q[2]^q[0];

	always@(posedge clk)
		if(rst)
			q <= 1;
		else
			q <= {new_in, q[7:1]};

	reg [7:0] segs [15:0];
	assign segs[0] = 8'b11111101;
	assign segs[1] = 8'b01100000;
	assign segs[2] = 8'b11011010;
	assign segs[3] = 8'b11110010;
	assign segs[4] = 8'b01100110;
	assign segs[5] = 8'b10110110;
	assign segs[6] = 8'b10111110;
	assign segs[7] = 8'b11100000;

	assign seg1 = segs[q[7:4]];
	assign seg2 = segs[q[3:0]];

endmodule

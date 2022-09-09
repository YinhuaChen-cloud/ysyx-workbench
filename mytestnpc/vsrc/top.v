module top(
	input [1:0] F,
	input [1:0] X0,
	input [1:0] X1,
	input [1:0] X2,
	input [1:0] X3,
	output reg [1:0] Y
);

	always@(*)
		case(F)
			0: Y = X0;
			1: Y = X1;
			2: Y = X2;
			3: Y = X3;
		endcase

endmodule


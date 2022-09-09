module top(
	input [1:0] F,
	input [1:0] X0,
	input [1:0] X1,
	input [1:0] X2,
	input [1:0] X3,
	output reg [1:0] Y
);

	wire [1:0] choose_by_F0_1;
	wire [1:0] choose_by_F0_2;

	mux2_2_1 inst0(F[0], X0, X1, choose_by_F0_1);
	mux2_2_1 inst1(F[0], X2, X3, choose_by_F0_2);
	mux2_2_1 inst2(F[1], choose_by_F0_1, choose_by_F0_2, Y);

endmodule


module mux2_2_1(
	input s,
	input [1:0] a,
	input [1:0] b,
	output [1:0] y
);

	assign y[0] = (~s&a[0])|(s&b[0]);
	assign y[1] = (~s&a[1])|(s&b[1]);

endmodule

//module mux1_2_1(
//	input s,
//	input a,
//	input b,
//	output y
//);
//
//	assign y = (~s&a)|(s&b);
//
//endmodule


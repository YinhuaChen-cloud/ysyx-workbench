module ALU(
	output reg [3:0] result,
	output reg Z,
	output reg L,
	input [3:0] A,
	input [3:0] B,
	input [2:0] func
);
// KISS
  parameter ADD = 0, SUB = 1, INV = 2, AND = 3, OR = 4, XOR = 5, 
		LESS = 6, EQ = 7;

	always@(*) begin
		result = 0;
		Z = 0;
		L = 0;
		case(func)
			ADD: result = A+B;
			SUB: result = A-B;
			INV: result = ~A;
			AND: result = A&B;
			OR: result = A|B;
			XOR: result = A^B;
			LESS: L = (A < B);
			EQ: Z = (A == B);
		endcase
	end
	
endmodule


module FSM_bin
(
  input   clk, in, reset,
  output reg out,
	output [3:0] state_dout
);

	parameter[3:0] S0 = 0, S1 = 1, S2 = 2, S3 = 3,
						S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8;

	wire [3:0] state_din;
	wire state_wen;

	SimReg#(4,0) state(clk, reset, state_din, state_dout, state_wen); // 4-bit reg, default 0 val

	assign state_wen = 1; // always allowed to write regs

	// output logic, combinational circuit
	MuxKeyWithDefault#(9, 4, 1) outMux(.out(out), .key(state_dout), .default_out(0), .lut({ // default_out = 0
		S0, 1'b0,
		S1, 1'b0,
		S2, 1'b0,
		S3, 1'b0,
		S4, 1'b1,
		S5, 1'b0,
		S6, 1'b0,
		S7, 1'b0,
		S8, 1'b1
	}));

	// next state logic, combinational circuit
	MuxKeyWithDefault#(9, 4, 4) stateMux(.out(state_din), .key(state_dout), .default_out(S0), .lut({
		S0, in ? S5 : S1,
		S1, in ? S5 : S2,
		S2, in ? S5 : S3,
		S3, in ? S5 : S4,
		S4, in ? S5 : S4,
		S5, in ? S6 : S1,
		S6, in ? S7 : S1,
		S7, in ? S8 : S1,
		S8, in ? S8 : S1
	}));

endmodule


module SimReg #(WIDTH = 4, RESET_VAL = 0) (clk, reset, state_din, state_dout, state_wen);

	output [WIDTH-1:0] state_dout;		
	input clk;
	input reset;
	input [WIDTH-1:0] state_din;
	input state_wen;

	reg [WIDTH-1:0] state;
	always@(posedge clk)
		if(reset)
			state <= RESET_VAL;
		else if(state_wen)
			state <= state_din;
		else
			state <= state;

	assign state_dout = state;
			
endmodule


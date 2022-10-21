module ysyx_22050039_EXU #(XLEN = 64) (
	input clk,
	input rst,
	input [2:0] func,
	input [XLEN-1:0] src1,
	input [XLEN-1:0] src2,
	input [XLEN-1:0] pc,
	output reg [XLEN-1:0] exec_result,
	output [XLEN-1:0] dnpc
);

	import "DPI-C" function void ebreak();

	always@(*) begin	
		exec_result = 0;
		dnpc = 0;
		case(func)
			3'd0: exec_result = src1 + src2;
			3'd1: begin exec_result = pc + 4; dnpc = src1 + src2; end
			3'd2: exec_result = src1 + pc;
			3'd3: exec_result = src1;
			3'd4: ; // sd empty now
			3'd5: begin exec_result = pc + 4; dnpc = pc + src1; end
			3'd6: ebreak();
			default: ;
		endcase
	end

endmodule

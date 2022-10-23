`ifndef ysyx_22050039_INSTPAT_V
`define ysyx_22050039_INSTPAT_V

`include "ysyx_22050039_all_inst.v"

`define ysyx_22050039_INSTPAT_START() \
	always@(*) begin \
		bundle = '0; \
		casez(inst)

`define ysyx_22050039_INSTPAT_END() \
		endcase \
	end

`define ysyx_22050039_INSTPAT(pattern, imm, type, func, pc_wen, reg_wen) \
	pattern: bundle = {inst[6:0], inst[14:12], \
		inst[11:7], inst[19:15], inst[24:20], inst[31:25], imm, \
		type, func, pc_wen, reg_wen}; 

`define ysyx_22050039_INSTINVALID() \
	default : bundle = {inst[6:0], inst[14:12], \
		inst[11:7], inst[19:15], inst[24:20], inst[31:25], {inst[31], \
		inst[19:12], inst[20], inst[30:21]}, Eb_Inv, Invalid, 1'b0, 1'b0}; 

`define ysyx_22050039_WPC 1'b1

`define ysyx_22050039_NO_WPC 1'b0

`define ysyx_22050039_WREG 1'b1

`define ysyx_22050039_NO_WREG 1'b0

`endif

`define INSTPAT_START(inst) \
	always@(*) begin \
		casez(inst)

`define INSTPAT_END() \
		endcase \
	end

`define INSTPAT(inst, pattern, imm, type, func, pc_wen) \
	a

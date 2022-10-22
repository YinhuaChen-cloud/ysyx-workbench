`define INSTPAT_START() \
	always@(*) begin \
		casez(inst)

`define INSTPAT_END() \
		endcase \
	end

`define INSTPAT(inst, bundle, pattern, imm, type, func, pc_wen) \
	pattern: bundle = {inst[6:0], inst[14:12], \
		inst[11:7], inst[19:15], inst[24:20], inst[31:25], {{8{inst[31]}}, \
		inst[31:20]}, 6'b010000, 3'd0, 1'b0}; 

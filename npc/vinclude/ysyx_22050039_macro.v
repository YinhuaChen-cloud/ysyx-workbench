`define INSTPAT_START(instruction_wire) \
	always@(*) begin \
		casez(instruction_wire)

`define INSTPAT_END() \
		endcase \
	end

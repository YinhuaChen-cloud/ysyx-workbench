// May be you can say top == cpu
/* verilator lint_off UNUSED */
module ysyx_22050039_top #(XLEN = 64, INST_LEN = 32) (
  input clk,
  input rst,
	input [INST_LEN-1:0] inst,
	output [XLEN-1:0] pc
);

	wire [XLEN-1:0] src1;
	wire [XLEN-1:0] src2;
	wire [XLEN-1:0] exec_result;
	wire [4:0] rd;
	wire func;

//	always@(posedge clk) begin
//		$display("pc = 0x%x, src1 = 0x%x, src2 = 0x%x, rd = %d, exec_result = aaa%d", pc, src1, src2, rd, exec_result);
//	end

	ysyx_22050039_IFU #(XLEN) ifu(
		.clk(clk),
		.rst(rst),
		.pc(pc)
	);

	ysyx_22050039_IDU #(XLEN, INST_LEN) idu(
		.clk(clk),
		.rst(rst),
		.inst(inst),
		.exec_result(exec_result),
		.src1(src1),
		.src2(src2),
		.rd(rd),
		.func(func)
	);

	ysyx_22050039_EXU #(XLEN) exu(
		.clk(clk),
		.rst(rst),
		.func(func),
		.src1(src1),
		.src2(src2),
		.exec_result(exec_result)
	);

endmodule


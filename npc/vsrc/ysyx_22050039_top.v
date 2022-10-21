// May be you can say top == cpu
module ysyx_22050039_top #(XLEN = 64, INST_LEN = 32) (
  input clk,
  input rst,
	input [INST_LEN-1:0] inst,
	output [XLEN-1:0] pc
);

//	always@(posedge clk) begin
//		$display("pc = 0x%x, src1 = 0x%x, src2 = 0x%x, rd = %d, exec_result = aaa%d", pc, src1, src2, rd, exec_result);
//	end

  // submodule1 IFU
	wire pc_wen; // IDU -> IFU
	wire [XLEN-1:0] dnpc; // EXU -> IFU

	ysyx_22050039_IFU #(XLEN) ifu(
		.clk(clk),
		.rst(rst),
		.pc_wen(pc_wen),
		.pc_wdata(dnpc),
		.pc(pc)
	);

	// submodule2: IDU
	wire [XLEN-1:0] src1; // IDU -> EXU
	wire [XLEN-1:0] src2; // IDU -> EXU
	wire [2:0] func; // IDU -> EXU
	wire [XLEN-1:0] exec_result; // EXU -> IDU

	ysyx_22050039_IDU #(XLEN, INST_LEN) idu(
		.clk(clk),
		.rst(rst),
		.inst(inst),
		.exec_result(exec_result),
		.src1(src1),
		.src2(src2),
		.func(func),
		.pc_wen(pc_wen)
	);

	// submodule3: EXU
	ysyx_22050039_EXU #(XLEN) exu(
		.clk(clk),
		.rst(rst),
		.func(func),
		.src1(src1),
		.src2(src2),
		.pc(pc),
		.exec_result(exec_result),
		.dnpc(dnpc)
	);

	always@(posedge clk) begin
		$display("dnpc = %x", dnpc);
	end

endmodule


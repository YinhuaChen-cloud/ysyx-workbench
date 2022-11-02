`include "ysyx_22050039_config.v"
// May be you can say top == cpu
module ysyx_22050039_top #(XLEN = `ysyx_22050039_XLEN, INST_LEN = 32) (
  input clk,
  input rst
);


  // submodule1 IFU
	wire pc_wen; // IDU -> IFU
	wire [XLEN-1:0] dnpc; // EXU -> IFU
	wire [XLEN-1:0] pc; // IFU -> EXU

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
	wire [XLEN-1:0] destI; // IDU -> EXU
	wire [`ysyx_22050039_FUNC_LEN-1:0] func; // IDU -> EXU
	wire [XLEN-1:0] exec_result; // EXU -> IDU
	wire [INST_LEN-1:0] exec_result; // EXU -> IDU
	wire [INST_LEN-1:0] inst; // EXU -> IDU

	ysyx_22050039_IDU #(XLEN, INST_LEN) idu(
		.clk(clk),
		.rst(rst),
		.inst(inst),
		.exec_result(exec_result),
		.src1(src1),
		.src2(src2),
		.destI(destI),
		.func(func),
		.pc_wen(pc_wen)
	);

	// submodule3: EXU
	ysyx_22050039_EXU #(XLEN, INST_LEN) exu(
		.clk(clk),
		.rst(rst),
		.func(func),
		.src1(src1),
		.src2(src2),
		.destI(destI),
		.pc(pc),
		.inst(inst),
		.exec_result(exec_result),
		.dnpc(dnpc)
	);

	always@(posedge clk) begin
		$display("dnpc = %x", dnpc);
	end

endmodule


/* verilator lint_off UNUSED */
/* verilator lint_off UNDRIVEN */
module ysyx_22050039_IDU #(XLEN = 64, INST_LEN = 32, NR_REG = 32, REG_SEL = 5) (
	input clk,
	input rst,
	input [INST_LEN-1:0] inst,
	input [XLEN-1:0] exec_result,
	output [XLEN-1:0] src1,
	output [XLEN-1:0] src2,
	output [REG_SEL-1:0] rd,
	output func
);

	// define internal wires & regs
	wire [XLEN-1:0] regs [NR_REG-1:0];
	wire [NR_REG-1:0] reg_wen;
	wire [REG_SEL-1:0] rs1;
	wire [REG_SEL-1:0] rs2;
	wire [11:0] imm;
	wire [2:0] funct3;
	wire [6:0] opcode;

	// generate GPRS
	ysyx_22050039_Reg #(XLEN, 0) reg_zero (clk, rst, exec_result, regs[0], 1'b0);
	genvar i; 
	generate
		for(i = 1; i < NR_REG; i = i+1) begin
			ysyx_22050039_Reg #(XLEN, 0) gen_gprs (clk, rst, exec_result, regs[i], reg_wen[i]);
		end
	endgenerate

	// reg_addressing, deal with reg_wen (actually, this is a decoder, or you can say a 32-1 mux)
	ysyx_22050039_MuxKey #(NR_REG, REG_SEL, NR_REG) selDestR (
  .out(reg_wen),
  .key(rd),
  .lut({
		5'd0, 32'h0000_0001, 
		5'd1, 32'h0000_0002, 
		5'd2, 32'h0000_0004, 
		5'd3, 32'h0000_0008, 
		5'd4, 32'h0000_0010, 
		5'd5, 32'h0000_0020, 
		5'd6, 32'h0000_0040, 
		5'd7, 32'h0000_0080, 
		5'd8, 32'h0000_0100, 
		5'd9, 32'h0000_0200, 
		5'd10, 32'h0000_0400, 
		5'd11, 32'h0000_0800, 
		5'd12, 32'h0000_1000, 
		5'd13, 32'h0000_2000, 
		5'd14, 32'h0000_4000, 
		5'd15, 32'h0000_8000, 
		5'd16, 32'h0001_0000, 
		5'd17, 32'h0002_0000, 
		5'd18, 32'h0004_0000, 
		5'd19, 32'h0008_0000, 
		5'd20, 32'h0010_0000, 
		5'd21, 32'h0020_0000, 
		5'd22, 32'h0040_0000, 
		5'd23, 32'h0080_0000, 
		5'd24, 32'h0100_0000, 
		5'd25, 32'h0200_0000, 
		5'd26, 32'h0400_0000, 
		5'd27, 32'h0800_0000, 
		5'd28, 32'h1000_0000, 
		5'd29, 32'h2000_0000, 
		5'd30, 32'h4000_0000, 
		5'd31, 32'h8000_0000 
	})
);

//	select func according to inst

	// identify inst type 
	wire R, I, S, B, U, J, invalid; // only 1 of these will be high
	assign I = (funct3 == 0 && (opcode == 7'b0010011 || opcode == 7'b1100111));
	assign U = (opcode == 7'b0010111 || opcode == 7'b0110111);
	assign J = (opcode == 7'b1101111);
//  INSTPAT("??????? ????? ????? 000 ????? 00100 11", addi	 , I, R(dest) = src1 + src2);
//  INSTPAT("??????? ????? ????? 000 ????? 11001 11", jalr   , I, jalr_func(s, dest, src1, src2));
//  INSTPAT("??????? ????? ????? ??? ????? 00101 11", auipc  , U, R(dest) = src1 + s->pc);
//  INSTPAT("??????? ????? ????? ??? ????? 01101 11", lui    , U, R(dest) = src1);
//  INSTPAT("??????? ????? ????? ??? ????? 11011 11", jal    , J, jal_func(s, dest, src1));
	assign func = (funct3 == 0 && opcode == 7'h13);

	always@(posedge clk) begin
		$display("x0 = 0x%x, x1 = 0x%x, x2 = 0x%x ", regs[0], regs[1], regs[2]);
	end

// imm[11:0] rs1 funct3 rd opcode -- I type
// imm[11:0] rs1 000 rd 0010011 -- ADDI
	assign rs1 = inst[19:15];
	assign imm = inst[31:20];

	assign src1 = regs[rs1];
	assign src2[11:0] = imm;
	assign rd = inst[11:7];
	assign funct3 = inst[14:12];
	assign opcode = inst[6:0];

endmodule


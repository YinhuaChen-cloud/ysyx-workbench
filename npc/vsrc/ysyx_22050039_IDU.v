/* verilator lint_off UNUSED */
/* verilator lint_off UNDRIVEN */
module ysyx_22050039_IDU #(XLEN = 64, INST_LEN = 32, NR_REG = 32, REG_SEL = 5) (
	input clk,
	input rst,
	input [INST_LEN-1:0] inst,
	input [XLEN-1:0] exec_result,
	output [XLEN-1:0] src1,
	output [XLEN-1:0] src2,
	output [2:0] func,
	output pc_wen, 
	output [XLEN-1:0] pc_wdata 
);

	// submodule1 - registers_heap: generate GPRS x0-x31
	wire [XLEN-1:0] regs [NR_REG-1:0];
	wire [NR_REG-1:0] reg_each_wen; 
	wire reg_total_wen;  // no drive yet TODO: not decied whether necessary yet

	ysyx_22050039_Reg #(XLEN, 0) reg_zero (clk, rst, exec_result, regs[0], 1'b0); // $zero is always 0
	genvar i; 
	generate
		for(i = 1; i < NR_REG; i = i+1) begin
//			ysyx_22050039_Reg #(XLEN, 0) gen_gprs (clk, rst, exec_result, regs[i], reg_total_wen & reg_each_wen[i]);
			ysyx_22050039_Reg #(XLEN, 0) gen_gprs (clk, rst, exec_result, regs[i], reg_each_wen[i]);
		end
	endgenerate

	// submodule2 - instruction decoder: decode inst
	wire [6:0] opcode;
	wire [2:0] funct3;
	wire [REG_SEL-1:0] rd;
	wire [REG_SEL-1:0] rs1;
	wire [REG_SEL-1:0] rs2;
	wire [6:0] funct7;
	wire [19:0] imm;
	wire R, I, S, B, U, J; // only 1 of these will be high
	reg [7+3+3*REG_SEL+7+20+6+3-1:0] bundle;

	assign {opcode, funct3, rd, rs1, rs2, funct7, imm, R, I, S, B, U, J, func} = bundle;

	localparam NR_INST = 7; // (including ebreak)
	always@(*)
		casez(inst)
			// I-type
			32'b?????????????????000?????0010011: bundle = {inst[6:0], inst[14:12],
				inst[11:7], inst[19:15], inst[24:20], inst[31:25], {{8{inst[31]}},
				inst[31:20]}, 6'b010000, 3'd0}; // addi
			32'b?????????????????000?????1100111: bundle = {inst[6:0], inst[14:12],
				inst[11:7], inst[19:15], inst[24:20], inst[31:25], {{8{inst[31]}},
				inst[31:20]}, 6'b010000, 3'd1}; // jalr
			// U-type
			32'b?????????????????????????0010111: bundle = {inst[6:0], inst[14:12],
				inst[11:7], inst[19:15], inst[24:20], inst[31:25], inst[31:12],
				6'b000010, 3'd2}; // auipc
			32'b?????????????????????????0110111: bundle = {inst[6:0], inst[14:12],
				inst[11:7], inst[19:15], inst[24:20], inst[31:25], inst[31:12],
				6'b000010, 3'd3}; // lui
			// S-type
			32'b?????????????????011?????0100011: bundle = {inst[6:0], inst[14:12],
				inst[11:7], inst[19:15], inst[24:20], inst[31:25], {{8{inst[31]}},
				inst[31:25], inst[11:7]}, 6'b001000, 3'd4}; // sd
			// J-type
			32'b?????????????????????????1101111: bundle = {inst[6:0], inst[14:12],
				inst[11:7], inst[19:15], inst[24:20], inst[31:25], {inst[31],
				inst[19:12], inst[20], inst[30:21]}, 6'b000001, 3'd5}; // jal
			// ebreak
			32'b00000000000100000000000001110011: ; 
			// invalid
			default 														: ; 
		endcase

	// submodule3 - reg addressing: 5-32 decoder 
	// Only 1 bit of output can be high, and that is the reg to write
	ysyx_22050039_MuxKey #(NR_REG, REG_SEL, NR_REG) selDestR (
		.out(reg_each_wen),
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

	always@(posedge clk) begin
		$display("x0 = 0x%x, x1 = 0x%x, x2 = 0x%x ", regs[0], regs[1], regs[2]);
	end

endmodule


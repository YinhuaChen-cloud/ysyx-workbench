`include "ysyx_22050039_instpat.v"
`include "ysyx_22050039_all_inst.v"

module ysyx_22050039_IDU #(XLEN = 64, INST_LEN = 32, NR_REG = 32, REG_SEL = 5) (
	input clk,
	input rst,
	input [INST_LEN-1:0] inst,
	input [XLEN-1:0] exec_result,
	output reg [XLEN-1:0] src1,
	output reg [XLEN-1:0] src2,
	output [`ysyx_22050039_FUNC_LEN-1:0] func,
	output pc_wen 
);

	import "DPI-C" function void set_gpr_ptr(input logic [XLEN-1:0] a []);
	initial set_gpr_ptr(regs);  // rf为通用寄存器的二维数组变量

	// submodule1 - registers_heap: generate GPRS x0-x31
	wire [XLEN-1:0] regs [NR_REG-1:0];
	wire [NR_REG-1:0] reg_each_wen; 
	wire reg_total_wen;  // no drive yet TODO: not decied whether necessary yet

	ysyx_22050039_Reg #(XLEN, 0) reg_zero (clk, rst, exec_result, regs[0], reg_total_wen & reg_each_wen[0]); 
	genvar i; 
	generate
		for(i = 1; i < NR_REG; i = i+1) begin
//			ysyx_22050039_Reg #(XLEN, 0) gen_gprs (clk, rst, exec_result, regs[i], reg_total_wen & reg_each_wen[i]);
			ysyx_22050039_Reg #(XLEN, 0) gen_gprs (clk, rst, exec_result, regs[i], reg_total_wen & reg_each_wen[i]);
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
	reg [7+3+3*REG_SEL+7+20+6+3+1+1-1:0] bundle;

	assign {opcode, funct3, rd, rs1, rs2, funct7, imm, R, I, S, B, U, J, func,
		pc_wen, reg_total_wen} = bundle;

	`ysyx_22050039_INSTPAT_START()
			// I-type
			`ysyx_22050039_INSTPAT(32'b?????????????????000?????0010011, {{8{inst[31]}}, inst[31:20]}, Itype, Addi, `ysyx_22050039_NO_WPC, `ysyx_22050039_WREG)
			`ysyx_22050039_INSTPAT(32'b?????????????????000?????1100111, {{8{inst[31]}}, inst[31:20]}, Itype, Jalr, `ysyx_22050039_WPC, `ysyx_22050039_WREG)
			// U-type
			`ysyx_22050039_INSTPAT(32'b?????????????????????????0010111, inst[31:12], Utype, Auipc, `ysyx_22050039_NO_WPC, `ysyx_22050039_WREG)
			`ysyx_22050039_INSTPAT(32'b?????????????????????????0110111, inst[31:12], Utype, Lui, `ysyx_22050039_NO_WPC, `ysyx_22050039_WREG)
			// S-type
			`ysyx_22050039_INSTPAT(32'b?????????????????011?????0100011, {{8{inst[31]}}, inst[31:25], inst[11:7]}, Stype, Sd, `ysyx_22050039_NO_WPC, `ysyx_22050039_NO_WREG)
			// J-type
			`ysyx_22050039_INSTPAT(32'b?????????????????????????1101111, {inst[31], inst[19:12], inst[20], inst[30:21]}, Jtype, Jal, `ysyx_22050039_WPC, `ysyx_22050039_WREG)
			// ebreak
			`ysyx_22050039_INSTPAT(32'b00000000000100000000000001110011, 20'b0, Eb_Inv, Ebreak, `ysyx_22050039_NO_WPC, `ysyx_22050039_NO_WREG)
			// invalid
			`ysyx_22050039_INSTINVALID()
	`ysyx_22050039_INSTPAT_END()

	// submodule3 - define src1 src2 TODO: maybe we need to determine rd here
	// the future
	wire [5:0] inst_type;
	assign inst_type = {R, I, S, B, U, J};

	always@(*) begin	
		src1 = 0;
		src2 = 0;
		case(inst_type)
			// R
			Rtype		: begin src1 = regs[rs1]; src2 = regs[rs2]; end
			// I
			Itype		: begin src1 = regs[rs1]; src2 = {{44{imm[19]}}, imm}; end
			// S
			Stype		: ; // empty now
			// B
			Btype		: assert(0); // empty now
			// U
			Utype		: begin src1 = {{32{imm[19]}}, imm, 12'b0}; end
			// J
			Jtype		: begin src1 = {{43{imm[19]}}, imm, 1'b0}; end
			// ebreak and invalid
			Eb_Inv	: ;	
			default : assert(0); 
		endcase
	end

	// submodule4 - reg addressing: 5-32 decoder 
	// Only 1 bit of output can be high, and that is the reg to write
	ysyx_22050039_MuxKey #(NR_REG, REG_SEL, NR_REG) selDestR (
		.out(reg_each_wen),
		.key(rd),
		.lut({
			5'd0, 32'h0000_0000, // $zero is always 0
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
		$display("inst_type = %d, func = %d, src1 = %x, src2 = %x", inst_type,
			func, src1, src2);
	end

endmodule


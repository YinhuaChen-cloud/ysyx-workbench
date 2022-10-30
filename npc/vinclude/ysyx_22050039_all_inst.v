`ifndef ysyx_22050039_ALL_INST_V
`define ysyx_22050039_ALL_INST_V

`define ysyx_22050039_FUNC_LEN 8

enum bit[`ysyx_22050039_FUNC_LEN-1:0] {
	// Rtype
	Addw = 0,
	Subw,
	Mulw,
	Divw,
	Divuw,
	Sllw,
	Srlw,
	Sraw,
	Remw,
	Remuw,
	Sub,
	Or,
	Add,
	Mul,
	Xor,
	Sll,
	Slt,
	Sltu,
	And,
	Div,
	Divu,
	Rem,
	Remu,
	// Itype
	Xori,
	Sltiu,
	Slli,
	Srli,
	Srai,
	Andi,
	Ori,
	Addiw,
	Slliw,
	Srliw,
	Sraiw,
	Ld,
	Lw,
	Lwu,
	Lh,
	Lhu,
	Lb,
	Lbu,
	Addi, 
	Jalr, 
	// Stype
	Sd, 
	Sw,
	Sh,
	Sb,
	// Btype
	Beq,
	Bne	,
	Bltu,
	Bge,
	Bgeu,
	Blt,
	// Utype
	Auipc, 
	Lui, 
	// Jtype
	Jal, 
	Ebreak, 
	Invalid
	} allinst;

enum bit[5:0] {Rtype = 6'b100000, Itype = 6'b010000, Stype = 6'b001000, Btype = 6'b000100, Utype = 6'b000010, Jtype = 6'b000001, Special = 6'b0} all_inst_types;

`endif 

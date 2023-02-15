module EXU(
  input           clock,
  input           reset,
  input  [31:0]   io_inst,
  output          io_idu_to_exu_br_eq,
  output          io_idu_to_exu_br_lt,
  output          io_idu_to_exu_br_ltu,
  input  [3:0]    io_idu_to_exu_pc_sel,
  input  [1:0]    io_idu_to_exu_op1_sel,
  input  [2:0]    io_idu_to_exu_op2_sel,
  input  [3:0]    io_idu_to_exu_alu_op,
  input  [1:0]    io_idu_to_exu_wb_sel,
  input           io_idu_to_exu_reg_wen,
  input  [2:0]    io_idu_to_exu_mem_msk_type,
  input           io_idu_to_exu_alu_msk_type,
  output [63:0]   io_ifu_to_exu_pc_next,
  input  [63:0]   io_ifu_to_exu_pc,
  input  [63:0]   io_mem_in,
  output [2047:0] io_regfile_output,
  output [63:0]   io_mem_addr,
  output [63:0]   io_mem_write_data,
  output          io_isRead,
  output [7:0]    io_mem_write_msk
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
  reg [63:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [63:0] _RAND_23;
  reg [63:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [63:0] _RAND_26;
  reg [63:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [63:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] rs1_addr = io_inst[19:15]; // @[EXU.scala 25:25]
  wire [4:0] rs2_addr = io_inst[24:20]; // @[EXU.scala 26:25]
  wire [4:0] rd_addr = io_inst[11:7]; // @[EXU.scala 27:25]
  reg [63:0] regfile_0; // @[EXU.scala 31:24]
  reg [63:0] regfile_1; // @[EXU.scala 31:24]
  reg [63:0] regfile_2; // @[EXU.scala 31:24]
  reg [63:0] regfile_3; // @[EXU.scala 31:24]
  reg [63:0] regfile_4; // @[EXU.scala 31:24]
  reg [63:0] regfile_5; // @[EXU.scala 31:24]
  reg [63:0] regfile_6; // @[EXU.scala 31:24]
  reg [63:0] regfile_7; // @[EXU.scala 31:24]
  reg [63:0] regfile_8; // @[EXU.scala 31:24]
  reg [63:0] regfile_9; // @[EXU.scala 31:24]
  reg [63:0] regfile_10; // @[EXU.scala 31:24]
  reg [63:0] regfile_11; // @[EXU.scala 31:24]
  reg [63:0] regfile_12; // @[EXU.scala 31:24]
  reg [63:0] regfile_13; // @[EXU.scala 31:24]
  reg [63:0] regfile_14; // @[EXU.scala 31:24]
  reg [63:0] regfile_15; // @[EXU.scala 31:24]
  reg [63:0] regfile_16; // @[EXU.scala 31:24]
  reg [63:0] regfile_17; // @[EXU.scala 31:24]
  reg [63:0] regfile_18; // @[EXU.scala 31:24]
  reg [63:0] regfile_19; // @[EXU.scala 31:24]
  reg [63:0] regfile_20; // @[EXU.scala 31:24]
  reg [63:0] regfile_21; // @[EXU.scala 31:24]
  reg [63:0] regfile_22; // @[EXU.scala 31:24]
  reg [63:0] regfile_23; // @[EXU.scala 31:24]
  reg [63:0] regfile_24; // @[EXU.scala 31:24]
  reg [63:0] regfile_25; // @[EXU.scala 31:24]
  reg [63:0] regfile_26; // @[EXU.scala 31:24]
  reg [63:0] regfile_27; // @[EXU.scala 31:24]
  reg [63:0] regfile_28; // @[EXU.scala 31:24]
  reg [63:0] regfile_29; // @[EXU.scala 31:24]
  reg [63:0] regfile_30; // @[EXU.scala 31:24]
  reg [63:0] regfile_31; // @[EXU.scala 31:24]
  wire [63:0] _GEN_1 = 5'h1 == rd_addr ? regfile_1 : regfile_0; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_2 = 5'h2 == rd_addr ? regfile_2 : _GEN_1; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_3 = 5'h3 == rd_addr ? regfile_3 : _GEN_2; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_4 = 5'h4 == rd_addr ? regfile_4 : _GEN_3; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_5 = 5'h5 == rd_addr ? regfile_5 : _GEN_4; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_6 = 5'h6 == rd_addr ? regfile_6 : _GEN_5; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_7 = 5'h7 == rd_addr ? regfile_7 : _GEN_6; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_8 = 5'h8 == rd_addr ? regfile_8 : _GEN_7; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_9 = 5'h9 == rd_addr ? regfile_9 : _GEN_8; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_10 = 5'ha == rd_addr ? regfile_10 : _GEN_9; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_11 = 5'hb == rd_addr ? regfile_11 : _GEN_10; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_12 = 5'hc == rd_addr ? regfile_12 : _GEN_11; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_13 = 5'hd == rd_addr ? regfile_13 : _GEN_12; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_14 = 5'he == rd_addr ? regfile_14 : _GEN_13; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_15 = 5'hf == rd_addr ? regfile_15 : _GEN_14; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_16 = 5'h10 == rd_addr ? regfile_16 : _GEN_15; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_17 = 5'h11 == rd_addr ? regfile_17 : _GEN_16; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_18 = 5'h12 == rd_addr ? regfile_18 : _GEN_17; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_19 = 5'h13 == rd_addr ? regfile_19 : _GEN_18; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_20 = 5'h14 == rd_addr ? regfile_20 : _GEN_19; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_21 = 5'h15 == rd_addr ? regfile_21 : _GEN_20; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_22 = 5'h16 == rd_addr ? regfile_22 : _GEN_21; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_23 = 5'h17 == rd_addr ? regfile_23 : _GEN_22; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_24 = 5'h18 == rd_addr ? regfile_24 : _GEN_23; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_25 = 5'h19 == rd_addr ? regfile_25 : _GEN_24; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_26 = 5'h1a == rd_addr ? regfile_26 : _GEN_25; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_27 = 5'h1b == rd_addr ? regfile_27 : _GEN_26; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_28 = 5'h1c == rd_addr ? regfile_28 : _GEN_27; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_29 = 5'h1d == rd_addr ? regfile_29 : _GEN_28; // @[EXU.scala 32:{26,26}]
  wire [63:0] _GEN_30 = 5'h1e == rd_addr ? regfile_30 : _GEN_29; // @[EXU.scala 32:{26,26}]
  wire  _wb_data_T = io_idu_to_exu_wb_sel == 2'h0; // @[EXU.scala 195:38]
  wire  _alu_out_aux_T = io_idu_to_exu_alu_op == 4'h1; // @[EXU.scala 106:29]
  wire  _alu_op1_T = io_idu_to_exu_op1_sel == 2'h1; // @[EXU.scala 86:38]
  wire [63:0] _GEN_65 = 5'h1 == rs1_addr ? regfile_1 : regfile_0; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_66 = 5'h2 == rs1_addr ? regfile_2 : _GEN_65; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_67 = 5'h3 == rs1_addr ? regfile_3 : _GEN_66; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_68 = 5'h4 == rs1_addr ? regfile_4 : _GEN_67; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_69 = 5'h5 == rs1_addr ? regfile_5 : _GEN_68; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_70 = 5'h6 == rs1_addr ? regfile_6 : _GEN_69; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_71 = 5'h7 == rs1_addr ? regfile_7 : _GEN_70; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_72 = 5'h8 == rs1_addr ? regfile_8 : _GEN_71; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_73 = 5'h9 == rs1_addr ? regfile_9 : _GEN_72; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_74 = 5'ha == rs1_addr ? regfile_10 : _GEN_73; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_75 = 5'hb == rs1_addr ? regfile_11 : _GEN_74; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_76 = 5'hc == rs1_addr ? regfile_12 : _GEN_75; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_77 = 5'hd == rs1_addr ? regfile_13 : _GEN_76; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_78 = 5'he == rs1_addr ? regfile_14 : _GEN_77; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_79 = 5'hf == rs1_addr ? regfile_15 : _GEN_78; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_80 = 5'h10 == rs1_addr ? regfile_16 : _GEN_79; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_81 = 5'h11 == rs1_addr ? regfile_17 : _GEN_80; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_82 = 5'h12 == rs1_addr ? regfile_18 : _GEN_81; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_83 = 5'h13 == rs1_addr ? regfile_19 : _GEN_82; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_84 = 5'h14 == rs1_addr ? regfile_20 : _GEN_83; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_85 = 5'h15 == rs1_addr ? regfile_21 : _GEN_84; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_86 = 5'h16 == rs1_addr ? regfile_22 : _GEN_85; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_87 = 5'h17 == rs1_addr ? regfile_23 : _GEN_86; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_88 = 5'h18 == rs1_addr ? regfile_24 : _GEN_87; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_89 = 5'h19 == rs1_addr ? regfile_25 : _GEN_88; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_90 = 5'h1a == rs1_addr ? regfile_26 : _GEN_89; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_91 = 5'h1b == rs1_addr ? regfile_27 : _GEN_90; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_92 = 5'h1c == rs1_addr ? regfile_28 : _GEN_91; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_93 = 5'h1d == rs1_addr ? regfile_29 : _GEN_92; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_94 = 5'h1e == rs1_addr ? regfile_30 : _GEN_93; // @[EXU.scala 58:{21,21}]
  wire [63:0] _GEN_95 = 5'h1f == rs1_addr ? regfile_31 : _GEN_94; // @[EXU.scala 58:{21,21}]
  wire [63:0] rs1_data = rs1_addr != 5'h0 ? _GEN_95 : 64'h0; // @[EXU.scala 58:21]
  wire  _alu_op1_T_1 = io_idu_to_exu_op1_sel == 2'h2; // @[EXU.scala 87:38]
  wire [19:0] imm_u = io_inst[31:12]; // @[EXU.scala 69:22]
  wire [31:0] _imm_u_sext_T_2 = imm_u[19] ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] imm_u_sext = {_imm_u_sext_T_2,imm_u,12'h0}; // @[Cat.scala 33:92]
  wire [63:0] _alu_op1_T_2 = _alu_op1_T_1 ? imm_u_sext : 64'h0; // @[Mux.scala 101:16]
  wire [63:0] _alu_op1_T_3 = _alu_op1_T ? rs1_data : _alu_op1_T_2; // @[Mux.scala 101:16]
  wire [63:0] alu_msk = io_idu_to_exu_alu_msk_type ? 64'hffffffff : 64'hffffffffffffffff; // @[Mux.scala 101:16]
  wire [63:0] alu_op1 = _alu_op1_T_3 & alu_msk; // @[EXU.scala 89:27]
  wire  _alu_op2_T = io_idu_to_exu_op2_sel == 3'h1; // @[EXU.scala 93:38]
  wire [63:0] _GEN_97 = 5'h1 == rs2_addr ? regfile_1 : regfile_0; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_98 = 5'h2 == rs2_addr ? regfile_2 : _GEN_97; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_99 = 5'h3 == rs2_addr ? regfile_3 : _GEN_98; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_100 = 5'h4 == rs2_addr ? regfile_4 : _GEN_99; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_101 = 5'h5 == rs2_addr ? regfile_5 : _GEN_100; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_102 = 5'h6 == rs2_addr ? regfile_6 : _GEN_101; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_103 = 5'h7 == rs2_addr ? regfile_7 : _GEN_102; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_104 = 5'h8 == rs2_addr ? regfile_8 : _GEN_103; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_105 = 5'h9 == rs2_addr ? regfile_9 : _GEN_104; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_106 = 5'ha == rs2_addr ? regfile_10 : _GEN_105; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_107 = 5'hb == rs2_addr ? regfile_11 : _GEN_106; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_108 = 5'hc == rs2_addr ? regfile_12 : _GEN_107; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_109 = 5'hd == rs2_addr ? regfile_13 : _GEN_108; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_110 = 5'he == rs2_addr ? regfile_14 : _GEN_109; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_111 = 5'hf == rs2_addr ? regfile_15 : _GEN_110; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_112 = 5'h10 == rs2_addr ? regfile_16 : _GEN_111; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_113 = 5'h11 == rs2_addr ? regfile_17 : _GEN_112; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_114 = 5'h12 == rs2_addr ? regfile_18 : _GEN_113; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_115 = 5'h13 == rs2_addr ? regfile_19 : _GEN_114; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_116 = 5'h14 == rs2_addr ? regfile_20 : _GEN_115; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_117 = 5'h15 == rs2_addr ? regfile_21 : _GEN_116; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_118 = 5'h16 == rs2_addr ? regfile_22 : _GEN_117; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_119 = 5'h17 == rs2_addr ? regfile_23 : _GEN_118; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_120 = 5'h18 == rs2_addr ? regfile_24 : _GEN_119; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_121 = 5'h19 == rs2_addr ? regfile_25 : _GEN_120; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_122 = 5'h1a == rs2_addr ? regfile_26 : _GEN_121; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_123 = 5'h1b == rs2_addr ? regfile_27 : _GEN_122; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_124 = 5'h1c == rs2_addr ? regfile_28 : _GEN_123; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_125 = 5'h1d == rs2_addr ? regfile_29 : _GEN_124; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_126 = 5'h1e == rs2_addr ? regfile_30 : _GEN_125; // @[EXU.scala 59:{21,21}]
  wire [63:0] _GEN_127 = 5'h1f == rs2_addr ? regfile_31 : _GEN_126; // @[EXU.scala 59:{21,21}]
  wire [63:0] rs2_data = rs2_addr != 5'h0 ? _GEN_127 : 64'h0; // @[EXU.scala 59:21]
  wire  _alu_op2_T_1 = io_idu_to_exu_op2_sel == 3'h2; // @[EXU.scala 94:38]
  wire [11:0] imm_i = io_inst[31:20]; // @[EXU.scala 63:22]
  wire [51:0] _imm_i_sext_T_2 = imm_i[11] ? 52'hfffffffffffff : 52'h0; // @[Bitwise.scala 77:12]
  wire [63:0] imm_i_sext = {_imm_i_sext_T_2,imm_i}; // @[Cat.scala 33:92]
  wire  _alu_op2_T_2 = io_idu_to_exu_op2_sel == 3'h3; // @[EXU.scala 95:38]
  wire [11:0] imm_s = {io_inst[31:25],rd_addr}; // @[Cat.scala 33:92]
  wire [51:0] _imm_s_sext_T_2 = imm_s[11] ? 52'hfffffffffffff : 52'h0; // @[Bitwise.scala 77:12]
  wire [63:0] imm_s_sext = {_imm_s_sext_T_2,io_inst[31:25],rd_addr}; // @[Cat.scala 33:92]
  wire  _alu_op2_T_3 = io_idu_to_exu_op2_sel == 3'h4; // @[EXU.scala 96:38]
  wire [63:0] _alu_op2_T_4 = _alu_op2_T_3 ? io_ifu_to_exu_pc : 64'h0; // @[Mux.scala 101:16]
  wire [63:0] _alu_op2_T_5 = _alu_op2_T_2 ? imm_s_sext : _alu_op2_T_4; // @[Mux.scala 101:16]
  wire [63:0] _alu_op2_T_6 = _alu_op2_T_1 ? imm_i_sext : _alu_op2_T_5; // @[Mux.scala 101:16]
  wire [63:0] _alu_op2_T_7 = _alu_op2_T ? rs2_data : _alu_op2_T_6; // @[Mux.scala 101:16]
  wire [63:0] alu_op2 = _alu_op2_T_7 & alu_msk; // @[EXU.scala 97:27]
  wire [63:0] _alu_out_aux_T_2 = alu_op1 + alu_op2; // @[EXU.scala 106:57]
  wire  _alu_out_aux_T_3 = io_idu_to_exu_alu_op == 4'h2; // @[EXU.scala 107:29]
  wire [63:0] _alu_out_aux_T_5 = alu_op1 - alu_op2; // @[EXU.scala 107:57]
  wire  _alu_out_aux_T_6 = io_idu_to_exu_alu_op == 4'h3; // @[EXU.scala 108:29]
  wire [127:0] _alu_out_aux_T_7 = alu_op1 * alu_op2; // @[EXU.scala 108:57]
  wire  _alu_out_aux_T_8 = io_idu_to_exu_alu_op == 4'h4; // @[EXU.scala 109:29]
  wire [63:0] _alu_out_aux_T_9 = alu_op1 / alu_op2; // @[EXU.scala 109:57]
  wire  _alu_out_aux_T_10 = io_idu_to_exu_alu_op == 4'h5; // @[EXU.scala 110:29]
  wire [63:0] _alu_out_aux_T_11 = alu_op1 % alu_op2; // @[EXU.scala 110:57]
  wire  _alu_out_aux_T_12 = io_idu_to_exu_alu_op == 4'hc; // @[EXU.scala 111:29]
  wire [63:0] _alu_out_aux_T_13 = _alu_op1_T_3 & alu_msk; // @[EXU.scala 111:57]
  wire [63:0] _alu_out_aux_T_14 = _alu_op2_T_7 & alu_msk; // @[EXU.scala 111:74]
  wire  _alu_out_aux_T_15 = $signed(_alu_out_aux_T_13) < $signed(_alu_out_aux_T_14); // @[EXU.scala 111:64]
  wire  _alu_out_aux_T_16 = io_idu_to_exu_alu_op == 4'hd; // @[EXU.scala 112:29]
  wire  _alu_out_aux_T_17 = alu_op1 < alu_op2; // @[EXU.scala 112:57]
  wire  _alu_out_aux_T_18 = io_idu_to_exu_alu_op == 4'h6; // @[EXU.scala 113:29]
  wire [5:0] alu_shamt = io_idu_to_exu_alu_msk_type ? {{1'd0}, alu_op2[4:0]} : alu_op2[5:0]; // @[EXU.scala 101:22]
  wire [126:0] _GEN_128 = {{63'd0}, alu_op1}; // @[EXU.scala 113:57]
  wire [126:0] _alu_out_aux_T_19 = _GEN_128 << alu_shamt; // @[EXU.scala 113:57]
  wire  _alu_out_aux_T_20 = io_idu_to_exu_alu_op == 4'h7; // @[EXU.scala 114:29]
  wire [63:0] _alu_out_aux_T_21 = alu_op1 >> alu_shamt; // @[EXU.scala 114:57]
  wire  _alu_out_aux_T_22 = io_idu_to_exu_alu_op == 4'h8; // @[EXU.scala 115:29]
  wire  _alu_out_aux_T_24 = io_idu_to_exu_alu_op == 4'h8 & ~io_idu_to_exu_alu_msk_type; // @[EXU.scala 115:41]
  wire [63:0] _alu_out_aux_T_27 = $signed(_alu_out_aux_T_13) >>> alu_shamt; // @[EXU.scala 115:128]
  wire  _alu_out_aux_T_30 = _alu_out_aux_T_22 & io_idu_to_exu_alu_msk_type; // @[EXU.scala 116:41]
  wire [31:0] _alu_out_aux_T_32 = alu_op1[31:0]; // @[EXU.scala 116:108]
  wire [31:0] _alu_out_aux_T_34 = $signed(_alu_out_aux_T_32) >>> alu_shamt; // @[EXU.scala 116:135]
  wire  _alu_out_aux_T_35 = io_idu_to_exu_alu_op == 4'h9; // @[EXU.scala 117:29]
  wire [63:0] _alu_out_aux_T_36 = alu_op1 & alu_op2; // @[EXU.scala 117:57]
  wire  _alu_out_aux_T_37 = io_idu_to_exu_alu_op == 4'ha; // @[EXU.scala 118:29]
  wire [63:0] _alu_out_aux_T_38 = alu_op1 | alu_op2; // @[EXU.scala 118:57]
  wire  _alu_out_aux_T_39 = io_idu_to_exu_alu_op == 4'hb; // @[EXU.scala 119:29]
  wire [63:0] _alu_out_aux_T_40 = alu_op1 ^ alu_op2; // @[EXU.scala 119:57]
  wire [63:0] _alu_out_aux_T_41 = _alu_out_aux_T_39 ? _alu_out_aux_T_40 : 64'h0; // @[Mux.scala 101:16]
  wire [63:0] _alu_out_aux_T_42 = _alu_out_aux_T_37 ? _alu_out_aux_T_38 : _alu_out_aux_T_41; // @[Mux.scala 101:16]
  wire [63:0] _alu_out_aux_T_43 = _alu_out_aux_T_35 ? _alu_out_aux_T_36 : _alu_out_aux_T_42; // @[Mux.scala 101:16]
  wire [63:0] _alu_out_aux_T_44 = _alu_out_aux_T_30 ? {{32'd0}, _alu_out_aux_T_34} : _alu_out_aux_T_43; // @[Mux.scala 101:16]
  wire [63:0] _alu_out_aux_T_45 = _alu_out_aux_T_24 ? _alu_out_aux_T_27 : _alu_out_aux_T_44; // @[Mux.scala 101:16]
  wire [63:0] _alu_out_aux_T_46 = _alu_out_aux_T_20 ? _alu_out_aux_T_21 : _alu_out_aux_T_45; // @[Mux.scala 101:16]
  wire [126:0] _alu_out_aux_T_47 = _alu_out_aux_T_18 ? _alu_out_aux_T_19 : {{63'd0}, _alu_out_aux_T_46}; // @[Mux.scala 101:16]
  wire [126:0] _alu_out_aux_T_48 = _alu_out_aux_T_16 ? {{126'd0}, _alu_out_aux_T_17} : _alu_out_aux_T_47; // @[Mux.scala 101:16]
  wire [126:0] _alu_out_aux_T_49 = _alu_out_aux_T_12 ? {{126'd0}, _alu_out_aux_T_15} : _alu_out_aux_T_48; // @[Mux.scala 101:16]
  wire [126:0] _alu_out_aux_T_50 = _alu_out_aux_T_10 ? {{63'd0}, _alu_out_aux_T_11} : _alu_out_aux_T_49; // @[Mux.scala 101:16]
  wire [126:0] _alu_out_aux_T_51 = _alu_out_aux_T_8 ? {{63'd0}, _alu_out_aux_T_9} : _alu_out_aux_T_50; // @[Mux.scala 101:16]
  wire [127:0] _alu_out_aux_T_52 = _alu_out_aux_T_6 ? _alu_out_aux_T_7 : {{1'd0}, _alu_out_aux_T_51}; // @[Mux.scala 101:16]
  wire [127:0] _alu_out_aux_T_53 = _alu_out_aux_T_3 ? {{64'd0}, _alu_out_aux_T_5} : _alu_out_aux_T_52; // @[Mux.scala 101:16]
  wire [127:0] _alu_out_aux_T_54 = _alu_out_aux_T ? {{64'd0}, _alu_out_aux_T_2} : _alu_out_aux_T_53; // @[Mux.scala 101:16]
  wire [63:0] alu_out_aux = _alu_out_aux_T_54[63:0]; // @[EXU.scala 103:25 104:15]
  wire [31:0] _alu_out_T_3 = alu_out_aux[31] ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _alu_out_T_5 = {_alu_out_T_3,alu_out_aux[31:0]}; // @[Cat.scala 33:92]
  wire [63:0] alu_out = io_idu_to_exu_alu_msk_type ? _alu_out_T_5 : alu_out_aux; // @[Mux.scala 101:16]
  wire  _wb_data_T_1 = io_idu_to_exu_wb_sel == 2'h1; // @[EXU.scala 196:38]
  wire  _mem_in_result_T = io_idu_to_exu_mem_msk_type == 3'h4; // @[EXU.scala 183:33]
  wire [63:0] _mem_in_sel_T_9 = 3'h1 == io_mem_addr[2:0] ? {{8'd0}, io_mem_in[63:8]} : io_mem_in; // @[Mux.scala 81:58]
  wire [63:0] _mem_in_sel_T_11 = 3'h2 == io_mem_addr[2:0] ? {{16'd0}, io_mem_in[63:16]} : _mem_in_sel_T_9; // @[Mux.scala 81:58]
  wire [63:0] _mem_in_sel_T_13 = 3'h3 == io_mem_addr[2:0] ? {{24'd0}, io_mem_in[63:24]} : _mem_in_sel_T_11; // @[Mux.scala 81:58]
  wire [63:0] _mem_in_sel_T_15 = 3'h4 == io_mem_addr[2:0] ? {{32'd0}, io_mem_in[63:32]} : _mem_in_sel_T_13; // @[Mux.scala 81:58]
  wire [63:0] _mem_in_sel_T_17 = 3'h5 == io_mem_addr[2:0] ? {{40'd0}, io_mem_in[63:40]} : _mem_in_sel_T_15; // @[Mux.scala 81:58]
  wire [63:0] _mem_in_sel_T_19 = 3'h6 == io_mem_addr[2:0] ? {{48'd0}, io_mem_in[63:48]} : _mem_in_sel_T_17; // @[Mux.scala 81:58]
  wire [63:0] mem_in_sel = 3'h7 == io_mem_addr[2:0] ? {{56'd0}, io_mem_in[63:56]} : _mem_in_sel_T_19; // @[Mux.scala 81:58]
  wire [31:0] _mem_in_result_T_3 = mem_in_sel[31] ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _mem_in_result_T_5 = {_mem_in_result_T_3,mem_in_sel[31:0]}; // @[Cat.scala 33:92]
  wire  _mem_in_result_T_6 = io_idu_to_exu_mem_msk_type == 3'h5; // @[EXU.scala 184:33]
  wire [63:0] _mem_in_result_T_9 = {32'h0,mem_in_sel[31:0]}; // @[Cat.scala 33:92]
  wire  _mem_in_result_T_10 = io_idu_to_exu_mem_msk_type == 3'h2; // @[EXU.scala 185:33]
  wire [47:0] _mem_in_result_T_13 = mem_in_sel[15] ? 48'hffffffffffff : 48'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _mem_in_result_T_15 = {_mem_in_result_T_13,mem_in_sel[15:0]}; // @[Cat.scala 33:92]
  wire  _mem_in_result_T_16 = io_idu_to_exu_mem_msk_type == 3'h3; // @[EXU.scala 186:33]
  wire [63:0] _mem_in_result_T_19 = {48'h0,mem_in_sel[15:0]}; // @[Cat.scala 33:92]
  wire  _mem_in_result_T_20 = io_idu_to_exu_mem_msk_type == 3'h0; // @[EXU.scala 187:33]
  wire [55:0] _mem_in_result_T_23 = mem_in_sel[7] ? 56'hffffffffffffff : 56'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _mem_in_result_T_25 = {_mem_in_result_T_23,mem_in_sel[7:0]}; // @[Cat.scala 33:92]
  wire  _mem_in_result_T_26 = io_idu_to_exu_mem_msk_type == 3'h1; // @[EXU.scala 188:33]
  wire [63:0] _mem_in_result_T_29 = {56'h0,mem_in_sel[7:0]}; // @[Cat.scala 33:92]
  wire [63:0] _mem_in_result_T_30 = _mem_in_result_T_26 ? _mem_in_result_T_29 : mem_in_sel; // @[Mux.scala 101:16]
  wire [63:0] _mem_in_result_T_31 = _mem_in_result_T_20 ? _mem_in_result_T_25 : _mem_in_result_T_30; // @[Mux.scala 101:16]
  wire [63:0] _mem_in_result_T_32 = _mem_in_result_T_16 ? _mem_in_result_T_19 : _mem_in_result_T_31; // @[Mux.scala 101:16]
  wire [63:0] _mem_in_result_T_33 = _mem_in_result_T_10 ? _mem_in_result_T_15 : _mem_in_result_T_32; // @[Mux.scala 101:16]
  wire [63:0] _mem_in_result_T_34 = _mem_in_result_T_6 ? _mem_in_result_T_9 : _mem_in_result_T_33; // @[Mux.scala 101:16]
  wire [63:0] mem_in_result = _mem_in_result_T ? _mem_in_result_T_5 : _mem_in_result_T_34; // @[Mux.scala 101:16]
  wire  _wb_data_T_2 = io_idu_to_exu_wb_sel == 2'h2; // @[EXU.scala 197:38]
  wire [63:0] _pc_plus4_T_1 = io_ifu_to_exu_pc + 64'h4; // @[EXU.scala 144:35]
  wire [31:0] pc_plus4 = _pc_plus4_T_1[31:0]; // @[EXU.scala 138:30 144:14]
  wire [63:0] _wb_data_T_3 = _wb_data_T_2 ? {{32'd0}, pc_plus4} : alu_out; // @[Mux.scala 101:16]
  wire [63:0] _wb_data_T_4 = _wb_data_T_1 ? mem_in_result : _wb_data_T_3; // @[Mux.scala 101:16]
  wire  regfile_output_aux_0 = regfile_0[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1 = regfile_0[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2 = regfile_0[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_3 = regfile_0[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_4 = regfile_0[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_5 = regfile_0[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_6 = regfile_0[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_7 = regfile_0[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_8 = regfile_0[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_9 = regfile_0[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_10 = regfile_0[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_11 = regfile_0[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_12 = regfile_0[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_13 = regfile_0[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_14 = regfile_0[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_15 = regfile_0[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_16 = regfile_0[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_17 = regfile_0[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_18 = regfile_0[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_19 = regfile_0[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_20 = regfile_0[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_21 = regfile_0[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_22 = regfile_0[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_23 = regfile_0[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_24 = regfile_0[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_25 = regfile_0[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_26 = regfile_0[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_27 = regfile_0[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_28 = regfile_0[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_29 = regfile_0[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_30 = regfile_0[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_31 = regfile_0[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_32 = regfile_0[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_33 = regfile_0[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_34 = regfile_0[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_35 = regfile_0[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_36 = regfile_0[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_37 = regfile_0[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_38 = regfile_0[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_39 = regfile_0[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_40 = regfile_0[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_41 = regfile_0[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_42 = regfile_0[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_43 = regfile_0[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_44 = regfile_0[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_45 = regfile_0[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_46 = regfile_0[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_47 = regfile_0[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_48 = regfile_0[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_49 = regfile_0[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_50 = regfile_0[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_51 = regfile_0[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_52 = regfile_0[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_53 = regfile_0[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_54 = regfile_0[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_55 = regfile_0[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_56 = regfile_0[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_57 = regfile_0[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_58 = regfile_0[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_59 = regfile_0[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_60 = regfile_0[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_61 = regfile_0[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_62 = regfile_0[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_63 = regfile_0[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_64 = regfile_1[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_65 = regfile_1[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_66 = regfile_1[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_67 = regfile_1[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_68 = regfile_1[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_69 = regfile_1[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_70 = regfile_1[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_71 = regfile_1[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_72 = regfile_1[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_73 = regfile_1[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_74 = regfile_1[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_75 = regfile_1[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_76 = regfile_1[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_77 = regfile_1[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_78 = regfile_1[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_79 = regfile_1[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_80 = regfile_1[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_81 = regfile_1[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_82 = regfile_1[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_83 = regfile_1[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_84 = regfile_1[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_85 = regfile_1[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_86 = regfile_1[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_87 = regfile_1[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_88 = regfile_1[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_89 = regfile_1[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_90 = regfile_1[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_91 = regfile_1[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_92 = regfile_1[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_93 = regfile_1[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_94 = regfile_1[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_95 = regfile_1[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_96 = regfile_1[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_97 = regfile_1[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_98 = regfile_1[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_99 = regfile_1[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_100 = regfile_1[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_101 = regfile_1[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_102 = regfile_1[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_103 = regfile_1[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_104 = regfile_1[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_105 = regfile_1[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_106 = regfile_1[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_107 = regfile_1[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_108 = regfile_1[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_109 = regfile_1[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_110 = regfile_1[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_111 = regfile_1[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_112 = regfile_1[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_113 = regfile_1[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_114 = regfile_1[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_115 = regfile_1[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_116 = regfile_1[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_117 = regfile_1[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_118 = regfile_1[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_119 = regfile_1[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_120 = regfile_1[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_121 = regfile_1[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_122 = regfile_1[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_123 = regfile_1[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_124 = regfile_1[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_125 = regfile_1[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_126 = regfile_1[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_127 = regfile_1[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_128 = regfile_2[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_129 = regfile_2[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_130 = regfile_2[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_131 = regfile_2[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_132 = regfile_2[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_133 = regfile_2[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_134 = regfile_2[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_135 = regfile_2[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_136 = regfile_2[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_137 = regfile_2[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_138 = regfile_2[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_139 = regfile_2[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_140 = regfile_2[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_141 = regfile_2[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_142 = regfile_2[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_143 = regfile_2[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_144 = regfile_2[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_145 = regfile_2[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_146 = regfile_2[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_147 = regfile_2[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_148 = regfile_2[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_149 = regfile_2[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_150 = regfile_2[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_151 = regfile_2[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_152 = regfile_2[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_153 = regfile_2[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_154 = regfile_2[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_155 = regfile_2[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_156 = regfile_2[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_157 = regfile_2[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_158 = regfile_2[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_159 = regfile_2[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_160 = regfile_2[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_161 = regfile_2[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_162 = regfile_2[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_163 = regfile_2[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_164 = regfile_2[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_165 = regfile_2[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_166 = regfile_2[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_167 = regfile_2[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_168 = regfile_2[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_169 = regfile_2[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_170 = regfile_2[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_171 = regfile_2[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_172 = regfile_2[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_173 = regfile_2[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_174 = regfile_2[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_175 = regfile_2[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_176 = regfile_2[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_177 = regfile_2[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_178 = regfile_2[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_179 = regfile_2[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_180 = regfile_2[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_181 = regfile_2[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_182 = regfile_2[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_183 = regfile_2[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_184 = regfile_2[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_185 = regfile_2[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_186 = regfile_2[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_187 = regfile_2[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_188 = regfile_2[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_189 = regfile_2[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_190 = regfile_2[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_191 = regfile_2[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_192 = regfile_3[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_193 = regfile_3[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_194 = regfile_3[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_195 = regfile_3[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_196 = regfile_3[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_197 = regfile_3[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_198 = regfile_3[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_199 = regfile_3[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_200 = regfile_3[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_201 = regfile_3[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_202 = regfile_3[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_203 = regfile_3[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_204 = regfile_3[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_205 = regfile_3[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_206 = regfile_3[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_207 = regfile_3[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_208 = regfile_3[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_209 = regfile_3[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_210 = regfile_3[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_211 = regfile_3[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_212 = regfile_3[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_213 = regfile_3[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_214 = regfile_3[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_215 = regfile_3[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_216 = regfile_3[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_217 = regfile_3[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_218 = regfile_3[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_219 = regfile_3[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_220 = regfile_3[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_221 = regfile_3[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_222 = regfile_3[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_223 = regfile_3[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_224 = regfile_3[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_225 = regfile_3[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_226 = regfile_3[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_227 = regfile_3[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_228 = regfile_3[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_229 = regfile_3[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_230 = regfile_3[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_231 = regfile_3[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_232 = regfile_3[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_233 = regfile_3[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_234 = regfile_3[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_235 = regfile_3[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_236 = regfile_3[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_237 = regfile_3[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_238 = regfile_3[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_239 = regfile_3[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_240 = regfile_3[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_241 = regfile_3[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_242 = regfile_3[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_243 = regfile_3[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_244 = regfile_3[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_245 = regfile_3[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_246 = regfile_3[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_247 = regfile_3[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_248 = regfile_3[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_249 = regfile_3[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_250 = regfile_3[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_251 = regfile_3[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_252 = regfile_3[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_253 = regfile_3[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_254 = regfile_3[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_255 = regfile_3[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_256 = regfile_4[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_257 = regfile_4[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_258 = regfile_4[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_259 = regfile_4[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_260 = regfile_4[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_261 = regfile_4[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_262 = regfile_4[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_263 = regfile_4[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_264 = regfile_4[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_265 = regfile_4[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_266 = regfile_4[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_267 = regfile_4[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_268 = regfile_4[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_269 = regfile_4[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_270 = regfile_4[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_271 = regfile_4[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_272 = regfile_4[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_273 = regfile_4[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_274 = regfile_4[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_275 = regfile_4[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_276 = regfile_4[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_277 = regfile_4[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_278 = regfile_4[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_279 = regfile_4[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_280 = regfile_4[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_281 = regfile_4[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_282 = regfile_4[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_283 = regfile_4[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_284 = regfile_4[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_285 = regfile_4[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_286 = regfile_4[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_287 = regfile_4[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_288 = regfile_4[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_289 = regfile_4[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_290 = regfile_4[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_291 = regfile_4[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_292 = regfile_4[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_293 = regfile_4[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_294 = regfile_4[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_295 = regfile_4[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_296 = regfile_4[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_297 = regfile_4[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_298 = regfile_4[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_299 = regfile_4[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_300 = regfile_4[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_301 = regfile_4[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_302 = regfile_4[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_303 = regfile_4[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_304 = regfile_4[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_305 = regfile_4[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_306 = regfile_4[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_307 = regfile_4[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_308 = regfile_4[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_309 = regfile_4[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_310 = regfile_4[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_311 = regfile_4[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_312 = regfile_4[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_313 = regfile_4[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_314 = regfile_4[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_315 = regfile_4[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_316 = regfile_4[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_317 = regfile_4[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_318 = regfile_4[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_319 = regfile_4[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_320 = regfile_5[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_321 = regfile_5[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_322 = regfile_5[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_323 = regfile_5[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_324 = regfile_5[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_325 = regfile_5[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_326 = regfile_5[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_327 = regfile_5[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_328 = regfile_5[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_329 = regfile_5[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_330 = regfile_5[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_331 = regfile_5[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_332 = regfile_5[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_333 = regfile_5[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_334 = regfile_5[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_335 = regfile_5[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_336 = regfile_5[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_337 = regfile_5[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_338 = regfile_5[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_339 = regfile_5[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_340 = regfile_5[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_341 = regfile_5[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_342 = regfile_5[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_343 = regfile_5[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_344 = regfile_5[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_345 = regfile_5[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_346 = regfile_5[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_347 = regfile_5[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_348 = regfile_5[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_349 = regfile_5[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_350 = regfile_5[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_351 = regfile_5[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_352 = regfile_5[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_353 = regfile_5[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_354 = regfile_5[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_355 = regfile_5[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_356 = regfile_5[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_357 = regfile_5[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_358 = regfile_5[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_359 = regfile_5[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_360 = regfile_5[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_361 = regfile_5[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_362 = regfile_5[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_363 = regfile_5[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_364 = regfile_5[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_365 = regfile_5[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_366 = regfile_5[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_367 = regfile_5[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_368 = regfile_5[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_369 = regfile_5[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_370 = regfile_5[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_371 = regfile_5[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_372 = regfile_5[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_373 = regfile_5[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_374 = regfile_5[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_375 = regfile_5[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_376 = regfile_5[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_377 = regfile_5[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_378 = regfile_5[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_379 = regfile_5[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_380 = regfile_5[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_381 = regfile_5[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_382 = regfile_5[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_383 = regfile_5[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_384 = regfile_6[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_385 = regfile_6[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_386 = regfile_6[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_387 = regfile_6[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_388 = regfile_6[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_389 = regfile_6[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_390 = regfile_6[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_391 = regfile_6[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_392 = regfile_6[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_393 = regfile_6[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_394 = regfile_6[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_395 = regfile_6[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_396 = regfile_6[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_397 = regfile_6[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_398 = regfile_6[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_399 = regfile_6[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_400 = regfile_6[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_401 = regfile_6[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_402 = regfile_6[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_403 = regfile_6[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_404 = regfile_6[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_405 = regfile_6[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_406 = regfile_6[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_407 = regfile_6[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_408 = regfile_6[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_409 = regfile_6[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_410 = regfile_6[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_411 = regfile_6[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_412 = regfile_6[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_413 = regfile_6[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_414 = regfile_6[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_415 = regfile_6[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_416 = regfile_6[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_417 = regfile_6[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_418 = regfile_6[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_419 = regfile_6[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_420 = regfile_6[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_421 = regfile_6[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_422 = regfile_6[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_423 = regfile_6[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_424 = regfile_6[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_425 = regfile_6[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_426 = regfile_6[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_427 = regfile_6[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_428 = regfile_6[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_429 = regfile_6[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_430 = regfile_6[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_431 = regfile_6[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_432 = regfile_6[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_433 = regfile_6[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_434 = regfile_6[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_435 = regfile_6[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_436 = regfile_6[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_437 = regfile_6[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_438 = regfile_6[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_439 = regfile_6[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_440 = regfile_6[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_441 = regfile_6[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_442 = regfile_6[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_443 = regfile_6[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_444 = regfile_6[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_445 = regfile_6[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_446 = regfile_6[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_447 = regfile_6[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_448 = regfile_7[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_449 = regfile_7[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_450 = regfile_7[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_451 = regfile_7[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_452 = regfile_7[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_453 = regfile_7[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_454 = regfile_7[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_455 = regfile_7[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_456 = regfile_7[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_457 = regfile_7[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_458 = regfile_7[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_459 = regfile_7[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_460 = regfile_7[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_461 = regfile_7[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_462 = regfile_7[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_463 = regfile_7[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_464 = regfile_7[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_465 = regfile_7[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_466 = regfile_7[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_467 = regfile_7[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_468 = regfile_7[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_469 = regfile_7[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_470 = regfile_7[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_471 = regfile_7[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_472 = regfile_7[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_473 = regfile_7[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_474 = regfile_7[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_475 = regfile_7[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_476 = regfile_7[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_477 = regfile_7[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_478 = regfile_7[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_479 = regfile_7[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_480 = regfile_7[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_481 = regfile_7[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_482 = regfile_7[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_483 = regfile_7[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_484 = regfile_7[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_485 = regfile_7[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_486 = regfile_7[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_487 = regfile_7[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_488 = regfile_7[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_489 = regfile_7[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_490 = regfile_7[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_491 = regfile_7[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_492 = regfile_7[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_493 = regfile_7[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_494 = regfile_7[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_495 = regfile_7[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_496 = regfile_7[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_497 = regfile_7[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_498 = regfile_7[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_499 = regfile_7[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_500 = regfile_7[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_501 = regfile_7[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_502 = regfile_7[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_503 = regfile_7[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_504 = regfile_7[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_505 = regfile_7[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_506 = regfile_7[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_507 = regfile_7[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_508 = regfile_7[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_509 = regfile_7[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_510 = regfile_7[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_511 = regfile_7[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_512 = regfile_8[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_513 = regfile_8[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_514 = regfile_8[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_515 = regfile_8[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_516 = regfile_8[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_517 = regfile_8[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_518 = regfile_8[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_519 = regfile_8[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_520 = regfile_8[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_521 = regfile_8[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_522 = regfile_8[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_523 = regfile_8[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_524 = regfile_8[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_525 = regfile_8[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_526 = regfile_8[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_527 = regfile_8[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_528 = regfile_8[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_529 = regfile_8[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_530 = regfile_8[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_531 = regfile_8[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_532 = regfile_8[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_533 = regfile_8[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_534 = regfile_8[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_535 = regfile_8[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_536 = regfile_8[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_537 = regfile_8[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_538 = regfile_8[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_539 = regfile_8[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_540 = regfile_8[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_541 = regfile_8[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_542 = regfile_8[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_543 = regfile_8[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_544 = regfile_8[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_545 = regfile_8[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_546 = regfile_8[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_547 = regfile_8[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_548 = regfile_8[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_549 = regfile_8[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_550 = regfile_8[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_551 = regfile_8[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_552 = regfile_8[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_553 = regfile_8[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_554 = regfile_8[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_555 = regfile_8[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_556 = regfile_8[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_557 = regfile_8[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_558 = regfile_8[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_559 = regfile_8[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_560 = regfile_8[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_561 = regfile_8[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_562 = regfile_8[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_563 = regfile_8[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_564 = regfile_8[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_565 = regfile_8[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_566 = regfile_8[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_567 = regfile_8[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_568 = regfile_8[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_569 = regfile_8[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_570 = regfile_8[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_571 = regfile_8[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_572 = regfile_8[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_573 = regfile_8[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_574 = regfile_8[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_575 = regfile_8[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_576 = regfile_9[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_577 = regfile_9[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_578 = regfile_9[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_579 = regfile_9[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_580 = regfile_9[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_581 = regfile_9[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_582 = regfile_9[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_583 = regfile_9[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_584 = regfile_9[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_585 = regfile_9[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_586 = regfile_9[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_587 = regfile_9[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_588 = regfile_9[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_589 = regfile_9[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_590 = regfile_9[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_591 = regfile_9[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_592 = regfile_9[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_593 = regfile_9[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_594 = regfile_9[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_595 = regfile_9[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_596 = regfile_9[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_597 = regfile_9[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_598 = regfile_9[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_599 = regfile_9[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_600 = regfile_9[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_601 = regfile_9[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_602 = regfile_9[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_603 = regfile_9[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_604 = regfile_9[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_605 = regfile_9[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_606 = regfile_9[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_607 = regfile_9[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_608 = regfile_9[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_609 = regfile_9[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_610 = regfile_9[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_611 = regfile_9[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_612 = regfile_9[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_613 = regfile_9[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_614 = regfile_9[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_615 = regfile_9[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_616 = regfile_9[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_617 = regfile_9[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_618 = regfile_9[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_619 = regfile_9[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_620 = regfile_9[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_621 = regfile_9[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_622 = regfile_9[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_623 = regfile_9[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_624 = regfile_9[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_625 = regfile_9[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_626 = regfile_9[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_627 = regfile_9[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_628 = regfile_9[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_629 = regfile_9[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_630 = regfile_9[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_631 = regfile_9[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_632 = regfile_9[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_633 = regfile_9[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_634 = regfile_9[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_635 = regfile_9[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_636 = regfile_9[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_637 = regfile_9[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_638 = regfile_9[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_639 = regfile_9[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_640 = regfile_10[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_641 = regfile_10[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_642 = regfile_10[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_643 = regfile_10[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_644 = regfile_10[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_645 = regfile_10[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_646 = regfile_10[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_647 = regfile_10[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_648 = regfile_10[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_649 = regfile_10[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_650 = regfile_10[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_651 = regfile_10[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_652 = regfile_10[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_653 = regfile_10[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_654 = regfile_10[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_655 = regfile_10[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_656 = regfile_10[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_657 = regfile_10[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_658 = regfile_10[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_659 = regfile_10[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_660 = regfile_10[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_661 = regfile_10[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_662 = regfile_10[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_663 = regfile_10[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_664 = regfile_10[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_665 = regfile_10[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_666 = regfile_10[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_667 = regfile_10[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_668 = regfile_10[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_669 = regfile_10[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_670 = regfile_10[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_671 = regfile_10[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_672 = regfile_10[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_673 = regfile_10[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_674 = regfile_10[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_675 = regfile_10[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_676 = regfile_10[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_677 = regfile_10[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_678 = regfile_10[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_679 = regfile_10[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_680 = regfile_10[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_681 = regfile_10[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_682 = regfile_10[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_683 = regfile_10[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_684 = regfile_10[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_685 = regfile_10[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_686 = regfile_10[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_687 = regfile_10[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_688 = regfile_10[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_689 = regfile_10[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_690 = regfile_10[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_691 = regfile_10[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_692 = regfile_10[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_693 = regfile_10[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_694 = regfile_10[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_695 = regfile_10[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_696 = regfile_10[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_697 = regfile_10[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_698 = regfile_10[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_699 = regfile_10[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_700 = regfile_10[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_701 = regfile_10[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_702 = regfile_10[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_703 = regfile_10[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_704 = regfile_11[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_705 = regfile_11[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_706 = regfile_11[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_707 = regfile_11[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_708 = regfile_11[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_709 = regfile_11[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_710 = regfile_11[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_711 = regfile_11[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_712 = regfile_11[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_713 = regfile_11[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_714 = regfile_11[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_715 = regfile_11[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_716 = regfile_11[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_717 = regfile_11[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_718 = regfile_11[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_719 = regfile_11[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_720 = regfile_11[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_721 = regfile_11[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_722 = regfile_11[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_723 = regfile_11[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_724 = regfile_11[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_725 = regfile_11[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_726 = regfile_11[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_727 = regfile_11[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_728 = regfile_11[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_729 = regfile_11[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_730 = regfile_11[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_731 = regfile_11[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_732 = regfile_11[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_733 = regfile_11[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_734 = regfile_11[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_735 = regfile_11[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_736 = regfile_11[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_737 = regfile_11[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_738 = regfile_11[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_739 = regfile_11[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_740 = regfile_11[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_741 = regfile_11[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_742 = regfile_11[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_743 = regfile_11[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_744 = regfile_11[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_745 = regfile_11[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_746 = regfile_11[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_747 = regfile_11[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_748 = regfile_11[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_749 = regfile_11[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_750 = regfile_11[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_751 = regfile_11[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_752 = regfile_11[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_753 = regfile_11[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_754 = regfile_11[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_755 = regfile_11[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_756 = regfile_11[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_757 = regfile_11[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_758 = regfile_11[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_759 = regfile_11[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_760 = regfile_11[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_761 = regfile_11[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_762 = regfile_11[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_763 = regfile_11[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_764 = regfile_11[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_765 = regfile_11[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_766 = regfile_11[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_767 = regfile_11[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_768 = regfile_12[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_769 = regfile_12[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_770 = regfile_12[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_771 = regfile_12[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_772 = regfile_12[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_773 = regfile_12[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_774 = regfile_12[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_775 = regfile_12[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_776 = regfile_12[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_777 = regfile_12[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_778 = regfile_12[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_779 = regfile_12[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_780 = regfile_12[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_781 = regfile_12[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_782 = regfile_12[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_783 = regfile_12[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_784 = regfile_12[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_785 = regfile_12[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_786 = regfile_12[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_787 = regfile_12[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_788 = regfile_12[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_789 = regfile_12[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_790 = regfile_12[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_791 = regfile_12[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_792 = regfile_12[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_793 = regfile_12[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_794 = regfile_12[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_795 = regfile_12[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_796 = regfile_12[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_797 = regfile_12[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_798 = regfile_12[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_799 = regfile_12[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_800 = regfile_12[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_801 = regfile_12[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_802 = regfile_12[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_803 = regfile_12[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_804 = regfile_12[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_805 = regfile_12[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_806 = regfile_12[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_807 = regfile_12[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_808 = regfile_12[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_809 = regfile_12[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_810 = regfile_12[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_811 = regfile_12[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_812 = regfile_12[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_813 = regfile_12[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_814 = regfile_12[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_815 = regfile_12[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_816 = regfile_12[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_817 = regfile_12[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_818 = regfile_12[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_819 = regfile_12[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_820 = regfile_12[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_821 = regfile_12[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_822 = regfile_12[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_823 = regfile_12[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_824 = regfile_12[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_825 = regfile_12[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_826 = regfile_12[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_827 = regfile_12[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_828 = regfile_12[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_829 = regfile_12[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_830 = regfile_12[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_831 = regfile_12[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_832 = regfile_13[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_833 = regfile_13[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_834 = regfile_13[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_835 = regfile_13[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_836 = regfile_13[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_837 = regfile_13[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_838 = regfile_13[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_839 = regfile_13[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_840 = regfile_13[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_841 = regfile_13[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_842 = regfile_13[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_843 = regfile_13[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_844 = regfile_13[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_845 = regfile_13[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_846 = regfile_13[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_847 = regfile_13[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_848 = regfile_13[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_849 = regfile_13[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_850 = regfile_13[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_851 = regfile_13[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_852 = regfile_13[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_853 = regfile_13[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_854 = regfile_13[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_855 = regfile_13[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_856 = regfile_13[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_857 = regfile_13[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_858 = regfile_13[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_859 = regfile_13[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_860 = regfile_13[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_861 = regfile_13[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_862 = regfile_13[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_863 = regfile_13[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_864 = regfile_13[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_865 = regfile_13[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_866 = regfile_13[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_867 = regfile_13[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_868 = regfile_13[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_869 = regfile_13[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_870 = regfile_13[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_871 = regfile_13[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_872 = regfile_13[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_873 = regfile_13[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_874 = regfile_13[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_875 = regfile_13[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_876 = regfile_13[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_877 = regfile_13[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_878 = regfile_13[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_879 = regfile_13[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_880 = regfile_13[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_881 = regfile_13[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_882 = regfile_13[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_883 = regfile_13[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_884 = regfile_13[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_885 = regfile_13[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_886 = regfile_13[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_887 = regfile_13[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_888 = regfile_13[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_889 = regfile_13[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_890 = regfile_13[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_891 = regfile_13[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_892 = regfile_13[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_893 = regfile_13[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_894 = regfile_13[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_895 = regfile_13[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_896 = regfile_14[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_897 = regfile_14[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_898 = regfile_14[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_899 = regfile_14[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_900 = regfile_14[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_901 = regfile_14[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_902 = regfile_14[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_903 = regfile_14[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_904 = regfile_14[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_905 = regfile_14[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_906 = regfile_14[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_907 = regfile_14[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_908 = regfile_14[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_909 = regfile_14[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_910 = regfile_14[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_911 = regfile_14[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_912 = regfile_14[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_913 = regfile_14[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_914 = regfile_14[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_915 = regfile_14[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_916 = regfile_14[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_917 = regfile_14[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_918 = regfile_14[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_919 = regfile_14[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_920 = regfile_14[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_921 = regfile_14[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_922 = regfile_14[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_923 = regfile_14[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_924 = regfile_14[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_925 = regfile_14[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_926 = regfile_14[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_927 = regfile_14[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_928 = regfile_14[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_929 = regfile_14[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_930 = regfile_14[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_931 = regfile_14[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_932 = regfile_14[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_933 = regfile_14[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_934 = regfile_14[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_935 = regfile_14[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_936 = regfile_14[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_937 = regfile_14[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_938 = regfile_14[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_939 = regfile_14[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_940 = regfile_14[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_941 = regfile_14[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_942 = regfile_14[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_943 = regfile_14[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_944 = regfile_14[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_945 = regfile_14[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_946 = regfile_14[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_947 = regfile_14[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_948 = regfile_14[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_949 = regfile_14[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_950 = regfile_14[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_951 = regfile_14[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_952 = regfile_14[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_953 = regfile_14[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_954 = regfile_14[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_955 = regfile_14[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_956 = regfile_14[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_957 = regfile_14[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_958 = regfile_14[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_959 = regfile_14[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_960 = regfile_15[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_961 = regfile_15[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_962 = regfile_15[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_963 = regfile_15[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_964 = regfile_15[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_965 = regfile_15[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_966 = regfile_15[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_967 = regfile_15[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_968 = regfile_15[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_969 = regfile_15[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_970 = regfile_15[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_971 = regfile_15[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_972 = regfile_15[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_973 = regfile_15[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_974 = regfile_15[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_975 = regfile_15[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_976 = regfile_15[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_977 = regfile_15[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_978 = regfile_15[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_979 = regfile_15[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_980 = regfile_15[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_981 = regfile_15[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_982 = regfile_15[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_983 = regfile_15[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_984 = regfile_15[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_985 = regfile_15[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_986 = regfile_15[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_987 = regfile_15[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_988 = regfile_15[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_989 = regfile_15[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_990 = regfile_15[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_991 = regfile_15[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_992 = regfile_15[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_993 = regfile_15[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_994 = regfile_15[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_995 = regfile_15[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_996 = regfile_15[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_997 = regfile_15[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_998 = regfile_15[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_999 = regfile_15[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1000 = regfile_15[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1001 = regfile_15[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1002 = regfile_15[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1003 = regfile_15[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1004 = regfile_15[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1005 = regfile_15[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1006 = regfile_15[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1007 = regfile_15[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1008 = regfile_15[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1009 = regfile_15[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1010 = regfile_15[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1011 = regfile_15[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1012 = regfile_15[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1013 = regfile_15[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1014 = regfile_15[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1015 = regfile_15[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1016 = regfile_15[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1017 = regfile_15[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1018 = regfile_15[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1019 = regfile_15[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1020 = regfile_15[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1021 = regfile_15[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1022 = regfile_15[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1023 = regfile_15[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1024 = regfile_16[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1025 = regfile_16[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1026 = regfile_16[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1027 = regfile_16[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1028 = regfile_16[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1029 = regfile_16[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1030 = regfile_16[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1031 = regfile_16[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1032 = regfile_16[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1033 = regfile_16[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1034 = regfile_16[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1035 = regfile_16[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1036 = regfile_16[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1037 = regfile_16[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1038 = regfile_16[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1039 = regfile_16[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1040 = regfile_16[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1041 = regfile_16[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1042 = regfile_16[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1043 = regfile_16[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1044 = regfile_16[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1045 = regfile_16[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1046 = regfile_16[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1047 = regfile_16[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1048 = regfile_16[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1049 = regfile_16[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1050 = regfile_16[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1051 = regfile_16[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1052 = regfile_16[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1053 = regfile_16[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1054 = regfile_16[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1055 = regfile_16[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1056 = regfile_16[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1057 = regfile_16[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1058 = regfile_16[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1059 = regfile_16[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1060 = regfile_16[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1061 = regfile_16[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1062 = regfile_16[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1063 = regfile_16[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1064 = regfile_16[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1065 = regfile_16[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1066 = regfile_16[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1067 = regfile_16[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1068 = regfile_16[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1069 = regfile_16[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1070 = regfile_16[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1071 = regfile_16[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1072 = regfile_16[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1073 = regfile_16[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1074 = regfile_16[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1075 = regfile_16[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1076 = regfile_16[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1077 = regfile_16[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1078 = regfile_16[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1079 = regfile_16[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1080 = regfile_16[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1081 = regfile_16[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1082 = regfile_16[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1083 = regfile_16[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1084 = regfile_16[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1085 = regfile_16[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1086 = regfile_16[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1087 = regfile_16[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1088 = regfile_17[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1089 = regfile_17[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1090 = regfile_17[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1091 = regfile_17[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1092 = regfile_17[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1093 = regfile_17[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1094 = regfile_17[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1095 = regfile_17[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1096 = regfile_17[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1097 = regfile_17[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1098 = regfile_17[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1099 = regfile_17[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1100 = regfile_17[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1101 = regfile_17[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1102 = regfile_17[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1103 = regfile_17[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1104 = regfile_17[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1105 = regfile_17[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1106 = regfile_17[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1107 = regfile_17[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1108 = regfile_17[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1109 = regfile_17[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1110 = regfile_17[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1111 = regfile_17[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1112 = regfile_17[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1113 = regfile_17[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1114 = regfile_17[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1115 = regfile_17[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1116 = regfile_17[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1117 = regfile_17[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1118 = regfile_17[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1119 = regfile_17[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1120 = regfile_17[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1121 = regfile_17[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1122 = regfile_17[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1123 = regfile_17[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1124 = regfile_17[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1125 = regfile_17[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1126 = regfile_17[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1127 = regfile_17[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1128 = regfile_17[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1129 = regfile_17[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1130 = regfile_17[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1131 = regfile_17[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1132 = regfile_17[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1133 = regfile_17[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1134 = regfile_17[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1135 = regfile_17[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1136 = regfile_17[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1137 = regfile_17[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1138 = regfile_17[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1139 = regfile_17[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1140 = regfile_17[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1141 = regfile_17[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1142 = regfile_17[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1143 = regfile_17[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1144 = regfile_17[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1145 = regfile_17[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1146 = regfile_17[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1147 = regfile_17[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1148 = regfile_17[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1149 = regfile_17[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1150 = regfile_17[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1151 = regfile_17[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1152 = regfile_18[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1153 = regfile_18[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1154 = regfile_18[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1155 = regfile_18[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1156 = regfile_18[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1157 = regfile_18[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1158 = regfile_18[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1159 = regfile_18[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1160 = regfile_18[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1161 = regfile_18[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1162 = regfile_18[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1163 = regfile_18[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1164 = regfile_18[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1165 = regfile_18[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1166 = regfile_18[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1167 = regfile_18[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1168 = regfile_18[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1169 = regfile_18[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1170 = regfile_18[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1171 = regfile_18[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1172 = regfile_18[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1173 = regfile_18[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1174 = regfile_18[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1175 = regfile_18[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1176 = regfile_18[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1177 = regfile_18[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1178 = regfile_18[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1179 = regfile_18[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1180 = regfile_18[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1181 = regfile_18[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1182 = regfile_18[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1183 = regfile_18[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1184 = regfile_18[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1185 = regfile_18[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1186 = regfile_18[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1187 = regfile_18[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1188 = regfile_18[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1189 = regfile_18[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1190 = regfile_18[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1191 = regfile_18[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1192 = regfile_18[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1193 = regfile_18[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1194 = regfile_18[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1195 = regfile_18[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1196 = regfile_18[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1197 = regfile_18[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1198 = regfile_18[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1199 = regfile_18[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1200 = regfile_18[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1201 = regfile_18[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1202 = regfile_18[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1203 = regfile_18[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1204 = regfile_18[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1205 = regfile_18[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1206 = regfile_18[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1207 = regfile_18[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1208 = regfile_18[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1209 = regfile_18[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1210 = regfile_18[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1211 = regfile_18[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1212 = regfile_18[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1213 = regfile_18[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1214 = regfile_18[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1215 = regfile_18[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1216 = regfile_19[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1217 = regfile_19[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1218 = regfile_19[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1219 = regfile_19[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1220 = regfile_19[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1221 = regfile_19[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1222 = regfile_19[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1223 = regfile_19[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1224 = regfile_19[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1225 = regfile_19[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1226 = regfile_19[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1227 = regfile_19[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1228 = regfile_19[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1229 = regfile_19[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1230 = regfile_19[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1231 = regfile_19[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1232 = regfile_19[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1233 = regfile_19[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1234 = regfile_19[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1235 = regfile_19[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1236 = regfile_19[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1237 = regfile_19[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1238 = regfile_19[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1239 = regfile_19[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1240 = regfile_19[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1241 = regfile_19[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1242 = regfile_19[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1243 = regfile_19[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1244 = regfile_19[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1245 = regfile_19[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1246 = regfile_19[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1247 = regfile_19[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1248 = regfile_19[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1249 = regfile_19[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1250 = regfile_19[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1251 = regfile_19[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1252 = regfile_19[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1253 = regfile_19[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1254 = regfile_19[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1255 = regfile_19[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1256 = regfile_19[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1257 = regfile_19[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1258 = regfile_19[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1259 = regfile_19[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1260 = regfile_19[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1261 = regfile_19[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1262 = regfile_19[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1263 = regfile_19[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1264 = regfile_19[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1265 = regfile_19[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1266 = regfile_19[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1267 = regfile_19[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1268 = regfile_19[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1269 = regfile_19[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1270 = regfile_19[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1271 = regfile_19[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1272 = regfile_19[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1273 = regfile_19[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1274 = regfile_19[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1275 = regfile_19[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1276 = regfile_19[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1277 = regfile_19[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1278 = regfile_19[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1279 = regfile_19[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1280 = regfile_20[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1281 = regfile_20[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1282 = regfile_20[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1283 = regfile_20[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1284 = regfile_20[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1285 = regfile_20[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1286 = regfile_20[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1287 = regfile_20[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1288 = regfile_20[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1289 = regfile_20[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1290 = regfile_20[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1291 = regfile_20[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1292 = regfile_20[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1293 = regfile_20[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1294 = regfile_20[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1295 = regfile_20[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1296 = regfile_20[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1297 = regfile_20[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1298 = regfile_20[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1299 = regfile_20[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1300 = regfile_20[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1301 = regfile_20[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1302 = regfile_20[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1303 = regfile_20[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1304 = regfile_20[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1305 = regfile_20[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1306 = regfile_20[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1307 = regfile_20[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1308 = regfile_20[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1309 = regfile_20[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1310 = regfile_20[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1311 = regfile_20[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1312 = regfile_20[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1313 = regfile_20[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1314 = regfile_20[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1315 = regfile_20[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1316 = regfile_20[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1317 = regfile_20[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1318 = regfile_20[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1319 = regfile_20[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1320 = regfile_20[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1321 = regfile_20[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1322 = regfile_20[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1323 = regfile_20[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1324 = regfile_20[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1325 = regfile_20[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1326 = regfile_20[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1327 = regfile_20[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1328 = regfile_20[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1329 = regfile_20[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1330 = regfile_20[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1331 = regfile_20[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1332 = regfile_20[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1333 = regfile_20[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1334 = regfile_20[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1335 = regfile_20[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1336 = regfile_20[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1337 = regfile_20[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1338 = regfile_20[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1339 = regfile_20[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1340 = regfile_20[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1341 = regfile_20[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1342 = regfile_20[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1343 = regfile_20[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1344 = regfile_21[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1345 = regfile_21[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1346 = regfile_21[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1347 = regfile_21[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1348 = regfile_21[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1349 = regfile_21[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1350 = regfile_21[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1351 = regfile_21[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1352 = regfile_21[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1353 = regfile_21[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1354 = regfile_21[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1355 = regfile_21[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1356 = regfile_21[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1357 = regfile_21[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1358 = regfile_21[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1359 = regfile_21[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1360 = regfile_21[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1361 = regfile_21[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1362 = regfile_21[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1363 = regfile_21[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1364 = regfile_21[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1365 = regfile_21[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1366 = regfile_21[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1367 = regfile_21[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1368 = regfile_21[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1369 = regfile_21[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1370 = regfile_21[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1371 = regfile_21[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1372 = regfile_21[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1373 = regfile_21[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1374 = regfile_21[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1375 = regfile_21[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1376 = regfile_21[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1377 = regfile_21[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1378 = regfile_21[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1379 = regfile_21[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1380 = regfile_21[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1381 = regfile_21[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1382 = regfile_21[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1383 = regfile_21[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1384 = regfile_21[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1385 = regfile_21[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1386 = regfile_21[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1387 = regfile_21[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1388 = regfile_21[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1389 = regfile_21[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1390 = regfile_21[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1391 = regfile_21[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1392 = regfile_21[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1393 = regfile_21[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1394 = regfile_21[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1395 = regfile_21[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1396 = regfile_21[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1397 = regfile_21[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1398 = regfile_21[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1399 = regfile_21[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1400 = regfile_21[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1401 = regfile_21[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1402 = regfile_21[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1403 = regfile_21[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1404 = regfile_21[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1405 = regfile_21[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1406 = regfile_21[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1407 = regfile_21[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1408 = regfile_22[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1409 = regfile_22[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1410 = regfile_22[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1411 = regfile_22[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1412 = regfile_22[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1413 = regfile_22[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1414 = regfile_22[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1415 = regfile_22[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1416 = regfile_22[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1417 = regfile_22[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1418 = regfile_22[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1419 = regfile_22[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1420 = regfile_22[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1421 = regfile_22[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1422 = regfile_22[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1423 = regfile_22[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1424 = regfile_22[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1425 = regfile_22[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1426 = regfile_22[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1427 = regfile_22[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1428 = regfile_22[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1429 = regfile_22[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1430 = regfile_22[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1431 = regfile_22[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1432 = regfile_22[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1433 = regfile_22[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1434 = regfile_22[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1435 = regfile_22[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1436 = regfile_22[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1437 = regfile_22[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1438 = regfile_22[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1439 = regfile_22[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1440 = regfile_22[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1441 = regfile_22[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1442 = regfile_22[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1443 = regfile_22[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1444 = regfile_22[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1445 = regfile_22[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1446 = regfile_22[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1447 = regfile_22[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1448 = regfile_22[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1449 = regfile_22[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1450 = regfile_22[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1451 = regfile_22[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1452 = regfile_22[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1453 = regfile_22[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1454 = regfile_22[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1455 = regfile_22[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1456 = regfile_22[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1457 = regfile_22[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1458 = regfile_22[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1459 = regfile_22[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1460 = regfile_22[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1461 = regfile_22[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1462 = regfile_22[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1463 = regfile_22[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1464 = regfile_22[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1465 = regfile_22[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1466 = regfile_22[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1467 = regfile_22[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1468 = regfile_22[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1469 = regfile_22[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1470 = regfile_22[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1471 = regfile_22[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1472 = regfile_23[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1473 = regfile_23[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1474 = regfile_23[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1475 = regfile_23[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1476 = regfile_23[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1477 = regfile_23[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1478 = regfile_23[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1479 = regfile_23[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1480 = regfile_23[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1481 = regfile_23[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1482 = regfile_23[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1483 = regfile_23[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1484 = regfile_23[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1485 = regfile_23[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1486 = regfile_23[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1487 = regfile_23[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1488 = regfile_23[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1489 = regfile_23[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1490 = regfile_23[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1491 = regfile_23[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1492 = regfile_23[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1493 = regfile_23[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1494 = regfile_23[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1495 = regfile_23[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1496 = regfile_23[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1497 = regfile_23[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1498 = regfile_23[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1499 = regfile_23[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1500 = regfile_23[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1501 = regfile_23[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1502 = regfile_23[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1503 = regfile_23[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1504 = regfile_23[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1505 = regfile_23[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1506 = regfile_23[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1507 = regfile_23[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1508 = regfile_23[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1509 = regfile_23[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1510 = regfile_23[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1511 = regfile_23[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1512 = regfile_23[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1513 = regfile_23[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1514 = regfile_23[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1515 = regfile_23[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1516 = regfile_23[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1517 = regfile_23[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1518 = regfile_23[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1519 = regfile_23[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1520 = regfile_23[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1521 = regfile_23[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1522 = regfile_23[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1523 = regfile_23[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1524 = regfile_23[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1525 = regfile_23[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1526 = regfile_23[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1527 = regfile_23[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1528 = regfile_23[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1529 = regfile_23[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1530 = regfile_23[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1531 = regfile_23[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1532 = regfile_23[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1533 = regfile_23[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1534 = regfile_23[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1535 = regfile_23[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1536 = regfile_24[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1537 = regfile_24[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1538 = regfile_24[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1539 = regfile_24[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1540 = regfile_24[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1541 = regfile_24[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1542 = regfile_24[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1543 = regfile_24[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1544 = regfile_24[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1545 = regfile_24[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1546 = regfile_24[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1547 = regfile_24[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1548 = regfile_24[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1549 = regfile_24[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1550 = regfile_24[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1551 = regfile_24[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1552 = regfile_24[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1553 = regfile_24[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1554 = regfile_24[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1555 = regfile_24[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1556 = regfile_24[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1557 = regfile_24[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1558 = regfile_24[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1559 = regfile_24[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1560 = regfile_24[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1561 = regfile_24[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1562 = regfile_24[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1563 = regfile_24[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1564 = regfile_24[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1565 = regfile_24[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1566 = regfile_24[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1567 = regfile_24[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1568 = regfile_24[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1569 = regfile_24[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1570 = regfile_24[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1571 = regfile_24[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1572 = regfile_24[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1573 = regfile_24[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1574 = regfile_24[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1575 = regfile_24[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1576 = regfile_24[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1577 = regfile_24[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1578 = regfile_24[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1579 = regfile_24[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1580 = regfile_24[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1581 = regfile_24[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1582 = regfile_24[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1583 = regfile_24[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1584 = regfile_24[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1585 = regfile_24[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1586 = regfile_24[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1587 = regfile_24[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1588 = regfile_24[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1589 = regfile_24[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1590 = regfile_24[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1591 = regfile_24[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1592 = regfile_24[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1593 = regfile_24[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1594 = regfile_24[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1595 = regfile_24[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1596 = regfile_24[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1597 = regfile_24[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1598 = regfile_24[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1599 = regfile_24[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1600 = regfile_25[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1601 = regfile_25[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1602 = regfile_25[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1603 = regfile_25[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1604 = regfile_25[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1605 = regfile_25[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1606 = regfile_25[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1607 = regfile_25[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1608 = regfile_25[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1609 = regfile_25[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1610 = regfile_25[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1611 = regfile_25[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1612 = regfile_25[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1613 = regfile_25[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1614 = regfile_25[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1615 = regfile_25[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1616 = regfile_25[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1617 = regfile_25[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1618 = regfile_25[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1619 = regfile_25[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1620 = regfile_25[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1621 = regfile_25[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1622 = regfile_25[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1623 = regfile_25[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1624 = regfile_25[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1625 = regfile_25[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1626 = regfile_25[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1627 = regfile_25[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1628 = regfile_25[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1629 = regfile_25[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1630 = regfile_25[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1631 = regfile_25[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1632 = regfile_25[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1633 = regfile_25[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1634 = regfile_25[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1635 = regfile_25[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1636 = regfile_25[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1637 = regfile_25[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1638 = regfile_25[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1639 = regfile_25[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1640 = regfile_25[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1641 = regfile_25[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1642 = regfile_25[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1643 = regfile_25[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1644 = regfile_25[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1645 = regfile_25[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1646 = regfile_25[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1647 = regfile_25[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1648 = regfile_25[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1649 = regfile_25[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1650 = regfile_25[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1651 = regfile_25[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1652 = regfile_25[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1653 = regfile_25[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1654 = regfile_25[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1655 = regfile_25[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1656 = regfile_25[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1657 = regfile_25[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1658 = regfile_25[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1659 = regfile_25[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1660 = regfile_25[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1661 = regfile_25[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1662 = regfile_25[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1663 = regfile_25[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1664 = regfile_26[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1665 = regfile_26[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1666 = regfile_26[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1667 = regfile_26[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1668 = regfile_26[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1669 = regfile_26[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1670 = regfile_26[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1671 = regfile_26[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1672 = regfile_26[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1673 = regfile_26[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1674 = regfile_26[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1675 = regfile_26[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1676 = regfile_26[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1677 = regfile_26[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1678 = regfile_26[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1679 = regfile_26[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1680 = regfile_26[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1681 = regfile_26[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1682 = regfile_26[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1683 = regfile_26[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1684 = regfile_26[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1685 = regfile_26[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1686 = regfile_26[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1687 = regfile_26[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1688 = regfile_26[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1689 = regfile_26[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1690 = regfile_26[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1691 = regfile_26[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1692 = regfile_26[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1693 = regfile_26[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1694 = regfile_26[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1695 = regfile_26[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1696 = regfile_26[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1697 = regfile_26[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1698 = regfile_26[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1699 = regfile_26[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1700 = regfile_26[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1701 = regfile_26[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1702 = regfile_26[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1703 = regfile_26[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1704 = regfile_26[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1705 = regfile_26[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1706 = regfile_26[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1707 = regfile_26[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1708 = regfile_26[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1709 = regfile_26[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1710 = regfile_26[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1711 = regfile_26[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1712 = regfile_26[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1713 = regfile_26[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1714 = regfile_26[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1715 = regfile_26[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1716 = regfile_26[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1717 = regfile_26[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1718 = regfile_26[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1719 = regfile_26[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1720 = regfile_26[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1721 = regfile_26[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1722 = regfile_26[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1723 = regfile_26[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1724 = regfile_26[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1725 = regfile_26[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1726 = regfile_26[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1727 = regfile_26[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1728 = regfile_27[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1729 = regfile_27[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1730 = regfile_27[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1731 = regfile_27[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1732 = regfile_27[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1733 = regfile_27[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1734 = regfile_27[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1735 = regfile_27[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1736 = regfile_27[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1737 = regfile_27[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1738 = regfile_27[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1739 = regfile_27[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1740 = regfile_27[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1741 = regfile_27[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1742 = regfile_27[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1743 = regfile_27[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1744 = regfile_27[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1745 = regfile_27[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1746 = regfile_27[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1747 = regfile_27[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1748 = regfile_27[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1749 = regfile_27[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1750 = regfile_27[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1751 = regfile_27[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1752 = regfile_27[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1753 = regfile_27[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1754 = regfile_27[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1755 = regfile_27[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1756 = regfile_27[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1757 = regfile_27[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1758 = regfile_27[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1759 = regfile_27[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1760 = regfile_27[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1761 = regfile_27[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1762 = regfile_27[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1763 = regfile_27[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1764 = regfile_27[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1765 = regfile_27[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1766 = regfile_27[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1767 = regfile_27[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1768 = regfile_27[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1769 = regfile_27[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1770 = regfile_27[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1771 = regfile_27[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1772 = regfile_27[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1773 = regfile_27[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1774 = regfile_27[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1775 = regfile_27[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1776 = regfile_27[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1777 = regfile_27[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1778 = regfile_27[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1779 = regfile_27[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1780 = regfile_27[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1781 = regfile_27[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1782 = regfile_27[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1783 = regfile_27[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1784 = regfile_27[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1785 = regfile_27[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1786 = regfile_27[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1787 = regfile_27[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1788 = regfile_27[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1789 = regfile_27[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1790 = regfile_27[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1791 = regfile_27[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1792 = regfile_28[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1793 = regfile_28[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1794 = regfile_28[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1795 = regfile_28[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1796 = regfile_28[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1797 = regfile_28[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1798 = regfile_28[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1799 = regfile_28[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1800 = regfile_28[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1801 = regfile_28[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1802 = regfile_28[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1803 = regfile_28[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1804 = regfile_28[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1805 = regfile_28[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1806 = regfile_28[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1807 = regfile_28[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1808 = regfile_28[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1809 = regfile_28[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1810 = regfile_28[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1811 = regfile_28[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1812 = regfile_28[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1813 = regfile_28[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1814 = regfile_28[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1815 = regfile_28[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1816 = regfile_28[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1817 = regfile_28[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1818 = regfile_28[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1819 = regfile_28[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1820 = regfile_28[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1821 = regfile_28[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1822 = regfile_28[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1823 = regfile_28[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1824 = regfile_28[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1825 = regfile_28[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1826 = regfile_28[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1827 = regfile_28[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1828 = regfile_28[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1829 = regfile_28[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1830 = regfile_28[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1831 = regfile_28[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1832 = regfile_28[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1833 = regfile_28[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1834 = regfile_28[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1835 = regfile_28[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1836 = regfile_28[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1837 = regfile_28[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1838 = regfile_28[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1839 = regfile_28[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1840 = regfile_28[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1841 = regfile_28[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1842 = regfile_28[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1843 = regfile_28[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1844 = regfile_28[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1845 = regfile_28[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1846 = regfile_28[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1847 = regfile_28[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1848 = regfile_28[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1849 = regfile_28[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1850 = regfile_28[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1851 = regfile_28[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1852 = regfile_28[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1853 = regfile_28[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1854 = regfile_28[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1855 = regfile_28[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1856 = regfile_29[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1857 = regfile_29[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1858 = regfile_29[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1859 = regfile_29[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1860 = regfile_29[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1861 = regfile_29[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1862 = regfile_29[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1863 = regfile_29[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1864 = regfile_29[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1865 = regfile_29[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1866 = regfile_29[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1867 = regfile_29[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1868 = regfile_29[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1869 = regfile_29[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1870 = regfile_29[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1871 = regfile_29[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1872 = regfile_29[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1873 = regfile_29[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1874 = regfile_29[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1875 = regfile_29[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1876 = regfile_29[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1877 = regfile_29[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1878 = regfile_29[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1879 = regfile_29[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1880 = regfile_29[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1881 = regfile_29[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1882 = regfile_29[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1883 = regfile_29[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1884 = regfile_29[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1885 = regfile_29[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1886 = regfile_29[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1887 = regfile_29[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1888 = regfile_29[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1889 = regfile_29[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1890 = regfile_29[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1891 = regfile_29[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1892 = regfile_29[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1893 = regfile_29[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1894 = regfile_29[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1895 = regfile_29[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1896 = regfile_29[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1897 = regfile_29[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1898 = regfile_29[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1899 = regfile_29[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1900 = regfile_29[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1901 = regfile_29[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1902 = regfile_29[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1903 = regfile_29[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1904 = regfile_29[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1905 = regfile_29[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1906 = regfile_29[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1907 = regfile_29[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1908 = regfile_29[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1909 = regfile_29[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1910 = regfile_29[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1911 = regfile_29[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1912 = regfile_29[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1913 = regfile_29[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1914 = regfile_29[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1915 = regfile_29[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1916 = regfile_29[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1917 = regfile_29[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1918 = regfile_29[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1919 = regfile_29[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1920 = regfile_30[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1921 = regfile_30[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1922 = regfile_30[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1923 = regfile_30[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1924 = regfile_30[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1925 = regfile_30[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1926 = regfile_30[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1927 = regfile_30[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1928 = regfile_30[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1929 = regfile_30[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1930 = regfile_30[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1931 = regfile_30[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1932 = regfile_30[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1933 = regfile_30[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1934 = regfile_30[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1935 = regfile_30[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1936 = regfile_30[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1937 = regfile_30[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1938 = regfile_30[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1939 = regfile_30[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1940 = regfile_30[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1941 = regfile_30[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1942 = regfile_30[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1943 = regfile_30[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1944 = regfile_30[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1945 = regfile_30[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1946 = regfile_30[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1947 = regfile_30[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1948 = regfile_30[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1949 = regfile_30[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1950 = regfile_30[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1951 = regfile_30[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1952 = regfile_30[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1953 = regfile_30[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1954 = regfile_30[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1955 = regfile_30[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1956 = regfile_30[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1957 = regfile_30[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1958 = regfile_30[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1959 = regfile_30[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1960 = regfile_30[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1961 = regfile_30[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1962 = regfile_30[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1963 = regfile_30[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1964 = regfile_30[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1965 = regfile_30[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1966 = regfile_30[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1967 = regfile_30[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1968 = regfile_30[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1969 = regfile_30[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1970 = regfile_30[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1971 = regfile_30[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1972 = regfile_30[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1973 = regfile_30[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1974 = regfile_30[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1975 = regfile_30[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1976 = regfile_30[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1977 = regfile_30[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1978 = regfile_30[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1979 = regfile_30[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1980 = regfile_30[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1981 = regfile_30[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1982 = regfile_30[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1983 = regfile_30[63]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1984 = regfile_31[0]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1985 = regfile_31[1]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1986 = regfile_31[2]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1987 = regfile_31[3]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1988 = regfile_31[4]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1989 = regfile_31[5]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1990 = regfile_31[6]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1991 = regfile_31[7]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1992 = regfile_31[8]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1993 = regfile_31[9]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1994 = regfile_31[10]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1995 = regfile_31[11]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1996 = regfile_31[12]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1997 = regfile_31[13]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1998 = regfile_31[14]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_1999 = regfile_31[15]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2000 = regfile_31[16]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2001 = regfile_31[17]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2002 = regfile_31[18]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2003 = regfile_31[19]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2004 = regfile_31[20]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2005 = regfile_31[21]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2006 = regfile_31[22]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2007 = regfile_31[23]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2008 = regfile_31[24]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2009 = regfile_31[25]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2010 = regfile_31[26]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2011 = regfile_31[27]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2012 = regfile_31[28]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2013 = regfile_31[29]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2014 = regfile_31[30]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2015 = regfile_31[31]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2016 = regfile_31[32]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2017 = regfile_31[33]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2018 = regfile_31[34]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2019 = regfile_31[35]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2020 = regfile_31[36]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2021 = regfile_31[37]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2022 = regfile_31[38]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2023 = regfile_31[39]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2024 = regfile_31[40]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2025 = regfile_31[41]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2026 = regfile_31[42]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2027 = regfile_31[43]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2028 = regfile_31[44]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2029 = regfile_31[45]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2030 = regfile_31[46]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2031 = regfile_31[47]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2032 = regfile_31[48]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2033 = regfile_31[49]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2034 = regfile_31[50]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2035 = regfile_31[51]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2036 = regfile_31[52]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2037 = regfile_31[53]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2038 = regfile_31[54]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2039 = regfile_31[55]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2040 = regfile_31[56]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2041 = regfile_31[57]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2042 = regfile_31[58]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2043 = regfile_31[59]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2044 = regfile_31[60]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2045 = regfile_31[61]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2046 = regfile_31[62]; // @[EXU.scala 36:79]
  wire  regfile_output_aux_2047 = regfile_31[63]; // @[EXU.scala 36:79]
  wire [7:0] io_regfile_output_lo_lo_lo_lo_lo_lo_lo_lo = {regfile_output_aux_7,regfile_output_aux_6,regfile_output_aux_5
    ,regfile_output_aux_4,regfile_output_aux_3,regfile_output_aux_2,regfile_output_aux_1,regfile_output_aux_0}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_lo_lo_lo_lo_lo = {regfile_output_aux_15,regfile_output_aux_14,
    regfile_output_aux_13,regfile_output_aux_12,regfile_output_aux_11,regfile_output_aux_10,regfile_output_aux_9,
    regfile_output_aux_8,io_regfile_output_lo_lo_lo_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_lo_lo_lo_hi_lo = {regfile_output_aux_23,regfile_output_aux_22,
    regfile_output_aux_21,regfile_output_aux_20,regfile_output_aux_19,regfile_output_aux_18,regfile_output_aux_17,
    regfile_output_aux_16}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_lo_lo_lo_lo = {regfile_output_aux_31,regfile_output_aux_30,regfile_output_aux_29,
    regfile_output_aux_28,regfile_output_aux_27,regfile_output_aux_26,regfile_output_aux_25,regfile_output_aux_24,
    io_regfile_output_lo_lo_lo_lo_lo_lo_hi_lo,io_regfile_output_lo_lo_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_lo_lo_hi_lo_lo = {regfile_output_aux_39,regfile_output_aux_38,
    regfile_output_aux_37,regfile_output_aux_36,regfile_output_aux_35,regfile_output_aux_34,regfile_output_aux_33,
    regfile_output_aux_32}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_lo_lo_lo_hi_lo = {regfile_output_aux_47,regfile_output_aux_46,
    regfile_output_aux_45,regfile_output_aux_44,regfile_output_aux_43,regfile_output_aux_42,regfile_output_aux_41,
    regfile_output_aux_40,io_regfile_output_lo_lo_lo_lo_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_lo_lo_hi_hi_lo = {regfile_output_aux_55,regfile_output_aux_54,
    regfile_output_aux_53,regfile_output_aux_52,regfile_output_aux_51,regfile_output_aux_50,regfile_output_aux_49,
    regfile_output_aux_48}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_lo_lo_lo_hi = {regfile_output_aux_63,regfile_output_aux_62,regfile_output_aux_61,
    regfile_output_aux_60,regfile_output_aux_59,regfile_output_aux_58,regfile_output_aux_57,regfile_output_aux_56,
    io_regfile_output_lo_lo_lo_lo_lo_hi_hi_lo,io_regfile_output_lo_lo_lo_lo_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_lo_hi_lo_lo_lo = {regfile_output_aux_71,regfile_output_aux_70,
    regfile_output_aux_69,regfile_output_aux_68,regfile_output_aux_67,regfile_output_aux_66,regfile_output_aux_65,
    regfile_output_aux_64}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_lo_lo_hi_lo_lo = {regfile_output_aux_79,regfile_output_aux_78,
    regfile_output_aux_77,regfile_output_aux_76,regfile_output_aux_75,regfile_output_aux_74,regfile_output_aux_73,
    regfile_output_aux_72,io_regfile_output_lo_lo_lo_lo_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_lo_hi_lo_hi_lo = {regfile_output_aux_87,regfile_output_aux_86,
    regfile_output_aux_85,regfile_output_aux_84,regfile_output_aux_83,regfile_output_aux_82,regfile_output_aux_81,
    regfile_output_aux_80}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_lo_lo_hi_lo = {regfile_output_aux_95,regfile_output_aux_94,regfile_output_aux_93,
    regfile_output_aux_92,regfile_output_aux_91,regfile_output_aux_90,regfile_output_aux_89,regfile_output_aux_88,
    io_regfile_output_lo_lo_lo_lo_hi_lo_hi_lo,io_regfile_output_lo_lo_lo_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_lo_hi_hi_lo_lo = {regfile_output_aux_103,regfile_output_aux_102,
    regfile_output_aux_101,regfile_output_aux_100,regfile_output_aux_99,regfile_output_aux_98,regfile_output_aux_97,
    regfile_output_aux_96}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_lo_lo_hi_hi_lo = {regfile_output_aux_111,regfile_output_aux_110,
    regfile_output_aux_109,regfile_output_aux_108,regfile_output_aux_107,regfile_output_aux_106,regfile_output_aux_105,
    regfile_output_aux_104,io_regfile_output_lo_lo_lo_lo_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_lo_hi_hi_hi_lo = {regfile_output_aux_119,regfile_output_aux_118,
    regfile_output_aux_117,regfile_output_aux_116,regfile_output_aux_115,regfile_output_aux_114,regfile_output_aux_113,
    regfile_output_aux_112}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_lo_lo_hi_hi = {regfile_output_aux_127,regfile_output_aux_126,
    regfile_output_aux_125,regfile_output_aux_124,regfile_output_aux_123,regfile_output_aux_122,regfile_output_aux_121,
    regfile_output_aux_120,io_regfile_output_lo_lo_lo_lo_hi_hi_hi_lo,io_regfile_output_lo_lo_lo_lo_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_hi_lo_lo_lo_lo = {regfile_output_aux_135,regfile_output_aux_134,
    regfile_output_aux_133,regfile_output_aux_132,regfile_output_aux_131,regfile_output_aux_130,regfile_output_aux_129,
    regfile_output_aux_128}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_lo_hi_lo_lo_lo = {regfile_output_aux_143,regfile_output_aux_142,
    regfile_output_aux_141,regfile_output_aux_140,regfile_output_aux_139,regfile_output_aux_138,regfile_output_aux_137,
    regfile_output_aux_136,io_regfile_output_lo_lo_lo_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_hi_lo_lo_hi_lo = {regfile_output_aux_151,regfile_output_aux_150,
    regfile_output_aux_149,regfile_output_aux_148,regfile_output_aux_147,regfile_output_aux_146,regfile_output_aux_145,
    regfile_output_aux_144}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_lo_hi_lo_lo = {regfile_output_aux_159,regfile_output_aux_158,
    regfile_output_aux_157,regfile_output_aux_156,regfile_output_aux_155,regfile_output_aux_154,regfile_output_aux_153,
    regfile_output_aux_152,io_regfile_output_lo_lo_lo_hi_lo_lo_hi_lo,io_regfile_output_lo_lo_lo_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_hi_lo_hi_lo_lo = {regfile_output_aux_167,regfile_output_aux_166,
    regfile_output_aux_165,regfile_output_aux_164,regfile_output_aux_163,regfile_output_aux_162,regfile_output_aux_161,
    regfile_output_aux_160}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_lo_hi_lo_hi_lo = {regfile_output_aux_175,regfile_output_aux_174,
    regfile_output_aux_173,regfile_output_aux_172,regfile_output_aux_171,regfile_output_aux_170,regfile_output_aux_169,
    regfile_output_aux_168,io_regfile_output_lo_lo_lo_hi_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_hi_lo_hi_hi_lo = {regfile_output_aux_183,regfile_output_aux_182,
    regfile_output_aux_181,regfile_output_aux_180,regfile_output_aux_179,regfile_output_aux_178,regfile_output_aux_177,
    regfile_output_aux_176}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_lo_hi_lo_hi = {regfile_output_aux_191,regfile_output_aux_190,
    regfile_output_aux_189,regfile_output_aux_188,regfile_output_aux_187,regfile_output_aux_186,regfile_output_aux_185,
    regfile_output_aux_184,io_regfile_output_lo_lo_lo_hi_lo_hi_hi_lo,io_regfile_output_lo_lo_lo_hi_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_hi_hi_lo_lo_lo = {regfile_output_aux_199,regfile_output_aux_198,
    regfile_output_aux_197,regfile_output_aux_196,regfile_output_aux_195,regfile_output_aux_194,regfile_output_aux_193,
    regfile_output_aux_192}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_lo_hi_hi_lo_lo = {regfile_output_aux_207,regfile_output_aux_206,
    regfile_output_aux_205,regfile_output_aux_204,regfile_output_aux_203,regfile_output_aux_202,regfile_output_aux_201,
    regfile_output_aux_200,io_regfile_output_lo_lo_lo_hi_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_hi_hi_lo_hi_lo = {regfile_output_aux_215,regfile_output_aux_214,
    regfile_output_aux_213,regfile_output_aux_212,regfile_output_aux_211,regfile_output_aux_210,regfile_output_aux_209,
    regfile_output_aux_208}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_lo_hi_hi_lo = {regfile_output_aux_223,regfile_output_aux_222,
    regfile_output_aux_221,regfile_output_aux_220,regfile_output_aux_219,regfile_output_aux_218,regfile_output_aux_217,
    regfile_output_aux_216,io_regfile_output_lo_lo_lo_hi_hi_lo_hi_lo,io_regfile_output_lo_lo_lo_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_hi_hi_hi_lo_lo = {regfile_output_aux_231,regfile_output_aux_230,
    regfile_output_aux_229,regfile_output_aux_228,regfile_output_aux_227,regfile_output_aux_226,regfile_output_aux_225,
    regfile_output_aux_224}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_lo_hi_hi_hi_lo = {regfile_output_aux_239,regfile_output_aux_238,
    regfile_output_aux_237,regfile_output_aux_236,regfile_output_aux_235,regfile_output_aux_234,regfile_output_aux_233,
    regfile_output_aux_232,io_regfile_output_lo_lo_lo_hi_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_lo_hi_hi_hi_hi_lo = {regfile_output_aux_247,regfile_output_aux_246,
    regfile_output_aux_245,regfile_output_aux_244,regfile_output_aux_243,regfile_output_aux_242,regfile_output_aux_241,
    regfile_output_aux_240}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_lo_hi_hi_hi = {regfile_output_aux_255,regfile_output_aux_254,
    regfile_output_aux_253,regfile_output_aux_252,regfile_output_aux_251,regfile_output_aux_250,regfile_output_aux_249,
    regfile_output_aux_248,io_regfile_output_lo_lo_lo_hi_hi_hi_hi_lo,io_regfile_output_lo_lo_lo_hi_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [255:0] io_regfile_output_lo_lo_lo = {io_regfile_output_lo_lo_lo_hi_hi_hi,io_regfile_output_lo_lo_lo_hi_hi_lo,
    io_regfile_output_lo_lo_lo_hi_lo_hi,io_regfile_output_lo_lo_lo_hi_lo_lo,io_regfile_output_lo_lo_lo_lo_hi_hi,
    io_regfile_output_lo_lo_lo_lo_hi_lo,io_regfile_output_lo_lo_lo_lo_lo_hi,io_regfile_output_lo_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_lo_lo_lo_lo_lo = {regfile_output_aux_263,regfile_output_aux_262,
    regfile_output_aux_261,regfile_output_aux_260,regfile_output_aux_259,regfile_output_aux_258,regfile_output_aux_257,
    regfile_output_aux_256}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_hi_lo_lo_lo_lo = {regfile_output_aux_271,regfile_output_aux_270,
    regfile_output_aux_269,regfile_output_aux_268,regfile_output_aux_267,regfile_output_aux_266,regfile_output_aux_265,
    regfile_output_aux_264,io_regfile_output_lo_lo_hi_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_lo_lo_lo_hi_lo = {regfile_output_aux_279,regfile_output_aux_278,
    regfile_output_aux_277,regfile_output_aux_276,regfile_output_aux_275,regfile_output_aux_274,regfile_output_aux_273,
    regfile_output_aux_272}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_hi_lo_lo_lo = {regfile_output_aux_287,regfile_output_aux_286,
    regfile_output_aux_285,regfile_output_aux_284,regfile_output_aux_283,regfile_output_aux_282,regfile_output_aux_281,
    regfile_output_aux_280,io_regfile_output_lo_lo_hi_lo_lo_lo_hi_lo,io_regfile_output_lo_lo_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_lo_lo_hi_lo_lo = {regfile_output_aux_295,regfile_output_aux_294,
    regfile_output_aux_293,regfile_output_aux_292,regfile_output_aux_291,regfile_output_aux_290,regfile_output_aux_289,
    regfile_output_aux_288}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_hi_lo_lo_hi_lo = {regfile_output_aux_303,regfile_output_aux_302,
    regfile_output_aux_301,regfile_output_aux_300,regfile_output_aux_299,regfile_output_aux_298,regfile_output_aux_297,
    regfile_output_aux_296,io_regfile_output_lo_lo_hi_lo_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_lo_lo_hi_hi_lo = {regfile_output_aux_311,regfile_output_aux_310,
    regfile_output_aux_309,regfile_output_aux_308,regfile_output_aux_307,regfile_output_aux_306,regfile_output_aux_305,
    regfile_output_aux_304}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_hi_lo_lo_hi = {regfile_output_aux_319,regfile_output_aux_318,
    regfile_output_aux_317,regfile_output_aux_316,regfile_output_aux_315,regfile_output_aux_314,regfile_output_aux_313,
    regfile_output_aux_312,io_regfile_output_lo_lo_hi_lo_lo_hi_hi_lo,io_regfile_output_lo_lo_hi_lo_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_lo_hi_lo_lo_lo = {regfile_output_aux_327,regfile_output_aux_326,
    regfile_output_aux_325,regfile_output_aux_324,regfile_output_aux_323,regfile_output_aux_322,regfile_output_aux_321,
    regfile_output_aux_320}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_hi_lo_hi_lo_lo = {regfile_output_aux_335,regfile_output_aux_334,
    regfile_output_aux_333,regfile_output_aux_332,regfile_output_aux_331,regfile_output_aux_330,regfile_output_aux_329,
    regfile_output_aux_328,io_regfile_output_lo_lo_hi_lo_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_lo_hi_lo_hi_lo = {regfile_output_aux_343,regfile_output_aux_342,
    regfile_output_aux_341,regfile_output_aux_340,regfile_output_aux_339,regfile_output_aux_338,regfile_output_aux_337,
    regfile_output_aux_336}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_hi_lo_hi_lo = {regfile_output_aux_351,regfile_output_aux_350,
    regfile_output_aux_349,regfile_output_aux_348,regfile_output_aux_347,regfile_output_aux_346,regfile_output_aux_345,
    regfile_output_aux_344,io_regfile_output_lo_lo_hi_lo_hi_lo_hi_lo,io_regfile_output_lo_lo_hi_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_lo_hi_hi_lo_lo = {regfile_output_aux_359,regfile_output_aux_358,
    regfile_output_aux_357,regfile_output_aux_356,regfile_output_aux_355,regfile_output_aux_354,regfile_output_aux_353,
    regfile_output_aux_352}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_hi_lo_hi_hi_lo = {regfile_output_aux_367,regfile_output_aux_366,
    regfile_output_aux_365,regfile_output_aux_364,regfile_output_aux_363,regfile_output_aux_362,regfile_output_aux_361,
    regfile_output_aux_360,io_regfile_output_lo_lo_hi_lo_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_lo_hi_hi_hi_lo = {regfile_output_aux_375,regfile_output_aux_374,
    regfile_output_aux_373,regfile_output_aux_372,regfile_output_aux_371,regfile_output_aux_370,regfile_output_aux_369,
    regfile_output_aux_368}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_hi_lo_hi_hi = {regfile_output_aux_383,regfile_output_aux_382,
    regfile_output_aux_381,regfile_output_aux_380,regfile_output_aux_379,regfile_output_aux_378,regfile_output_aux_377,
    regfile_output_aux_376,io_regfile_output_lo_lo_hi_lo_hi_hi_hi_lo,io_regfile_output_lo_lo_hi_lo_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_hi_lo_lo_lo_lo = {regfile_output_aux_391,regfile_output_aux_390,
    regfile_output_aux_389,regfile_output_aux_388,regfile_output_aux_387,regfile_output_aux_386,regfile_output_aux_385,
    regfile_output_aux_384}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_hi_hi_lo_lo_lo = {regfile_output_aux_399,regfile_output_aux_398,
    regfile_output_aux_397,regfile_output_aux_396,regfile_output_aux_395,regfile_output_aux_394,regfile_output_aux_393,
    regfile_output_aux_392,io_regfile_output_lo_lo_hi_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_hi_lo_lo_hi_lo = {regfile_output_aux_407,regfile_output_aux_406,
    regfile_output_aux_405,regfile_output_aux_404,regfile_output_aux_403,regfile_output_aux_402,regfile_output_aux_401,
    regfile_output_aux_400}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_hi_hi_lo_lo = {regfile_output_aux_415,regfile_output_aux_414,
    regfile_output_aux_413,regfile_output_aux_412,regfile_output_aux_411,regfile_output_aux_410,regfile_output_aux_409,
    regfile_output_aux_408,io_regfile_output_lo_lo_hi_hi_lo_lo_hi_lo,io_regfile_output_lo_lo_hi_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_hi_lo_hi_lo_lo = {regfile_output_aux_423,regfile_output_aux_422,
    regfile_output_aux_421,regfile_output_aux_420,regfile_output_aux_419,regfile_output_aux_418,regfile_output_aux_417,
    regfile_output_aux_416}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_hi_hi_lo_hi_lo = {regfile_output_aux_431,regfile_output_aux_430,
    regfile_output_aux_429,regfile_output_aux_428,regfile_output_aux_427,regfile_output_aux_426,regfile_output_aux_425,
    regfile_output_aux_424,io_regfile_output_lo_lo_hi_hi_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_hi_lo_hi_hi_lo = {regfile_output_aux_439,regfile_output_aux_438,
    regfile_output_aux_437,regfile_output_aux_436,regfile_output_aux_435,regfile_output_aux_434,regfile_output_aux_433,
    regfile_output_aux_432}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_hi_hi_lo_hi = {regfile_output_aux_447,regfile_output_aux_446,
    regfile_output_aux_445,regfile_output_aux_444,regfile_output_aux_443,regfile_output_aux_442,regfile_output_aux_441,
    regfile_output_aux_440,io_regfile_output_lo_lo_hi_hi_lo_hi_hi_lo,io_regfile_output_lo_lo_hi_hi_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_hi_hi_lo_lo_lo = {regfile_output_aux_455,regfile_output_aux_454,
    regfile_output_aux_453,regfile_output_aux_452,regfile_output_aux_451,regfile_output_aux_450,regfile_output_aux_449,
    regfile_output_aux_448}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_hi_hi_hi_lo_lo = {regfile_output_aux_463,regfile_output_aux_462,
    regfile_output_aux_461,regfile_output_aux_460,regfile_output_aux_459,regfile_output_aux_458,regfile_output_aux_457,
    regfile_output_aux_456,io_regfile_output_lo_lo_hi_hi_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_hi_hi_lo_hi_lo = {regfile_output_aux_471,regfile_output_aux_470,
    regfile_output_aux_469,regfile_output_aux_468,regfile_output_aux_467,regfile_output_aux_466,regfile_output_aux_465,
    regfile_output_aux_464}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_hi_hi_hi_lo = {regfile_output_aux_479,regfile_output_aux_478,
    regfile_output_aux_477,regfile_output_aux_476,regfile_output_aux_475,regfile_output_aux_474,regfile_output_aux_473,
    regfile_output_aux_472,io_regfile_output_lo_lo_hi_hi_hi_lo_hi_lo,io_regfile_output_lo_lo_hi_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_hi_hi_hi_lo_lo = {regfile_output_aux_487,regfile_output_aux_486,
    regfile_output_aux_485,regfile_output_aux_484,regfile_output_aux_483,regfile_output_aux_482,regfile_output_aux_481,
    regfile_output_aux_480}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_lo_hi_hi_hi_hi_lo = {regfile_output_aux_495,regfile_output_aux_494,
    regfile_output_aux_493,regfile_output_aux_492,regfile_output_aux_491,regfile_output_aux_490,regfile_output_aux_489,
    regfile_output_aux_488,io_regfile_output_lo_lo_hi_hi_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_lo_hi_hi_hi_hi_hi_lo = {regfile_output_aux_503,regfile_output_aux_502,
    regfile_output_aux_501,regfile_output_aux_500,regfile_output_aux_499,regfile_output_aux_498,regfile_output_aux_497,
    regfile_output_aux_496}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_lo_hi_hi_hi_hi = {regfile_output_aux_511,regfile_output_aux_510,
    regfile_output_aux_509,regfile_output_aux_508,regfile_output_aux_507,regfile_output_aux_506,regfile_output_aux_505,
    regfile_output_aux_504,io_regfile_output_lo_lo_hi_hi_hi_hi_hi_lo,io_regfile_output_lo_lo_hi_hi_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [511:0] io_regfile_output_lo_lo = {io_regfile_output_lo_lo_hi_hi_hi_hi,io_regfile_output_lo_lo_hi_hi_hi_lo,
    io_regfile_output_lo_lo_hi_hi_lo_hi,io_regfile_output_lo_lo_hi_hi_lo_lo,io_regfile_output_lo_lo_hi_lo_hi_hi,
    io_regfile_output_lo_lo_hi_lo_hi_lo,io_regfile_output_lo_lo_hi_lo_lo_hi,io_regfile_output_lo_lo_hi_lo_lo_lo,
    io_regfile_output_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_lo_lo_lo_lo_lo = {regfile_output_aux_519,regfile_output_aux_518,
    regfile_output_aux_517,regfile_output_aux_516,regfile_output_aux_515,regfile_output_aux_514,regfile_output_aux_513,
    regfile_output_aux_512}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_lo_lo_lo_lo_lo = {regfile_output_aux_527,regfile_output_aux_526,
    regfile_output_aux_525,regfile_output_aux_524,regfile_output_aux_523,regfile_output_aux_522,regfile_output_aux_521,
    regfile_output_aux_520,io_regfile_output_lo_hi_lo_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_lo_lo_lo_hi_lo = {regfile_output_aux_535,regfile_output_aux_534,
    regfile_output_aux_533,regfile_output_aux_532,regfile_output_aux_531,regfile_output_aux_530,regfile_output_aux_529,
    regfile_output_aux_528}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_lo_lo_lo_lo = {regfile_output_aux_543,regfile_output_aux_542,
    regfile_output_aux_541,regfile_output_aux_540,regfile_output_aux_539,regfile_output_aux_538,regfile_output_aux_537,
    regfile_output_aux_536,io_regfile_output_lo_hi_lo_lo_lo_lo_hi_lo,io_regfile_output_lo_hi_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_lo_lo_hi_lo_lo = {regfile_output_aux_551,regfile_output_aux_550,
    regfile_output_aux_549,regfile_output_aux_548,regfile_output_aux_547,regfile_output_aux_546,regfile_output_aux_545,
    regfile_output_aux_544}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_lo_lo_lo_hi_lo = {regfile_output_aux_559,regfile_output_aux_558,
    regfile_output_aux_557,regfile_output_aux_556,regfile_output_aux_555,regfile_output_aux_554,regfile_output_aux_553,
    regfile_output_aux_552,io_regfile_output_lo_hi_lo_lo_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_lo_lo_hi_hi_lo = {regfile_output_aux_567,regfile_output_aux_566,
    regfile_output_aux_565,regfile_output_aux_564,regfile_output_aux_563,regfile_output_aux_562,regfile_output_aux_561,
    regfile_output_aux_560}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_lo_lo_lo_hi = {regfile_output_aux_575,regfile_output_aux_574,
    regfile_output_aux_573,regfile_output_aux_572,regfile_output_aux_571,regfile_output_aux_570,regfile_output_aux_569,
    regfile_output_aux_568,io_regfile_output_lo_hi_lo_lo_lo_hi_hi_lo,io_regfile_output_lo_hi_lo_lo_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_lo_hi_lo_lo_lo = {regfile_output_aux_583,regfile_output_aux_582,
    regfile_output_aux_581,regfile_output_aux_580,regfile_output_aux_579,regfile_output_aux_578,regfile_output_aux_577,
    regfile_output_aux_576}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_lo_lo_hi_lo_lo = {regfile_output_aux_591,regfile_output_aux_590,
    regfile_output_aux_589,regfile_output_aux_588,regfile_output_aux_587,regfile_output_aux_586,regfile_output_aux_585,
    regfile_output_aux_584,io_regfile_output_lo_hi_lo_lo_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_lo_hi_lo_hi_lo = {regfile_output_aux_599,regfile_output_aux_598,
    regfile_output_aux_597,regfile_output_aux_596,regfile_output_aux_595,regfile_output_aux_594,regfile_output_aux_593,
    regfile_output_aux_592}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_lo_lo_hi_lo = {regfile_output_aux_607,regfile_output_aux_606,
    regfile_output_aux_605,regfile_output_aux_604,regfile_output_aux_603,regfile_output_aux_602,regfile_output_aux_601,
    regfile_output_aux_600,io_regfile_output_lo_hi_lo_lo_hi_lo_hi_lo,io_regfile_output_lo_hi_lo_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_lo_hi_hi_lo_lo = {regfile_output_aux_615,regfile_output_aux_614,
    regfile_output_aux_613,regfile_output_aux_612,regfile_output_aux_611,regfile_output_aux_610,regfile_output_aux_609,
    regfile_output_aux_608}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_lo_lo_hi_hi_lo = {regfile_output_aux_623,regfile_output_aux_622,
    regfile_output_aux_621,regfile_output_aux_620,regfile_output_aux_619,regfile_output_aux_618,regfile_output_aux_617,
    regfile_output_aux_616,io_regfile_output_lo_hi_lo_lo_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_lo_hi_hi_hi_lo = {regfile_output_aux_631,regfile_output_aux_630,
    regfile_output_aux_629,regfile_output_aux_628,regfile_output_aux_627,regfile_output_aux_626,regfile_output_aux_625,
    regfile_output_aux_624}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_lo_lo_hi_hi = {regfile_output_aux_639,regfile_output_aux_638,
    regfile_output_aux_637,regfile_output_aux_636,regfile_output_aux_635,regfile_output_aux_634,regfile_output_aux_633,
    regfile_output_aux_632,io_regfile_output_lo_hi_lo_lo_hi_hi_hi_lo,io_regfile_output_lo_hi_lo_lo_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_hi_lo_lo_lo_lo = {regfile_output_aux_647,regfile_output_aux_646,
    regfile_output_aux_645,regfile_output_aux_644,regfile_output_aux_643,regfile_output_aux_642,regfile_output_aux_641,
    regfile_output_aux_640}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_lo_hi_lo_lo_lo = {regfile_output_aux_655,regfile_output_aux_654,
    regfile_output_aux_653,regfile_output_aux_652,regfile_output_aux_651,regfile_output_aux_650,regfile_output_aux_649,
    regfile_output_aux_648,io_regfile_output_lo_hi_lo_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_hi_lo_lo_hi_lo = {regfile_output_aux_663,regfile_output_aux_662,
    regfile_output_aux_661,regfile_output_aux_660,regfile_output_aux_659,regfile_output_aux_658,regfile_output_aux_657,
    regfile_output_aux_656}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_lo_hi_lo_lo = {regfile_output_aux_671,regfile_output_aux_670,
    regfile_output_aux_669,regfile_output_aux_668,regfile_output_aux_667,regfile_output_aux_666,regfile_output_aux_665,
    regfile_output_aux_664,io_regfile_output_lo_hi_lo_hi_lo_lo_hi_lo,io_regfile_output_lo_hi_lo_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_hi_lo_hi_lo_lo = {regfile_output_aux_679,regfile_output_aux_678,
    regfile_output_aux_677,regfile_output_aux_676,regfile_output_aux_675,regfile_output_aux_674,regfile_output_aux_673,
    regfile_output_aux_672}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_lo_hi_lo_hi_lo = {regfile_output_aux_687,regfile_output_aux_686,
    regfile_output_aux_685,regfile_output_aux_684,regfile_output_aux_683,regfile_output_aux_682,regfile_output_aux_681,
    regfile_output_aux_680,io_regfile_output_lo_hi_lo_hi_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_hi_lo_hi_hi_lo = {regfile_output_aux_695,regfile_output_aux_694,
    regfile_output_aux_693,regfile_output_aux_692,regfile_output_aux_691,regfile_output_aux_690,regfile_output_aux_689,
    regfile_output_aux_688}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_lo_hi_lo_hi = {regfile_output_aux_703,regfile_output_aux_702,
    regfile_output_aux_701,regfile_output_aux_700,regfile_output_aux_699,regfile_output_aux_698,regfile_output_aux_697,
    regfile_output_aux_696,io_regfile_output_lo_hi_lo_hi_lo_hi_hi_lo,io_regfile_output_lo_hi_lo_hi_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_hi_hi_lo_lo_lo = {regfile_output_aux_711,regfile_output_aux_710,
    regfile_output_aux_709,regfile_output_aux_708,regfile_output_aux_707,regfile_output_aux_706,regfile_output_aux_705,
    regfile_output_aux_704}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_lo_hi_hi_lo_lo = {regfile_output_aux_719,regfile_output_aux_718,
    regfile_output_aux_717,regfile_output_aux_716,regfile_output_aux_715,regfile_output_aux_714,regfile_output_aux_713,
    regfile_output_aux_712,io_regfile_output_lo_hi_lo_hi_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_hi_hi_lo_hi_lo = {regfile_output_aux_727,regfile_output_aux_726,
    regfile_output_aux_725,regfile_output_aux_724,regfile_output_aux_723,regfile_output_aux_722,regfile_output_aux_721,
    regfile_output_aux_720}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_lo_hi_hi_lo = {regfile_output_aux_735,regfile_output_aux_734,
    regfile_output_aux_733,regfile_output_aux_732,regfile_output_aux_731,regfile_output_aux_730,regfile_output_aux_729,
    regfile_output_aux_728,io_regfile_output_lo_hi_lo_hi_hi_lo_hi_lo,io_regfile_output_lo_hi_lo_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_hi_hi_hi_lo_lo = {regfile_output_aux_743,regfile_output_aux_742,
    regfile_output_aux_741,regfile_output_aux_740,regfile_output_aux_739,regfile_output_aux_738,regfile_output_aux_737,
    regfile_output_aux_736}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_lo_hi_hi_hi_lo = {regfile_output_aux_751,regfile_output_aux_750,
    regfile_output_aux_749,regfile_output_aux_748,regfile_output_aux_747,regfile_output_aux_746,regfile_output_aux_745,
    regfile_output_aux_744,io_regfile_output_lo_hi_lo_hi_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_lo_hi_hi_hi_hi_lo = {regfile_output_aux_759,regfile_output_aux_758,
    regfile_output_aux_757,regfile_output_aux_756,regfile_output_aux_755,regfile_output_aux_754,regfile_output_aux_753,
    regfile_output_aux_752}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_lo_hi_hi_hi = {regfile_output_aux_767,regfile_output_aux_766,
    regfile_output_aux_765,regfile_output_aux_764,regfile_output_aux_763,regfile_output_aux_762,regfile_output_aux_761,
    regfile_output_aux_760,io_regfile_output_lo_hi_lo_hi_hi_hi_hi_lo,io_regfile_output_lo_hi_lo_hi_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [255:0] io_regfile_output_lo_hi_lo = {io_regfile_output_lo_hi_lo_hi_hi_hi,io_regfile_output_lo_hi_lo_hi_hi_lo,
    io_regfile_output_lo_hi_lo_hi_lo_hi,io_regfile_output_lo_hi_lo_hi_lo_lo,io_regfile_output_lo_hi_lo_lo_hi_hi,
    io_regfile_output_lo_hi_lo_lo_hi_lo,io_regfile_output_lo_hi_lo_lo_lo_hi,io_regfile_output_lo_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_lo_lo_lo_lo_lo = {regfile_output_aux_775,regfile_output_aux_774,
    regfile_output_aux_773,regfile_output_aux_772,regfile_output_aux_771,regfile_output_aux_770,regfile_output_aux_769,
    regfile_output_aux_768}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_hi_lo_lo_lo_lo = {regfile_output_aux_783,regfile_output_aux_782,
    regfile_output_aux_781,regfile_output_aux_780,regfile_output_aux_779,regfile_output_aux_778,regfile_output_aux_777,
    regfile_output_aux_776,io_regfile_output_lo_hi_hi_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_lo_lo_lo_hi_lo = {regfile_output_aux_791,regfile_output_aux_790,
    regfile_output_aux_789,regfile_output_aux_788,regfile_output_aux_787,regfile_output_aux_786,regfile_output_aux_785,
    regfile_output_aux_784}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_hi_lo_lo_lo = {regfile_output_aux_799,regfile_output_aux_798,
    regfile_output_aux_797,regfile_output_aux_796,regfile_output_aux_795,regfile_output_aux_794,regfile_output_aux_793,
    regfile_output_aux_792,io_regfile_output_lo_hi_hi_lo_lo_lo_hi_lo,io_regfile_output_lo_hi_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_lo_lo_hi_lo_lo = {regfile_output_aux_807,regfile_output_aux_806,
    regfile_output_aux_805,regfile_output_aux_804,regfile_output_aux_803,regfile_output_aux_802,regfile_output_aux_801,
    regfile_output_aux_800}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_hi_lo_lo_hi_lo = {regfile_output_aux_815,regfile_output_aux_814,
    regfile_output_aux_813,regfile_output_aux_812,regfile_output_aux_811,regfile_output_aux_810,regfile_output_aux_809,
    regfile_output_aux_808,io_regfile_output_lo_hi_hi_lo_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_lo_lo_hi_hi_lo = {regfile_output_aux_823,regfile_output_aux_822,
    regfile_output_aux_821,regfile_output_aux_820,regfile_output_aux_819,regfile_output_aux_818,regfile_output_aux_817,
    regfile_output_aux_816}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_hi_lo_lo_hi = {regfile_output_aux_831,regfile_output_aux_830,
    regfile_output_aux_829,regfile_output_aux_828,regfile_output_aux_827,regfile_output_aux_826,regfile_output_aux_825,
    regfile_output_aux_824,io_regfile_output_lo_hi_hi_lo_lo_hi_hi_lo,io_regfile_output_lo_hi_hi_lo_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_lo_hi_lo_lo_lo = {regfile_output_aux_839,regfile_output_aux_838,
    regfile_output_aux_837,regfile_output_aux_836,regfile_output_aux_835,regfile_output_aux_834,regfile_output_aux_833,
    regfile_output_aux_832}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_hi_lo_hi_lo_lo = {regfile_output_aux_847,regfile_output_aux_846,
    regfile_output_aux_845,regfile_output_aux_844,regfile_output_aux_843,regfile_output_aux_842,regfile_output_aux_841,
    regfile_output_aux_840,io_regfile_output_lo_hi_hi_lo_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_lo_hi_lo_hi_lo = {regfile_output_aux_855,regfile_output_aux_854,
    regfile_output_aux_853,regfile_output_aux_852,regfile_output_aux_851,regfile_output_aux_850,regfile_output_aux_849,
    regfile_output_aux_848}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_hi_lo_hi_lo = {regfile_output_aux_863,regfile_output_aux_862,
    regfile_output_aux_861,regfile_output_aux_860,regfile_output_aux_859,regfile_output_aux_858,regfile_output_aux_857,
    regfile_output_aux_856,io_regfile_output_lo_hi_hi_lo_hi_lo_hi_lo,io_regfile_output_lo_hi_hi_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_lo_hi_hi_lo_lo = {regfile_output_aux_871,regfile_output_aux_870,
    regfile_output_aux_869,regfile_output_aux_868,regfile_output_aux_867,regfile_output_aux_866,regfile_output_aux_865,
    regfile_output_aux_864}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_hi_lo_hi_hi_lo = {regfile_output_aux_879,regfile_output_aux_878,
    regfile_output_aux_877,regfile_output_aux_876,regfile_output_aux_875,regfile_output_aux_874,regfile_output_aux_873,
    regfile_output_aux_872,io_regfile_output_lo_hi_hi_lo_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_lo_hi_hi_hi_lo = {regfile_output_aux_887,regfile_output_aux_886,
    regfile_output_aux_885,regfile_output_aux_884,regfile_output_aux_883,regfile_output_aux_882,regfile_output_aux_881,
    regfile_output_aux_880}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_hi_lo_hi_hi = {regfile_output_aux_895,regfile_output_aux_894,
    regfile_output_aux_893,regfile_output_aux_892,regfile_output_aux_891,regfile_output_aux_890,regfile_output_aux_889,
    regfile_output_aux_888,io_regfile_output_lo_hi_hi_lo_hi_hi_hi_lo,io_regfile_output_lo_hi_hi_lo_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_hi_lo_lo_lo_lo = {regfile_output_aux_903,regfile_output_aux_902,
    regfile_output_aux_901,regfile_output_aux_900,regfile_output_aux_899,regfile_output_aux_898,regfile_output_aux_897,
    regfile_output_aux_896}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_hi_hi_lo_lo_lo = {regfile_output_aux_911,regfile_output_aux_910,
    regfile_output_aux_909,regfile_output_aux_908,regfile_output_aux_907,regfile_output_aux_906,regfile_output_aux_905,
    regfile_output_aux_904,io_regfile_output_lo_hi_hi_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_hi_lo_lo_hi_lo = {regfile_output_aux_919,regfile_output_aux_918,
    regfile_output_aux_917,regfile_output_aux_916,regfile_output_aux_915,regfile_output_aux_914,regfile_output_aux_913,
    regfile_output_aux_912}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_hi_hi_lo_lo = {regfile_output_aux_927,regfile_output_aux_926,
    regfile_output_aux_925,regfile_output_aux_924,regfile_output_aux_923,regfile_output_aux_922,regfile_output_aux_921,
    regfile_output_aux_920,io_regfile_output_lo_hi_hi_hi_lo_lo_hi_lo,io_regfile_output_lo_hi_hi_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_hi_lo_hi_lo_lo = {regfile_output_aux_935,regfile_output_aux_934,
    regfile_output_aux_933,regfile_output_aux_932,regfile_output_aux_931,regfile_output_aux_930,regfile_output_aux_929,
    regfile_output_aux_928}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_hi_hi_lo_hi_lo = {regfile_output_aux_943,regfile_output_aux_942,
    regfile_output_aux_941,regfile_output_aux_940,regfile_output_aux_939,regfile_output_aux_938,regfile_output_aux_937,
    regfile_output_aux_936,io_regfile_output_lo_hi_hi_hi_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_hi_lo_hi_hi_lo = {regfile_output_aux_951,regfile_output_aux_950,
    regfile_output_aux_949,regfile_output_aux_948,regfile_output_aux_947,regfile_output_aux_946,regfile_output_aux_945,
    regfile_output_aux_944}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_hi_hi_lo_hi = {regfile_output_aux_959,regfile_output_aux_958,
    regfile_output_aux_957,regfile_output_aux_956,regfile_output_aux_955,regfile_output_aux_954,regfile_output_aux_953,
    regfile_output_aux_952,io_regfile_output_lo_hi_hi_hi_lo_hi_hi_lo,io_regfile_output_lo_hi_hi_hi_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_hi_hi_lo_lo_lo = {regfile_output_aux_967,regfile_output_aux_966,
    regfile_output_aux_965,regfile_output_aux_964,regfile_output_aux_963,regfile_output_aux_962,regfile_output_aux_961,
    regfile_output_aux_960}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_hi_hi_hi_lo_lo = {regfile_output_aux_975,regfile_output_aux_974,
    regfile_output_aux_973,regfile_output_aux_972,regfile_output_aux_971,regfile_output_aux_970,regfile_output_aux_969,
    regfile_output_aux_968,io_regfile_output_lo_hi_hi_hi_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_hi_hi_lo_hi_lo = {regfile_output_aux_983,regfile_output_aux_982,
    regfile_output_aux_981,regfile_output_aux_980,regfile_output_aux_979,regfile_output_aux_978,regfile_output_aux_977,
    regfile_output_aux_976}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_hi_hi_hi_lo = {regfile_output_aux_991,regfile_output_aux_990,
    regfile_output_aux_989,regfile_output_aux_988,regfile_output_aux_987,regfile_output_aux_986,regfile_output_aux_985,
    regfile_output_aux_984,io_regfile_output_lo_hi_hi_hi_hi_lo_hi_lo,io_regfile_output_lo_hi_hi_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_hi_hi_hi_lo_lo = {regfile_output_aux_999,regfile_output_aux_998,
    regfile_output_aux_997,regfile_output_aux_996,regfile_output_aux_995,regfile_output_aux_994,regfile_output_aux_993,
    regfile_output_aux_992}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_lo_hi_hi_hi_hi_hi_lo = {regfile_output_aux_1007,regfile_output_aux_1006,
    regfile_output_aux_1005,regfile_output_aux_1004,regfile_output_aux_1003,regfile_output_aux_1002,
    regfile_output_aux_1001,regfile_output_aux_1000,io_regfile_output_lo_hi_hi_hi_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_lo_hi_hi_hi_hi_hi_hi_lo = {regfile_output_aux_1015,regfile_output_aux_1014,
    regfile_output_aux_1013,regfile_output_aux_1012,regfile_output_aux_1011,regfile_output_aux_1010,
    regfile_output_aux_1009,regfile_output_aux_1008}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_lo_hi_hi_hi_hi_hi = {regfile_output_aux_1023,regfile_output_aux_1022,
    regfile_output_aux_1021,regfile_output_aux_1020,regfile_output_aux_1019,regfile_output_aux_1018,
    regfile_output_aux_1017,regfile_output_aux_1016,io_regfile_output_lo_hi_hi_hi_hi_hi_hi_lo,
    io_regfile_output_lo_hi_hi_hi_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [1023:0] io_regfile_output_lo = {io_regfile_output_lo_hi_hi_hi_hi_hi,io_regfile_output_lo_hi_hi_hi_hi_lo,
    io_regfile_output_lo_hi_hi_hi_lo_hi,io_regfile_output_lo_hi_hi_hi_lo_lo,io_regfile_output_lo_hi_hi_lo_hi_hi,
    io_regfile_output_lo_hi_hi_lo_hi_lo,io_regfile_output_lo_hi_hi_lo_lo_hi,io_regfile_output_lo_hi_hi_lo_lo_lo,
    io_regfile_output_lo_hi_lo,io_regfile_output_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_lo_lo_lo_lo_lo = {regfile_output_aux_1031,regfile_output_aux_1030,
    regfile_output_aux_1029,regfile_output_aux_1028,regfile_output_aux_1027,regfile_output_aux_1026,
    regfile_output_aux_1025,regfile_output_aux_1024}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_lo_lo_lo_lo_lo = {regfile_output_aux_1039,regfile_output_aux_1038,
    regfile_output_aux_1037,regfile_output_aux_1036,regfile_output_aux_1035,regfile_output_aux_1034,
    regfile_output_aux_1033,regfile_output_aux_1032,io_regfile_output_hi_lo_lo_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_lo_lo_lo_hi_lo = {regfile_output_aux_1047,regfile_output_aux_1046,
    regfile_output_aux_1045,regfile_output_aux_1044,regfile_output_aux_1043,regfile_output_aux_1042,
    regfile_output_aux_1041,regfile_output_aux_1040}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_lo_lo_lo_lo = {regfile_output_aux_1055,regfile_output_aux_1054,
    regfile_output_aux_1053,regfile_output_aux_1052,regfile_output_aux_1051,regfile_output_aux_1050,
    regfile_output_aux_1049,regfile_output_aux_1048,io_regfile_output_hi_lo_lo_lo_lo_lo_hi_lo,
    io_regfile_output_hi_lo_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_lo_lo_hi_lo_lo = {regfile_output_aux_1063,regfile_output_aux_1062,
    regfile_output_aux_1061,regfile_output_aux_1060,regfile_output_aux_1059,regfile_output_aux_1058,
    regfile_output_aux_1057,regfile_output_aux_1056}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_lo_lo_lo_hi_lo = {regfile_output_aux_1071,regfile_output_aux_1070,
    regfile_output_aux_1069,regfile_output_aux_1068,regfile_output_aux_1067,regfile_output_aux_1066,
    regfile_output_aux_1065,regfile_output_aux_1064,io_regfile_output_hi_lo_lo_lo_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_lo_lo_hi_hi_lo = {regfile_output_aux_1079,regfile_output_aux_1078,
    regfile_output_aux_1077,regfile_output_aux_1076,regfile_output_aux_1075,regfile_output_aux_1074,
    regfile_output_aux_1073,regfile_output_aux_1072}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_lo_lo_lo_hi = {regfile_output_aux_1087,regfile_output_aux_1086,
    regfile_output_aux_1085,regfile_output_aux_1084,regfile_output_aux_1083,regfile_output_aux_1082,
    regfile_output_aux_1081,regfile_output_aux_1080,io_regfile_output_hi_lo_lo_lo_lo_hi_hi_lo,
    io_regfile_output_hi_lo_lo_lo_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_lo_hi_lo_lo_lo = {regfile_output_aux_1095,regfile_output_aux_1094,
    regfile_output_aux_1093,regfile_output_aux_1092,regfile_output_aux_1091,regfile_output_aux_1090,
    regfile_output_aux_1089,regfile_output_aux_1088}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_lo_lo_hi_lo_lo = {regfile_output_aux_1103,regfile_output_aux_1102,
    regfile_output_aux_1101,regfile_output_aux_1100,regfile_output_aux_1099,regfile_output_aux_1098,
    regfile_output_aux_1097,regfile_output_aux_1096,io_regfile_output_hi_lo_lo_lo_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_lo_hi_lo_hi_lo = {regfile_output_aux_1111,regfile_output_aux_1110,
    regfile_output_aux_1109,regfile_output_aux_1108,regfile_output_aux_1107,regfile_output_aux_1106,
    regfile_output_aux_1105,regfile_output_aux_1104}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_lo_lo_hi_lo = {regfile_output_aux_1119,regfile_output_aux_1118,
    regfile_output_aux_1117,regfile_output_aux_1116,regfile_output_aux_1115,regfile_output_aux_1114,
    regfile_output_aux_1113,regfile_output_aux_1112,io_regfile_output_hi_lo_lo_lo_hi_lo_hi_lo,
    io_regfile_output_hi_lo_lo_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_lo_hi_hi_lo_lo = {regfile_output_aux_1127,regfile_output_aux_1126,
    regfile_output_aux_1125,regfile_output_aux_1124,regfile_output_aux_1123,regfile_output_aux_1122,
    regfile_output_aux_1121,regfile_output_aux_1120}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_lo_lo_hi_hi_lo = {regfile_output_aux_1135,regfile_output_aux_1134,
    regfile_output_aux_1133,regfile_output_aux_1132,regfile_output_aux_1131,regfile_output_aux_1130,
    regfile_output_aux_1129,regfile_output_aux_1128,io_regfile_output_hi_lo_lo_lo_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_lo_hi_hi_hi_lo = {regfile_output_aux_1143,regfile_output_aux_1142,
    regfile_output_aux_1141,regfile_output_aux_1140,regfile_output_aux_1139,regfile_output_aux_1138,
    regfile_output_aux_1137,regfile_output_aux_1136}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_lo_lo_hi_hi = {regfile_output_aux_1151,regfile_output_aux_1150,
    regfile_output_aux_1149,regfile_output_aux_1148,regfile_output_aux_1147,regfile_output_aux_1146,
    regfile_output_aux_1145,regfile_output_aux_1144,io_regfile_output_hi_lo_lo_lo_hi_hi_hi_lo,
    io_regfile_output_hi_lo_lo_lo_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_hi_lo_lo_lo_lo = {regfile_output_aux_1159,regfile_output_aux_1158,
    regfile_output_aux_1157,regfile_output_aux_1156,regfile_output_aux_1155,regfile_output_aux_1154,
    regfile_output_aux_1153,regfile_output_aux_1152}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_lo_hi_lo_lo_lo = {regfile_output_aux_1167,regfile_output_aux_1166,
    regfile_output_aux_1165,regfile_output_aux_1164,regfile_output_aux_1163,regfile_output_aux_1162,
    regfile_output_aux_1161,regfile_output_aux_1160,io_regfile_output_hi_lo_lo_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_hi_lo_lo_hi_lo = {regfile_output_aux_1175,regfile_output_aux_1174,
    regfile_output_aux_1173,regfile_output_aux_1172,regfile_output_aux_1171,regfile_output_aux_1170,
    regfile_output_aux_1169,regfile_output_aux_1168}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_lo_hi_lo_lo = {regfile_output_aux_1183,regfile_output_aux_1182,
    regfile_output_aux_1181,regfile_output_aux_1180,regfile_output_aux_1179,regfile_output_aux_1178,
    regfile_output_aux_1177,regfile_output_aux_1176,io_regfile_output_hi_lo_lo_hi_lo_lo_hi_lo,
    io_regfile_output_hi_lo_lo_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_hi_lo_hi_lo_lo = {regfile_output_aux_1191,regfile_output_aux_1190,
    regfile_output_aux_1189,regfile_output_aux_1188,regfile_output_aux_1187,regfile_output_aux_1186,
    regfile_output_aux_1185,regfile_output_aux_1184}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_lo_hi_lo_hi_lo = {regfile_output_aux_1199,regfile_output_aux_1198,
    regfile_output_aux_1197,regfile_output_aux_1196,regfile_output_aux_1195,regfile_output_aux_1194,
    regfile_output_aux_1193,regfile_output_aux_1192,io_regfile_output_hi_lo_lo_hi_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_hi_lo_hi_hi_lo = {regfile_output_aux_1207,regfile_output_aux_1206,
    regfile_output_aux_1205,regfile_output_aux_1204,regfile_output_aux_1203,regfile_output_aux_1202,
    regfile_output_aux_1201,regfile_output_aux_1200}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_lo_hi_lo_hi = {regfile_output_aux_1215,regfile_output_aux_1214,
    regfile_output_aux_1213,regfile_output_aux_1212,regfile_output_aux_1211,regfile_output_aux_1210,
    regfile_output_aux_1209,regfile_output_aux_1208,io_regfile_output_hi_lo_lo_hi_lo_hi_hi_lo,
    io_regfile_output_hi_lo_lo_hi_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_hi_hi_lo_lo_lo = {regfile_output_aux_1223,regfile_output_aux_1222,
    regfile_output_aux_1221,regfile_output_aux_1220,regfile_output_aux_1219,regfile_output_aux_1218,
    regfile_output_aux_1217,regfile_output_aux_1216}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_lo_hi_hi_lo_lo = {regfile_output_aux_1231,regfile_output_aux_1230,
    regfile_output_aux_1229,regfile_output_aux_1228,regfile_output_aux_1227,regfile_output_aux_1226,
    regfile_output_aux_1225,regfile_output_aux_1224,io_regfile_output_hi_lo_lo_hi_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_hi_hi_lo_hi_lo = {regfile_output_aux_1239,regfile_output_aux_1238,
    regfile_output_aux_1237,regfile_output_aux_1236,regfile_output_aux_1235,regfile_output_aux_1234,
    regfile_output_aux_1233,regfile_output_aux_1232}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_lo_hi_hi_lo = {regfile_output_aux_1247,regfile_output_aux_1246,
    regfile_output_aux_1245,regfile_output_aux_1244,regfile_output_aux_1243,regfile_output_aux_1242,
    regfile_output_aux_1241,regfile_output_aux_1240,io_regfile_output_hi_lo_lo_hi_hi_lo_hi_lo,
    io_regfile_output_hi_lo_lo_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_hi_hi_hi_lo_lo = {regfile_output_aux_1255,regfile_output_aux_1254,
    regfile_output_aux_1253,regfile_output_aux_1252,regfile_output_aux_1251,regfile_output_aux_1250,
    regfile_output_aux_1249,regfile_output_aux_1248}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_lo_hi_hi_hi_lo = {regfile_output_aux_1263,regfile_output_aux_1262,
    regfile_output_aux_1261,regfile_output_aux_1260,regfile_output_aux_1259,regfile_output_aux_1258,
    regfile_output_aux_1257,regfile_output_aux_1256,io_regfile_output_hi_lo_lo_hi_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_lo_hi_hi_hi_hi_lo = {regfile_output_aux_1271,regfile_output_aux_1270,
    regfile_output_aux_1269,regfile_output_aux_1268,regfile_output_aux_1267,regfile_output_aux_1266,
    regfile_output_aux_1265,regfile_output_aux_1264}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_lo_hi_hi_hi = {regfile_output_aux_1279,regfile_output_aux_1278,
    regfile_output_aux_1277,regfile_output_aux_1276,regfile_output_aux_1275,regfile_output_aux_1274,
    regfile_output_aux_1273,regfile_output_aux_1272,io_regfile_output_hi_lo_lo_hi_hi_hi_hi_lo,
    io_regfile_output_hi_lo_lo_hi_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [255:0] io_regfile_output_hi_lo_lo = {io_regfile_output_hi_lo_lo_hi_hi_hi,io_regfile_output_hi_lo_lo_hi_hi_lo,
    io_regfile_output_hi_lo_lo_hi_lo_hi,io_regfile_output_hi_lo_lo_hi_lo_lo,io_regfile_output_hi_lo_lo_lo_hi_hi,
    io_regfile_output_hi_lo_lo_lo_hi_lo,io_regfile_output_hi_lo_lo_lo_lo_hi,io_regfile_output_hi_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_lo_lo_lo_lo_lo = {regfile_output_aux_1287,regfile_output_aux_1286,
    regfile_output_aux_1285,regfile_output_aux_1284,regfile_output_aux_1283,regfile_output_aux_1282,
    regfile_output_aux_1281,regfile_output_aux_1280}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_hi_lo_lo_lo_lo = {regfile_output_aux_1295,regfile_output_aux_1294,
    regfile_output_aux_1293,regfile_output_aux_1292,regfile_output_aux_1291,regfile_output_aux_1290,
    regfile_output_aux_1289,regfile_output_aux_1288,io_regfile_output_hi_lo_hi_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_lo_lo_lo_hi_lo = {regfile_output_aux_1303,regfile_output_aux_1302,
    regfile_output_aux_1301,regfile_output_aux_1300,regfile_output_aux_1299,regfile_output_aux_1298,
    regfile_output_aux_1297,regfile_output_aux_1296}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_hi_lo_lo_lo = {regfile_output_aux_1311,regfile_output_aux_1310,
    regfile_output_aux_1309,regfile_output_aux_1308,regfile_output_aux_1307,regfile_output_aux_1306,
    regfile_output_aux_1305,regfile_output_aux_1304,io_regfile_output_hi_lo_hi_lo_lo_lo_hi_lo,
    io_regfile_output_hi_lo_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_lo_lo_hi_lo_lo = {regfile_output_aux_1319,regfile_output_aux_1318,
    regfile_output_aux_1317,regfile_output_aux_1316,regfile_output_aux_1315,regfile_output_aux_1314,
    regfile_output_aux_1313,regfile_output_aux_1312}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_hi_lo_lo_hi_lo = {regfile_output_aux_1327,regfile_output_aux_1326,
    regfile_output_aux_1325,regfile_output_aux_1324,regfile_output_aux_1323,regfile_output_aux_1322,
    regfile_output_aux_1321,regfile_output_aux_1320,io_regfile_output_hi_lo_hi_lo_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_lo_lo_hi_hi_lo = {regfile_output_aux_1335,regfile_output_aux_1334,
    regfile_output_aux_1333,regfile_output_aux_1332,regfile_output_aux_1331,regfile_output_aux_1330,
    regfile_output_aux_1329,regfile_output_aux_1328}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_hi_lo_lo_hi = {regfile_output_aux_1343,regfile_output_aux_1342,
    regfile_output_aux_1341,regfile_output_aux_1340,regfile_output_aux_1339,regfile_output_aux_1338,
    regfile_output_aux_1337,regfile_output_aux_1336,io_regfile_output_hi_lo_hi_lo_lo_hi_hi_lo,
    io_regfile_output_hi_lo_hi_lo_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_lo_hi_lo_lo_lo = {regfile_output_aux_1351,regfile_output_aux_1350,
    regfile_output_aux_1349,regfile_output_aux_1348,regfile_output_aux_1347,regfile_output_aux_1346,
    regfile_output_aux_1345,regfile_output_aux_1344}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_hi_lo_hi_lo_lo = {regfile_output_aux_1359,regfile_output_aux_1358,
    regfile_output_aux_1357,regfile_output_aux_1356,regfile_output_aux_1355,regfile_output_aux_1354,
    regfile_output_aux_1353,regfile_output_aux_1352,io_regfile_output_hi_lo_hi_lo_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_lo_hi_lo_hi_lo = {regfile_output_aux_1367,regfile_output_aux_1366,
    regfile_output_aux_1365,regfile_output_aux_1364,regfile_output_aux_1363,regfile_output_aux_1362,
    regfile_output_aux_1361,regfile_output_aux_1360}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_hi_lo_hi_lo = {regfile_output_aux_1375,regfile_output_aux_1374,
    regfile_output_aux_1373,regfile_output_aux_1372,regfile_output_aux_1371,regfile_output_aux_1370,
    regfile_output_aux_1369,regfile_output_aux_1368,io_regfile_output_hi_lo_hi_lo_hi_lo_hi_lo,
    io_regfile_output_hi_lo_hi_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_lo_hi_hi_lo_lo = {regfile_output_aux_1383,regfile_output_aux_1382,
    regfile_output_aux_1381,regfile_output_aux_1380,regfile_output_aux_1379,regfile_output_aux_1378,
    regfile_output_aux_1377,regfile_output_aux_1376}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_hi_lo_hi_hi_lo = {regfile_output_aux_1391,regfile_output_aux_1390,
    regfile_output_aux_1389,regfile_output_aux_1388,regfile_output_aux_1387,regfile_output_aux_1386,
    regfile_output_aux_1385,regfile_output_aux_1384,io_regfile_output_hi_lo_hi_lo_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_lo_hi_hi_hi_lo = {regfile_output_aux_1399,regfile_output_aux_1398,
    regfile_output_aux_1397,regfile_output_aux_1396,regfile_output_aux_1395,regfile_output_aux_1394,
    regfile_output_aux_1393,regfile_output_aux_1392}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_hi_lo_hi_hi = {regfile_output_aux_1407,regfile_output_aux_1406,
    regfile_output_aux_1405,regfile_output_aux_1404,regfile_output_aux_1403,regfile_output_aux_1402,
    regfile_output_aux_1401,regfile_output_aux_1400,io_regfile_output_hi_lo_hi_lo_hi_hi_hi_lo,
    io_regfile_output_hi_lo_hi_lo_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_hi_lo_lo_lo_lo = {regfile_output_aux_1415,regfile_output_aux_1414,
    regfile_output_aux_1413,regfile_output_aux_1412,regfile_output_aux_1411,regfile_output_aux_1410,
    regfile_output_aux_1409,regfile_output_aux_1408}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_hi_hi_lo_lo_lo = {regfile_output_aux_1423,regfile_output_aux_1422,
    regfile_output_aux_1421,regfile_output_aux_1420,regfile_output_aux_1419,regfile_output_aux_1418,
    regfile_output_aux_1417,regfile_output_aux_1416,io_regfile_output_hi_lo_hi_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_hi_lo_lo_hi_lo = {regfile_output_aux_1431,regfile_output_aux_1430,
    regfile_output_aux_1429,regfile_output_aux_1428,regfile_output_aux_1427,regfile_output_aux_1426,
    regfile_output_aux_1425,regfile_output_aux_1424}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_hi_hi_lo_lo = {regfile_output_aux_1439,regfile_output_aux_1438,
    regfile_output_aux_1437,regfile_output_aux_1436,regfile_output_aux_1435,regfile_output_aux_1434,
    regfile_output_aux_1433,regfile_output_aux_1432,io_regfile_output_hi_lo_hi_hi_lo_lo_hi_lo,
    io_regfile_output_hi_lo_hi_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_hi_lo_hi_lo_lo = {regfile_output_aux_1447,regfile_output_aux_1446,
    regfile_output_aux_1445,regfile_output_aux_1444,regfile_output_aux_1443,regfile_output_aux_1442,
    regfile_output_aux_1441,regfile_output_aux_1440}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_hi_hi_lo_hi_lo = {regfile_output_aux_1455,regfile_output_aux_1454,
    regfile_output_aux_1453,regfile_output_aux_1452,regfile_output_aux_1451,regfile_output_aux_1450,
    regfile_output_aux_1449,regfile_output_aux_1448,io_regfile_output_hi_lo_hi_hi_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_hi_lo_hi_hi_lo = {regfile_output_aux_1463,regfile_output_aux_1462,
    regfile_output_aux_1461,regfile_output_aux_1460,regfile_output_aux_1459,regfile_output_aux_1458,
    regfile_output_aux_1457,regfile_output_aux_1456}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_hi_hi_lo_hi = {regfile_output_aux_1471,regfile_output_aux_1470,
    regfile_output_aux_1469,regfile_output_aux_1468,regfile_output_aux_1467,regfile_output_aux_1466,
    regfile_output_aux_1465,regfile_output_aux_1464,io_regfile_output_hi_lo_hi_hi_lo_hi_hi_lo,
    io_regfile_output_hi_lo_hi_hi_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_hi_hi_lo_lo_lo = {regfile_output_aux_1479,regfile_output_aux_1478,
    regfile_output_aux_1477,regfile_output_aux_1476,regfile_output_aux_1475,regfile_output_aux_1474,
    regfile_output_aux_1473,regfile_output_aux_1472}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_hi_hi_hi_lo_lo = {regfile_output_aux_1487,regfile_output_aux_1486,
    regfile_output_aux_1485,regfile_output_aux_1484,regfile_output_aux_1483,regfile_output_aux_1482,
    regfile_output_aux_1481,regfile_output_aux_1480,io_regfile_output_hi_lo_hi_hi_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_hi_hi_lo_hi_lo = {regfile_output_aux_1495,regfile_output_aux_1494,
    regfile_output_aux_1493,regfile_output_aux_1492,regfile_output_aux_1491,regfile_output_aux_1490,
    regfile_output_aux_1489,regfile_output_aux_1488}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_hi_hi_hi_lo = {regfile_output_aux_1503,regfile_output_aux_1502,
    regfile_output_aux_1501,regfile_output_aux_1500,regfile_output_aux_1499,regfile_output_aux_1498,
    regfile_output_aux_1497,regfile_output_aux_1496,io_regfile_output_hi_lo_hi_hi_hi_lo_hi_lo,
    io_regfile_output_hi_lo_hi_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_hi_hi_hi_lo_lo = {regfile_output_aux_1511,regfile_output_aux_1510,
    regfile_output_aux_1509,regfile_output_aux_1508,regfile_output_aux_1507,regfile_output_aux_1506,
    regfile_output_aux_1505,regfile_output_aux_1504}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_lo_hi_hi_hi_hi_lo = {regfile_output_aux_1519,regfile_output_aux_1518,
    regfile_output_aux_1517,regfile_output_aux_1516,regfile_output_aux_1515,regfile_output_aux_1514,
    regfile_output_aux_1513,regfile_output_aux_1512,io_regfile_output_hi_lo_hi_hi_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_lo_hi_hi_hi_hi_hi_lo = {regfile_output_aux_1527,regfile_output_aux_1526,
    regfile_output_aux_1525,regfile_output_aux_1524,regfile_output_aux_1523,regfile_output_aux_1522,
    regfile_output_aux_1521,regfile_output_aux_1520}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_lo_hi_hi_hi_hi = {regfile_output_aux_1535,regfile_output_aux_1534,
    regfile_output_aux_1533,regfile_output_aux_1532,regfile_output_aux_1531,regfile_output_aux_1530,
    regfile_output_aux_1529,regfile_output_aux_1528,io_regfile_output_hi_lo_hi_hi_hi_hi_hi_lo,
    io_regfile_output_hi_lo_hi_hi_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [511:0] io_regfile_output_hi_lo = {io_regfile_output_hi_lo_hi_hi_hi_hi,io_regfile_output_hi_lo_hi_hi_hi_lo,
    io_regfile_output_hi_lo_hi_hi_lo_hi,io_regfile_output_hi_lo_hi_hi_lo_lo,io_regfile_output_hi_lo_hi_lo_hi_hi,
    io_regfile_output_hi_lo_hi_lo_hi_lo,io_regfile_output_hi_lo_hi_lo_lo_hi,io_regfile_output_hi_lo_hi_lo_lo_lo,
    io_regfile_output_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_lo_lo_lo_lo_lo = {regfile_output_aux_1543,regfile_output_aux_1542,
    regfile_output_aux_1541,regfile_output_aux_1540,regfile_output_aux_1539,regfile_output_aux_1538,
    regfile_output_aux_1537,regfile_output_aux_1536}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_lo_lo_lo_lo_lo = {regfile_output_aux_1551,regfile_output_aux_1550,
    regfile_output_aux_1549,regfile_output_aux_1548,regfile_output_aux_1547,regfile_output_aux_1546,
    regfile_output_aux_1545,regfile_output_aux_1544,io_regfile_output_hi_hi_lo_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_lo_lo_lo_hi_lo = {regfile_output_aux_1559,regfile_output_aux_1558,
    regfile_output_aux_1557,regfile_output_aux_1556,regfile_output_aux_1555,regfile_output_aux_1554,
    regfile_output_aux_1553,regfile_output_aux_1552}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_lo_lo_lo_lo = {regfile_output_aux_1567,regfile_output_aux_1566,
    regfile_output_aux_1565,regfile_output_aux_1564,regfile_output_aux_1563,regfile_output_aux_1562,
    regfile_output_aux_1561,regfile_output_aux_1560,io_regfile_output_hi_hi_lo_lo_lo_lo_hi_lo,
    io_regfile_output_hi_hi_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_lo_lo_hi_lo_lo = {regfile_output_aux_1575,regfile_output_aux_1574,
    regfile_output_aux_1573,regfile_output_aux_1572,regfile_output_aux_1571,regfile_output_aux_1570,
    regfile_output_aux_1569,regfile_output_aux_1568}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_lo_lo_lo_hi_lo = {regfile_output_aux_1583,regfile_output_aux_1582,
    regfile_output_aux_1581,regfile_output_aux_1580,regfile_output_aux_1579,regfile_output_aux_1578,
    regfile_output_aux_1577,regfile_output_aux_1576,io_regfile_output_hi_hi_lo_lo_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_lo_lo_hi_hi_lo = {regfile_output_aux_1591,regfile_output_aux_1590,
    regfile_output_aux_1589,regfile_output_aux_1588,regfile_output_aux_1587,regfile_output_aux_1586,
    regfile_output_aux_1585,regfile_output_aux_1584}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_lo_lo_lo_hi = {regfile_output_aux_1599,regfile_output_aux_1598,
    regfile_output_aux_1597,regfile_output_aux_1596,regfile_output_aux_1595,regfile_output_aux_1594,
    regfile_output_aux_1593,regfile_output_aux_1592,io_regfile_output_hi_hi_lo_lo_lo_hi_hi_lo,
    io_regfile_output_hi_hi_lo_lo_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_lo_hi_lo_lo_lo = {regfile_output_aux_1607,regfile_output_aux_1606,
    regfile_output_aux_1605,regfile_output_aux_1604,regfile_output_aux_1603,regfile_output_aux_1602,
    regfile_output_aux_1601,regfile_output_aux_1600}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_lo_lo_hi_lo_lo = {regfile_output_aux_1615,regfile_output_aux_1614,
    regfile_output_aux_1613,regfile_output_aux_1612,regfile_output_aux_1611,regfile_output_aux_1610,
    regfile_output_aux_1609,regfile_output_aux_1608,io_regfile_output_hi_hi_lo_lo_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_lo_hi_lo_hi_lo = {regfile_output_aux_1623,regfile_output_aux_1622,
    regfile_output_aux_1621,regfile_output_aux_1620,regfile_output_aux_1619,regfile_output_aux_1618,
    regfile_output_aux_1617,regfile_output_aux_1616}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_lo_lo_hi_lo = {regfile_output_aux_1631,regfile_output_aux_1630,
    regfile_output_aux_1629,regfile_output_aux_1628,regfile_output_aux_1627,regfile_output_aux_1626,
    regfile_output_aux_1625,regfile_output_aux_1624,io_regfile_output_hi_hi_lo_lo_hi_lo_hi_lo,
    io_regfile_output_hi_hi_lo_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_lo_hi_hi_lo_lo = {regfile_output_aux_1639,regfile_output_aux_1638,
    regfile_output_aux_1637,regfile_output_aux_1636,regfile_output_aux_1635,regfile_output_aux_1634,
    regfile_output_aux_1633,regfile_output_aux_1632}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_lo_lo_hi_hi_lo = {regfile_output_aux_1647,regfile_output_aux_1646,
    regfile_output_aux_1645,regfile_output_aux_1644,regfile_output_aux_1643,regfile_output_aux_1642,
    regfile_output_aux_1641,regfile_output_aux_1640,io_regfile_output_hi_hi_lo_lo_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_lo_hi_hi_hi_lo = {regfile_output_aux_1655,regfile_output_aux_1654,
    regfile_output_aux_1653,regfile_output_aux_1652,regfile_output_aux_1651,regfile_output_aux_1650,
    regfile_output_aux_1649,regfile_output_aux_1648}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_lo_lo_hi_hi = {regfile_output_aux_1663,regfile_output_aux_1662,
    regfile_output_aux_1661,regfile_output_aux_1660,regfile_output_aux_1659,regfile_output_aux_1658,
    regfile_output_aux_1657,regfile_output_aux_1656,io_regfile_output_hi_hi_lo_lo_hi_hi_hi_lo,
    io_regfile_output_hi_hi_lo_lo_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_hi_lo_lo_lo_lo = {regfile_output_aux_1671,regfile_output_aux_1670,
    regfile_output_aux_1669,regfile_output_aux_1668,regfile_output_aux_1667,regfile_output_aux_1666,
    regfile_output_aux_1665,regfile_output_aux_1664}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_lo_hi_lo_lo_lo = {regfile_output_aux_1679,regfile_output_aux_1678,
    regfile_output_aux_1677,regfile_output_aux_1676,regfile_output_aux_1675,regfile_output_aux_1674,
    regfile_output_aux_1673,regfile_output_aux_1672,io_regfile_output_hi_hi_lo_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_hi_lo_lo_hi_lo = {regfile_output_aux_1687,regfile_output_aux_1686,
    regfile_output_aux_1685,regfile_output_aux_1684,regfile_output_aux_1683,regfile_output_aux_1682,
    regfile_output_aux_1681,regfile_output_aux_1680}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_lo_hi_lo_lo = {regfile_output_aux_1695,regfile_output_aux_1694,
    regfile_output_aux_1693,regfile_output_aux_1692,regfile_output_aux_1691,regfile_output_aux_1690,
    regfile_output_aux_1689,regfile_output_aux_1688,io_regfile_output_hi_hi_lo_hi_lo_lo_hi_lo,
    io_regfile_output_hi_hi_lo_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_hi_lo_hi_lo_lo = {regfile_output_aux_1703,regfile_output_aux_1702,
    regfile_output_aux_1701,regfile_output_aux_1700,regfile_output_aux_1699,regfile_output_aux_1698,
    regfile_output_aux_1697,regfile_output_aux_1696}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_lo_hi_lo_hi_lo = {regfile_output_aux_1711,regfile_output_aux_1710,
    regfile_output_aux_1709,regfile_output_aux_1708,regfile_output_aux_1707,regfile_output_aux_1706,
    regfile_output_aux_1705,regfile_output_aux_1704,io_regfile_output_hi_hi_lo_hi_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_hi_lo_hi_hi_lo = {regfile_output_aux_1719,regfile_output_aux_1718,
    regfile_output_aux_1717,regfile_output_aux_1716,regfile_output_aux_1715,regfile_output_aux_1714,
    regfile_output_aux_1713,regfile_output_aux_1712}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_lo_hi_lo_hi = {regfile_output_aux_1727,regfile_output_aux_1726,
    regfile_output_aux_1725,regfile_output_aux_1724,regfile_output_aux_1723,regfile_output_aux_1722,
    regfile_output_aux_1721,regfile_output_aux_1720,io_regfile_output_hi_hi_lo_hi_lo_hi_hi_lo,
    io_regfile_output_hi_hi_lo_hi_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_hi_hi_lo_lo_lo = {regfile_output_aux_1735,regfile_output_aux_1734,
    regfile_output_aux_1733,regfile_output_aux_1732,regfile_output_aux_1731,regfile_output_aux_1730,
    regfile_output_aux_1729,regfile_output_aux_1728}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_lo_hi_hi_lo_lo = {regfile_output_aux_1743,regfile_output_aux_1742,
    regfile_output_aux_1741,regfile_output_aux_1740,regfile_output_aux_1739,regfile_output_aux_1738,
    regfile_output_aux_1737,regfile_output_aux_1736,io_regfile_output_hi_hi_lo_hi_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_hi_hi_lo_hi_lo = {regfile_output_aux_1751,regfile_output_aux_1750,
    regfile_output_aux_1749,regfile_output_aux_1748,regfile_output_aux_1747,regfile_output_aux_1746,
    regfile_output_aux_1745,regfile_output_aux_1744}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_lo_hi_hi_lo = {regfile_output_aux_1759,regfile_output_aux_1758,
    regfile_output_aux_1757,regfile_output_aux_1756,regfile_output_aux_1755,regfile_output_aux_1754,
    regfile_output_aux_1753,regfile_output_aux_1752,io_regfile_output_hi_hi_lo_hi_hi_lo_hi_lo,
    io_regfile_output_hi_hi_lo_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_hi_hi_hi_lo_lo = {regfile_output_aux_1767,regfile_output_aux_1766,
    regfile_output_aux_1765,regfile_output_aux_1764,regfile_output_aux_1763,regfile_output_aux_1762,
    regfile_output_aux_1761,regfile_output_aux_1760}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_lo_hi_hi_hi_lo = {regfile_output_aux_1775,regfile_output_aux_1774,
    regfile_output_aux_1773,regfile_output_aux_1772,regfile_output_aux_1771,regfile_output_aux_1770,
    regfile_output_aux_1769,regfile_output_aux_1768,io_regfile_output_hi_hi_lo_hi_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_lo_hi_hi_hi_hi_lo = {regfile_output_aux_1783,regfile_output_aux_1782,
    regfile_output_aux_1781,regfile_output_aux_1780,regfile_output_aux_1779,regfile_output_aux_1778,
    regfile_output_aux_1777,regfile_output_aux_1776}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_lo_hi_hi_hi = {regfile_output_aux_1791,regfile_output_aux_1790,
    regfile_output_aux_1789,regfile_output_aux_1788,regfile_output_aux_1787,regfile_output_aux_1786,
    regfile_output_aux_1785,regfile_output_aux_1784,io_regfile_output_hi_hi_lo_hi_hi_hi_hi_lo,
    io_regfile_output_hi_hi_lo_hi_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [255:0] io_regfile_output_hi_hi_lo = {io_regfile_output_hi_hi_lo_hi_hi_hi,io_regfile_output_hi_hi_lo_hi_hi_lo,
    io_regfile_output_hi_hi_lo_hi_lo_hi,io_regfile_output_hi_hi_lo_hi_lo_lo,io_regfile_output_hi_hi_lo_lo_hi_hi,
    io_regfile_output_hi_hi_lo_lo_hi_lo,io_regfile_output_hi_hi_lo_lo_lo_hi,io_regfile_output_hi_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_lo_lo_lo_lo_lo = {regfile_output_aux_1799,regfile_output_aux_1798,
    regfile_output_aux_1797,regfile_output_aux_1796,regfile_output_aux_1795,regfile_output_aux_1794,
    regfile_output_aux_1793,regfile_output_aux_1792}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_hi_lo_lo_lo_lo = {regfile_output_aux_1807,regfile_output_aux_1806,
    regfile_output_aux_1805,regfile_output_aux_1804,regfile_output_aux_1803,regfile_output_aux_1802,
    regfile_output_aux_1801,regfile_output_aux_1800,io_regfile_output_hi_hi_hi_lo_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_lo_lo_lo_hi_lo = {regfile_output_aux_1815,regfile_output_aux_1814,
    regfile_output_aux_1813,regfile_output_aux_1812,regfile_output_aux_1811,regfile_output_aux_1810,
    regfile_output_aux_1809,regfile_output_aux_1808}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_hi_lo_lo_lo = {regfile_output_aux_1823,regfile_output_aux_1822,
    regfile_output_aux_1821,regfile_output_aux_1820,regfile_output_aux_1819,regfile_output_aux_1818,
    regfile_output_aux_1817,regfile_output_aux_1816,io_regfile_output_hi_hi_hi_lo_lo_lo_hi_lo,
    io_regfile_output_hi_hi_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_lo_lo_hi_lo_lo = {regfile_output_aux_1831,regfile_output_aux_1830,
    regfile_output_aux_1829,regfile_output_aux_1828,regfile_output_aux_1827,regfile_output_aux_1826,
    regfile_output_aux_1825,regfile_output_aux_1824}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_hi_lo_lo_hi_lo = {regfile_output_aux_1839,regfile_output_aux_1838,
    regfile_output_aux_1837,regfile_output_aux_1836,regfile_output_aux_1835,regfile_output_aux_1834,
    regfile_output_aux_1833,regfile_output_aux_1832,io_regfile_output_hi_hi_hi_lo_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_lo_lo_hi_hi_lo = {regfile_output_aux_1847,regfile_output_aux_1846,
    regfile_output_aux_1845,regfile_output_aux_1844,regfile_output_aux_1843,regfile_output_aux_1842,
    regfile_output_aux_1841,regfile_output_aux_1840}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_hi_lo_lo_hi = {regfile_output_aux_1855,regfile_output_aux_1854,
    regfile_output_aux_1853,regfile_output_aux_1852,regfile_output_aux_1851,regfile_output_aux_1850,
    regfile_output_aux_1849,regfile_output_aux_1848,io_regfile_output_hi_hi_hi_lo_lo_hi_hi_lo,
    io_regfile_output_hi_hi_hi_lo_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_lo_hi_lo_lo_lo = {regfile_output_aux_1863,regfile_output_aux_1862,
    regfile_output_aux_1861,regfile_output_aux_1860,regfile_output_aux_1859,regfile_output_aux_1858,
    regfile_output_aux_1857,regfile_output_aux_1856}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_hi_lo_hi_lo_lo = {regfile_output_aux_1871,regfile_output_aux_1870,
    regfile_output_aux_1869,regfile_output_aux_1868,regfile_output_aux_1867,regfile_output_aux_1866,
    regfile_output_aux_1865,regfile_output_aux_1864,io_regfile_output_hi_hi_hi_lo_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_lo_hi_lo_hi_lo = {regfile_output_aux_1879,regfile_output_aux_1878,
    regfile_output_aux_1877,regfile_output_aux_1876,regfile_output_aux_1875,regfile_output_aux_1874,
    regfile_output_aux_1873,regfile_output_aux_1872}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_hi_lo_hi_lo = {regfile_output_aux_1887,regfile_output_aux_1886,
    regfile_output_aux_1885,regfile_output_aux_1884,regfile_output_aux_1883,regfile_output_aux_1882,
    regfile_output_aux_1881,regfile_output_aux_1880,io_regfile_output_hi_hi_hi_lo_hi_lo_hi_lo,
    io_regfile_output_hi_hi_hi_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_lo_hi_hi_lo_lo = {regfile_output_aux_1895,regfile_output_aux_1894,
    regfile_output_aux_1893,regfile_output_aux_1892,regfile_output_aux_1891,regfile_output_aux_1890,
    regfile_output_aux_1889,regfile_output_aux_1888}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_hi_lo_hi_hi_lo = {regfile_output_aux_1903,regfile_output_aux_1902,
    regfile_output_aux_1901,regfile_output_aux_1900,regfile_output_aux_1899,regfile_output_aux_1898,
    regfile_output_aux_1897,regfile_output_aux_1896,io_regfile_output_hi_hi_hi_lo_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_lo_hi_hi_hi_lo = {regfile_output_aux_1911,regfile_output_aux_1910,
    regfile_output_aux_1909,regfile_output_aux_1908,regfile_output_aux_1907,regfile_output_aux_1906,
    regfile_output_aux_1905,regfile_output_aux_1904}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_hi_lo_hi_hi = {regfile_output_aux_1919,regfile_output_aux_1918,
    regfile_output_aux_1917,regfile_output_aux_1916,regfile_output_aux_1915,regfile_output_aux_1914,
    regfile_output_aux_1913,regfile_output_aux_1912,io_regfile_output_hi_hi_hi_lo_hi_hi_hi_lo,
    io_regfile_output_hi_hi_hi_lo_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_hi_lo_lo_lo_lo = {regfile_output_aux_1927,regfile_output_aux_1926,
    regfile_output_aux_1925,regfile_output_aux_1924,regfile_output_aux_1923,regfile_output_aux_1922,
    regfile_output_aux_1921,regfile_output_aux_1920}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_hi_hi_lo_lo_lo = {regfile_output_aux_1935,regfile_output_aux_1934,
    regfile_output_aux_1933,regfile_output_aux_1932,regfile_output_aux_1931,regfile_output_aux_1930,
    regfile_output_aux_1929,regfile_output_aux_1928,io_regfile_output_hi_hi_hi_hi_lo_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_hi_lo_lo_hi_lo = {regfile_output_aux_1943,regfile_output_aux_1942,
    regfile_output_aux_1941,regfile_output_aux_1940,regfile_output_aux_1939,regfile_output_aux_1938,
    regfile_output_aux_1937,regfile_output_aux_1936}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_hi_hi_lo_lo = {regfile_output_aux_1951,regfile_output_aux_1950,
    regfile_output_aux_1949,regfile_output_aux_1948,regfile_output_aux_1947,regfile_output_aux_1946,
    regfile_output_aux_1945,regfile_output_aux_1944,io_regfile_output_hi_hi_hi_hi_lo_lo_hi_lo,
    io_regfile_output_hi_hi_hi_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_hi_lo_hi_lo_lo = {regfile_output_aux_1959,regfile_output_aux_1958,
    regfile_output_aux_1957,regfile_output_aux_1956,regfile_output_aux_1955,regfile_output_aux_1954,
    regfile_output_aux_1953,regfile_output_aux_1952}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_hi_hi_lo_hi_lo = {regfile_output_aux_1967,regfile_output_aux_1966,
    regfile_output_aux_1965,regfile_output_aux_1964,regfile_output_aux_1963,regfile_output_aux_1962,
    regfile_output_aux_1961,regfile_output_aux_1960,io_regfile_output_hi_hi_hi_hi_lo_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_hi_lo_hi_hi_lo = {regfile_output_aux_1975,regfile_output_aux_1974,
    regfile_output_aux_1973,regfile_output_aux_1972,regfile_output_aux_1971,regfile_output_aux_1970,
    regfile_output_aux_1969,regfile_output_aux_1968}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_hi_hi_lo_hi = {regfile_output_aux_1983,regfile_output_aux_1982,
    regfile_output_aux_1981,regfile_output_aux_1980,regfile_output_aux_1979,regfile_output_aux_1978,
    regfile_output_aux_1977,regfile_output_aux_1976,io_regfile_output_hi_hi_hi_hi_lo_hi_hi_lo,
    io_regfile_output_hi_hi_hi_hi_lo_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_hi_hi_lo_lo_lo = {regfile_output_aux_1991,regfile_output_aux_1990,
    regfile_output_aux_1989,regfile_output_aux_1988,regfile_output_aux_1987,regfile_output_aux_1986,
    regfile_output_aux_1985,regfile_output_aux_1984}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_hi_hi_hi_lo_lo = {regfile_output_aux_1999,regfile_output_aux_1998,
    regfile_output_aux_1997,regfile_output_aux_1996,regfile_output_aux_1995,regfile_output_aux_1994,
    regfile_output_aux_1993,regfile_output_aux_1992,io_regfile_output_hi_hi_hi_hi_hi_lo_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_hi_hi_lo_hi_lo = {regfile_output_aux_2007,regfile_output_aux_2006,
    regfile_output_aux_2005,regfile_output_aux_2004,regfile_output_aux_2003,regfile_output_aux_2002,
    regfile_output_aux_2001,regfile_output_aux_2000}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_hi_hi_hi_lo = {regfile_output_aux_2015,regfile_output_aux_2014,
    regfile_output_aux_2013,regfile_output_aux_2012,regfile_output_aux_2011,regfile_output_aux_2010,
    regfile_output_aux_2009,regfile_output_aux_2008,io_regfile_output_hi_hi_hi_hi_hi_lo_hi_lo,
    io_regfile_output_hi_hi_hi_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_hi_hi_hi_lo_lo = {regfile_output_aux_2023,regfile_output_aux_2022,
    regfile_output_aux_2021,regfile_output_aux_2020,regfile_output_aux_2019,regfile_output_aux_2018,
    regfile_output_aux_2017,regfile_output_aux_2016}; // @[EXU.scala 38:43]
  wire [15:0] io_regfile_output_hi_hi_hi_hi_hi_hi_lo = {regfile_output_aux_2031,regfile_output_aux_2030,
    regfile_output_aux_2029,regfile_output_aux_2028,regfile_output_aux_2027,regfile_output_aux_2026,
    regfile_output_aux_2025,regfile_output_aux_2024,io_regfile_output_hi_hi_hi_hi_hi_hi_lo_lo}; // @[EXU.scala 38:43]
  wire [7:0] io_regfile_output_hi_hi_hi_hi_hi_hi_hi_lo = {regfile_output_aux_2039,regfile_output_aux_2038,
    regfile_output_aux_2037,regfile_output_aux_2036,regfile_output_aux_2035,regfile_output_aux_2034,
    regfile_output_aux_2033,regfile_output_aux_2032}; // @[EXU.scala 38:43]
  wire [31:0] io_regfile_output_hi_hi_hi_hi_hi_hi = {regfile_output_aux_2047,regfile_output_aux_2046,
    regfile_output_aux_2045,regfile_output_aux_2044,regfile_output_aux_2043,regfile_output_aux_2042,
    regfile_output_aux_2041,regfile_output_aux_2040,io_regfile_output_hi_hi_hi_hi_hi_hi_hi_lo,
    io_regfile_output_hi_hi_hi_hi_hi_hi_lo}; // @[EXU.scala 38:43]
  wire [1023:0] io_regfile_output_hi = {io_regfile_output_hi_hi_hi_hi_hi_hi,io_regfile_output_hi_hi_hi_hi_hi_lo,
    io_regfile_output_hi_hi_hi_hi_lo_hi,io_regfile_output_hi_hi_hi_hi_lo_lo,io_regfile_output_hi_hi_hi_lo_hi_hi,
    io_regfile_output_hi_hi_hi_lo_hi_lo,io_regfile_output_hi_hi_hi_lo_lo_hi,io_regfile_output_hi_hi_hi_lo_lo_lo,
    io_regfile_output_hi_hi_lo,io_regfile_output_hi_lo}; // @[EXU.scala 38:43]
  wire [7:0] _io_mem_write_msk_T_3 = _mem_in_result_T_20 ? 8'h1 : 8'hff; // @[Mux.scala 101:16]
  wire [7:0] _io_mem_write_msk_T_4 = _mem_in_result_T_10 ? 8'h3 : _io_mem_write_msk_T_3; // @[Mux.scala 101:16]
  wire [11:0] imm_b = {io_inst[31],io_inst[7],io_inst[30:25],io_inst[11:8]}; // @[Cat.scala 33:92]
  wire [19:0] imm_j = {io_inst[31],io_inst[19:12],io_inst[20],io_inst[30:21]}; // @[Cat.scala 33:92]
  wire [50:0] _imm_b_sext_T_2 = imm_b[11] ? 51'h7ffffffffffff : 51'h0; // @[Bitwise.scala 77:12]
  wire [63:0] imm_b_sext = {_imm_b_sext_T_2,io_inst[31],io_inst[7],io_inst[30:25],io_inst[11:8],1'h0}; // @[Cat.scala 33:92]
  wire [42:0] _imm_j_sext_T_2 = imm_j[19] ? 43'h7ffffffffff : 43'h0; // @[Bitwise.scala 77:12]
  wire [63:0] imm_j_sext = {_imm_j_sext_T_2,io_inst[31],io_inst[19:12],io_inst[20],io_inst[30:21],1'h0}; // @[Cat.scala 33:92]
  wire [63:0] _io_idu_to_exu_br_lt_T = rs1_addr != 5'h0 ? _GEN_95 : 64'h0; // @[EXU.scala 136:37]
  wire [63:0] _io_idu_to_exu_br_lt_T_1 = rs2_addr != 5'h0 ? _GEN_127 : 64'h0; // @[EXU.scala 136:55]
  wire [63:0] _br_target_T_1 = io_ifu_to_exu_pc + imm_b_sext; // @[EXU.scala 145:34]
  wire [63:0] _jmp_target_T_1 = io_ifu_to_exu_pc + imm_j_sext; // @[EXU.scala 146:34]
  wire [63:0] _jr_target_T_1 = rs1_data + imm_i_sext; // @[EXU.scala 147:26]
  wire  _io_ifu_to_exu_pc_next_T = io_idu_to_exu_pc_sel == 4'h0; // @[EXU.scala 150:38]
  wire  _io_ifu_to_exu_pc_next_T_1 = io_idu_to_exu_pc_sel == 4'h1; // @[EXU.scala 151:38]
  wire  _io_ifu_to_exu_pc_next_T_2 = io_idu_to_exu_pc_sel == 4'h2; // @[EXU.scala 152:38]
  wire  _io_ifu_to_exu_pc_next_T_3 = io_idu_to_exu_pc_sel == 4'h3; // @[EXU.scala 153:38]
  wire [31:0] jr_target = _jr_target_T_1[31:0]; // @[EXU.scala 141:30 147:14]
  wire [31:0] _io_ifu_to_exu_pc_next_T_4 = _io_ifu_to_exu_pc_next_T_3 ? jr_target : pc_plus4; // @[Mux.scala 101:16]
  wire [31:0] jmp_target = _jmp_target_T_1[31:0]; // @[EXU.scala 140:30 146:14]
  wire [31:0] _io_ifu_to_exu_pc_next_T_5 = _io_ifu_to_exu_pc_next_T_2 ? jmp_target : _io_ifu_to_exu_pc_next_T_4; // @[Mux.scala 101:16]
  wire [31:0] br_target = _br_target_T_1[31:0]; // @[EXU.scala 139:30 145:14]
  wire [31:0] _io_ifu_to_exu_pc_next_T_6 = _io_ifu_to_exu_pc_next_T_1 ? br_target : _io_ifu_to_exu_pc_next_T_5; // @[Mux.scala 101:16]
  wire [31:0] _io_ifu_to_exu_pc_next_T_7 = _io_ifu_to_exu_pc_next_T ? pc_plus4 : _io_ifu_to_exu_pc_next_T_6; // @[Mux.scala 101:16]
  assign io_idu_to_exu_br_eq = rs1_data == rs2_data; // @[EXU.scala 135:37]
  assign io_idu_to_exu_br_lt = $signed(_io_idu_to_exu_br_lt_T) < $signed(_io_idu_to_exu_br_lt_T_1); // @[EXU.scala 136:44]
  assign io_idu_to_exu_br_ltu = rs1_data < rs2_data; // @[EXU.scala 137:44]
  assign io_ifu_to_exu_pc_next = {{32'd0}, _io_ifu_to_exu_pc_next_T_7}; // @[EXU.scala 149:25]
  assign io_regfile_output = {io_regfile_output_hi,io_regfile_output_lo}; // @[EXU.scala 38:43]
  assign io_mem_addr = io_idu_to_exu_alu_msk_type ? _alu_out_T_5 : alu_out_aux; // @[Mux.scala 101:16]
  assign io_mem_write_data = rs2_addr != 5'h0 ? _GEN_127 : 64'h0; // @[EXU.scala 59:21]
  assign io_isRead = io_idu_to_exu_wb_sel == 2'h1; // @[EXU.scala 158:38]
  assign io_mem_write_msk = _mem_in_result_T ? 8'hf : _io_mem_write_msk_T_4; // @[Mux.scala 101:16]
  always @(posedge clock) begin
    if (reset) begin // @[EXU.scala 31:24]
      regfile_0 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h0 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_0 <= alu_out;
        end else begin
          regfile_0 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_0 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_0 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_1 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h1 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_1 <= alu_out;
        end else begin
          regfile_1 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_1 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_1 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_2 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h2 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_2 <= alu_out;
        end else begin
          regfile_2 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_2 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_2 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_3 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h3 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_3 <= alu_out;
        end else begin
          regfile_3 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_3 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_3 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_4 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h4 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_4 <= alu_out;
        end else begin
          regfile_4 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_4 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_4 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_5 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h5 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_5 <= alu_out;
        end else begin
          regfile_5 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_5 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_5 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_6 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h6 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_6 <= alu_out;
        end else begin
          regfile_6 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_6 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_6 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_7 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h7 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_7 <= alu_out;
        end else begin
          regfile_7 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_7 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_7 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_8 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h8 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_8 <= alu_out;
        end else begin
          regfile_8 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_8 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_8 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_9 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h9 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_9 <= alu_out;
        end else begin
          regfile_9 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_9 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_9 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_10 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'ha == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_10 <= alu_out;
        end else begin
          regfile_10 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_10 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_10 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_11 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'hb == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_11 <= alu_out;
        end else begin
          regfile_11 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_11 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_11 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_12 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'hc == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_12 <= alu_out;
        end else begin
          regfile_12 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_12 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_12 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_13 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'hd == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_13 <= alu_out;
        end else begin
          regfile_13 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_13 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_13 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_14 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'he == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_14 <= alu_out;
        end else begin
          regfile_14 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_14 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_14 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_15 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'hf == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_15 <= alu_out;
        end else begin
          regfile_15 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_15 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_15 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_16 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h10 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_16 <= alu_out;
        end else begin
          regfile_16 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_16 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_16 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_17 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h11 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_17 <= alu_out;
        end else begin
          regfile_17 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_17 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_17 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_18 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h12 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_18 <= alu_out;
        end else begin
          regfile_18 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_18 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_18 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_19 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h13 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_19 <= alu_out;
        end else begin
          regfile_19 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_19 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_19 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_20 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h14 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_20 <= alu_out;
        end else begin
          regfile_20 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_20 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_20 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_21 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h15 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_21 <= alu_out;
        end else begin
          regfile_21 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_21 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_21 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_22 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h16 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_22 <= alu_out;
        end else begin
          regfile_22 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_22 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_22 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_23 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h17 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_23 <= alu_out;
        end else begin
          regfile_23 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_23 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_23 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_24 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h18 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_24 <= alu_out;
        end else begin
          regfile_24 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_24 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_24 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_25 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h19 == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_25 <= alu_out;
        end else begin
          regfile_25 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_25 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_25 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_26 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h1a == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_26 <= alu_out;
        end else begin
          regfile_26 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_26 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_26 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_27 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h1b == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_27 <= alu_out;
        end else begin
          regfile_27 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_27 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_27 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_28 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h1c == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_28 <= alu_out;
        end else begin
          regfile_28 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_28 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_28 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_29 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h1d == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_29 <= alu_out;
        end else begin
          regfile_29 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_29 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_29 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_30 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h1e == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_30 <= alu_out;
        end else begin
          regfile_30 <= _wb_data_T_4;
        end
      end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:26]
        regfile_30 <= regfile_31; // @[EXU.scala 32:26]
      end else begin
        regfile_30 <= _GEN_30;
      end
    end
    if (reset) begin // @[EXU.scala 31:24]
      regfile_31 <= 64'h0; // @[EXU.scala 31:24]
    end else if (5'h1f == rd_addr) begin // @[EXU.scala 32:20]
      if (rd_addr != 5'h0 & io_idu_to_exu_reg_wen) begin // @[EXU.scala 32:26]
        if (_wb_data_T) begin // @[Mux.scala 101:16]
          regfile_31 <= alu_out;
        end else begin
          regfile_31 <= _wb_data_T_4;
        end
      end else if (!(5'h1f == rd_addr)) begin // @[EXU.scala 32:26]
        regfile_31 <= _GEN_30;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  regfile_0 = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  regfile_1 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  regfile_2 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  regfile_3 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  regfile_4 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  regfile_5 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  regfile_6 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  regfile_7 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  regfile_8 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  regfile_9 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  regfile_10 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  regfile_11 = _RAND_11[63:0];
  _RAND_12 = {2{`RANDOM}};
  regfile_12 = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  regfile_13 = _RAND_13[63:0];
  _RAND_14 = {2{`RANDOM}};
  regfile_14 = _RAND_14[63:0];
  _RAND_15 = {2{`RANDOM}};
  regfile_15 = _RAND_15[63:0];
  _RAND_16 = {2{`RANDOM}};
  regfile_16 = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  regfile_17 = _RAND_17[63:0];
  _RAND_18 = {2{`RANDOM}};
  regfile_18 = _RAND_18[63:0];
  _RAND_19 = {2{`RANDOM}};
  regfile_19 = _RAND_19[63:0];
  _RAND_20 = {2{`RANDOM}};
  regfile_20 = _RAND_20[63:0];
  _RAND_21 = {2{`RANDOM}};
  regfile_21 = _RAND_21[63:0];
  _RAND_22 = {2{`RANDOM}};
  regfile_22 = _RAND_22[63:0];
  _RAND_23 = {2{`RANDOM}};
  regfile_23 = _RAND_23[63:0];
  _RAND_24 = {2{`RANDOM}};
  regfile_24 = _RAND_24[63:0];
  _RAND_25 = {2{`RANDOM}};
  regfile_25 = _RAND_25[63:0];
  _RAND_26 = {2{`RANDOM}};
  regfile_26 = _RAND_26[63:0];
  _RAND_27 = {2{`RANDOM}};
  regfile_27 = _RAND_27[63:0];
  _RAND_28 = {2{`RANDOM}};
  regfile_28 = _RAND_28[63:0];
  _RAND_29 = {2{`RANDOM}};
  regfile_29 = _RAND_29[63:0];
  _RAND_30 = {2{`RANDOM}};
  regfile_30 = _RAND_30[63:0];
  _RAND_31 = {2{`RANDOM}};
  regfile_31 = _RAND_31[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

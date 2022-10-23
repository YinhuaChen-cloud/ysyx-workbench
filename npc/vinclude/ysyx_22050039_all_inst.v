`ifndef ysyx_22050039_ALL_INST_V
`define ysyx_22050039_ALL_INST_V

`define ysyx_22050039_FUNC_LEN 3

enum bit[`ysyx_22050039_FUNC_LEN-1:0] {Addi = 0, Jalr, Auipc, Lui, Sd, Jal, Ebreak, Invalid} allinst;

enum bit[5:0] {Rtype = 6'b100000, Itype = 6'b010000, Stype = 6'b001000, Btype = 6'b000100, Utype = 6'b000010, Jtype = 6'b000001, Eb_Inv = 6'b0} all_inst_types;

`endif 

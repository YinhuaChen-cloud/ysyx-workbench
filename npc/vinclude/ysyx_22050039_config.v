`ifndef ysyx_22050039_CONFIG_V
`define ysyx_22050039_CONFIG_V

`define ysyx_22050039_XLEN 64
`define ysyx_22050039_SEXT(xlen, imm, immlen) \
	{{xlen-immlen{{imm}[immlen-1]}}, {imm}}

`define ysyx_22050039_UEXT(xlen, imm, immlen) \
	{{xlen-immlen{1'b0}}, {imm}}

`endif

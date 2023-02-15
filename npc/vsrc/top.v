module top(
  input   clock,
  input   reset
);
  wire  ifu_clock; // @[top.scala 13:19]
  wire  ifu_reset; // @[top.scala 13:19]
  wire [63:0] ifu_io_pc_next; // @[top.scala 13:19]
  wire [63:0] ifu_io_pc; // @[top.scala 13:19]
  wire [31:0] idu_io_inst; // @[top.scala 15:19]
  wire  idu_io_idu_to_exu_br_eq; // @[top.scala 15:19]
  wire  idu_io_idu_to_exu_br_lt; // @[top.scala 15:19]
  wire  idu_io_idu_to_exu_br_ltu; // @[top.scala 15:19]
  wire [3:0] idu_io_idu_to_exu_pc_sel; // @[top.scala 15:19]
  wire [1:0] idu_io_idu_to_exu_op1_sel; // @[top.scala 15:19]
  wire [2:0] idu_io_idu_to_exu_op2_sel; // @[top.scala 15:19]
  wire [3:0] idu_io_idu_to_exu_alu_op; // @[top.scala 15:19]
  wire [1:0] idu_io_idu_to_exu_wb_sel; // @[top.scala 15:19]
  wire  idu_io_idu_to_exu_reg_wen; // @[top.scala 15:19]
  wire [2:0] idu_io_idu_to_exu_mem_msk_type; // @[top.scala 15:19]
  wire  idu_io_idu_to_exu_alu_msk_type; // @[top.scala 15:19]
  wire  idu_io_isEbreak; // @[top.scala 15:19]
  wire  idu_io_inv_inst; // @[top.scala 15:19]
  wire  idu_io_isWriteMem; // @[top.scala 15:19]
  wire  exu_clock; // @[top.scala 17:19]
  wire  exu_reset; // @[top.scala 17:19]
  wire [31:0] exu_io_inst; // @[top.scala 17:19]
  wire  exu_io_idu_to_exu_br_eq; // @[top.scala 17:19]
  wire  exu_io_idu_to_exu_br_lt; // @[top.scala 17:19]
  wire  exu_io_idu_to_exu_br_ltu; // @[top.scala 17:19]
  wire [3:0] exu_io_idu_to_exu_pc_sel; // @[top.scala 17:19]
  wire [1:0] exu_io_idu_to_exu_op1_sel; // @[top.scala 17:19]
  wire [2:0] exu_io_idu_to_exu_op2_sel; // @[top.scala 17:19]
  wire [3:0] exu_io_idu_to_exu_alu_op; // @[top.scala 17:19]
  wire [1:0] exu_io_idu_to_exu_wb_sel; // @[top.scala 17:19]
  wire  exu_io_idu_to_exu_reg_wen; // @[top.scala 17:19]
  wire [2:0] exu_io_idu_to_exu_mem_msk_type; // @[top.scala 17:19]
  wire  exu_io_idu_to_exu_alu_msk_type; // @[top.scala 17:19]
  wire [63:0] exu_io_ifu_to_exu_pc_next; // @[top.scala 17:19]
  wire [63:0] exu_io_ifu_to_exu_pc; // @[top.scala 17:19]
  wire [63:0] exu_io_mem_in; // @[top.scala 17:19]
  wire [2047:0] exu_io_regfile_output; // @[top.scala 17:19]
  wire [63:0] exu_io_mem_addr; // @[top.scala 17:19]
  wire [63:0] exu_io_mem_write_data; // @[top.scala 17:19]
  wire  exu_io_isRead; // @[top.scala 17:19]
  wire [7:0] exu_io_mem_write_msk; // @[top.scala 17:19]
  wire  dpic_io_clk; // @[top.scala 19:20]
  wire  dpic_io_rst; // @[top.scala 19:20]
  wire [63:0] dpic_io_pc; // @[top.scala 19:20]
  wire  dpic_io_isEbreak; // @[top.scala 19:20]
  wire  dpic_io_inv_inst; // @[top.scala 19:20]
  wire [2047:0] dpic_io_regfile; // @[top.scala 19:20]
  wire [63:0] dpic_io_mem_addr; // @[top.scala 19:20]
  wire  dpic_io_isRead; // @[top.scala 19:20]
  wire  dpic_io_isWriteMem; // @[top.scala 19:20]
  wire [63:0] dpic_io_mem_write_data; // @[top.scala 19:20]
  wire [7:0] dpic_io_mem_write_msk; // @[top.scala 19:20]
  wire [31:0] dpic_io_inst; // @[top.scala 19:20]
  wire [63:0] dpic_io_mem_in; // @[top.scala 19:20]
  IFU ifu ( // @[top.scala 13:19]
    .clock(ifu_clock),
    .reset(ifu_reset),
    .io_pc_next(ifu_io_pc_next),
    .io_pc(ifu_io_pc)
  );
  IDU idu ( // @[top.scala 15:19]
    .io_inst(idu_io_inst),
    .io_idu_to_exu_br_eq(idu_io_idu_to_exu_br_eq),
    .io_idu_to_exu_br_lt(idu_io_idu_to_exu_br_lt),
    .io_idu_to_exu_br_ltu(idu_io_idu_to_exu_br_ltu),
    .io_idu_to_exu_pc_sel(idu_io_idu_to_exu_pc_sel),
    .io_idu_to_exu_op1_sel(idu_io_idu_to_exu_op1_sel),
    .io_idu_to_exu_op2_sel(idu_io_idu_to_exu_op2_sel),
    .io_idu_to_exu_alu_op(idu_io_idu_to_exu_alu_op),
    .io_idu_to_exu_wb_sel(idu_io_idu_to_exu_wb_sel),
    .io_idu_to_exu_reg_wen(idu_io_idu_to_exu_reg_wen),
    .io_idu_to_exu_mem_msk_type(idu_io_idu_to_exu_mem_msk_type),
    .io_idu_to_exu_alu_msk_type(idu_io_idu_to_exu_alu_msk_type),
    .io_isEbreak(idu_io_isEbreak),
    .io_inv_inst(idu_io_inv_inst),
    .io_isWriteMem(idu_io_isWriteMem)
  );
  EXU exu ( // @[top.scala 17:19]
    .clock(exu_clock),
    .reset(exu_reset),
    .io_inst(exu_io_inst),
    .io_idu_to_exu_br_eq(exu_io_idu_to_exu_br_eq),
    .io_idu_to_exu_br_lt(exu_io_idu_to_exu_br_lt),
    .io_idu_to_exu_br_ltu(exu_io_idu_to_exu_br_ltu),
    .io_idu_to_exu_pc_sel(exu_io_idu_to_exu_pc_sel),
    .io_idu_to_exu_op1_sel(exu_io_idu_to_exu_op1_sel),
    .io_idu_to_exu_op2_sel(exu_io_idu_to_exu_op2_sel),
    .io_idu_to_exu_alu_op(exu_io_idu_to_exu_alu_op),
    .io_idu_to_exu_wb_sel(exu_io_idu_to_exu_wb_sel),
    .io_idu_to_exu_reg_wen(exu_io_idu_to_exu_reg_wen),
    .io_idu_to_exu_mem_msk_type(exu_io_idu_to_exu_mem_msk_type),
    .io_idu_to_exu_alu_msk_type(exu_io_idu_to_exu_alu_msk_type),
    .io_ifu_to_exu_pc_next(exu_io_ifu_to_exu_pc_next),
    .io_ifu_to_exu_pc(exu_io_ifu_to_exu_pc),
    .io_mem_in(exu_io_mem_in),
    .io_regfile_output(exu_io_regfile_output),
    .io_mem_addr(exu_io_mem_addr),
    .io_mem_write_data(exu_io_mem_write_data),
    .io_isRead(exu_io_isRead),
    .io_mem_write_msk(exu_io_mem_write_msk)
  );
  DPIC #(.XLEN(64), .NR_REG(32), .PC_LEN(64), .INST_LEN(32)) dpic ( // @[top.scala 19:20]
    .io_clk(dpic_io_clk),
    .io_rst(dpic_io_rst),
    .io_pc(dpic_io_pc),
    .io_isEbreak(dpic_io_isEbreak),
    .io_inv_inst(dpic_io_inv_inst),
    .io_regfile(dpic_io_regfile),
    .io_mem_addr(dpic_io_mem_addr),
    .io_isRead(dpic_io_isRead),
    .io_isWriteMem(dpic_io_isWriteMem),
    .io_mem_write_data(dpic_io_mem_write_data),
    .io_mem_write_msk(dpic_io_mem_write_msk),
    .io_inst(dpic_io_inst),
    .io_mem_in(dpic_io_mem_in)
  );
  assign ifu_clock = clock;
  assign ifu_reset = reset;
  assign ifu_io_pc_next = exu_io_ifu_to_exu_pc_next; // @[top.scala 21:10]
  assign idu_io_inst = dpic_io_inst; // @[top.scala 25:18]
  assign idu_io_idu_to_exu_br_eq = exu_io_idu_to_exu_br_eq; // @[top.scala 28:21]
  assign idu_io_idu_to_exu_br_lt = exu_io_idu_to_exu_br_lt; // @[top.scala 28:21]
  assign idu_io_idu_to_exu_br_ltu = exu_io_idu_to_exu_br_ltu; // @[top.scala 28:21]
  assign exu_clock = clock;
  assign exu_reset = reset;
  assign exu_io_inst = dpic_io_inst; // @[top.scala 26:18]
  assign exu_io_idu_to_exu_pc_sel = idu_io_idu_to_exu_pc_sel; // @[top.scala 28:21]
  assign exu_io_idu_to_exu_op1_sel = idu_io_idu_to_exu_op1_sel; // @[top.scala 28:21]
  assign exu_io_idu_to_exu_op2_sel = idu_io_idu_to_exu_op2_sel; // @[top.scala 28:21]
  assign exu_io_idu_to_exu_alu_op = idu_io_idu_to_exu_alu_op; // @[top.scala 28:21]
  assign exu_io_idu_to_exu_wb_sel = idu_io_idu_to_exu_wb_sel; // @[top.scala 28:21]
  assign exu_io_idu_to_exu_reg_wen = idu_io_idu_to_exu_reg_wen; // @[top.scala 28:21]
  assign exu_io_idu_to_exu_mem_msk_type = idu_io_idu_to_exu_mem_msk_type; // @[top.scala 28:21]
  assign exu_io_idu_to_exu_alu_msk_type = idu_io_idu_to_exu_alu_msk_type; // @[top.scala 28:21]
  assign exu_io_ifu_to_exu_pc = ifu_io_pc; // @[top.scala 21:10]
  assign exu_io_mem_in = dpic_io_mem_in; // @[top.scala 42:19]
  assign dpic_io_clk = clock; // @[top.scala 30:15]
  assign dpic_io_rst = reset; // @[top.scala 31:15]
  assign dpic_io_pc = ifu_io_pc; // @[top.scala 32:15]
  assign dpic_io_isEbreak = idu_io_isEbreak; // @[top.scala 33:20]
  assign dpic_io_inv_inst = idu_io_inv_inst; // @[top.scala 34:20]
  assign dpic_io_regfile = exu_io_regfile_output; // @[top.scala 35:20]
  assign dpic_io_mem_addr = exu_io_mem_addr; // @[top.scala 36:20]
  assign dpic_io_isRead = exu_io_isRead; // @[top.scala 37:20]
  assign dpic_io_isWriteMem = idu_io_isWriteMem; // @[top.scala 38:22]
  assign dpic_io_mem_write_data = exu_io_mem_write_data; // @[top.scala 39:26]
  assign dpic_io_mem_write_msk = exu_io_mem_write_msk; // @[top.scala 40:26]
endmodule

// package utils
// 
// import chisel3._
// import chisel3.util._
// import cyhcore.HasCyhCoreParameter
// 
// class DPIC extends BlackBox with HasBlackBoxInline with HasCyhCoreParameter {
//   val io = IO(new Bundle {
//     val clk = Input(Clock())
//     val rst = Input(Bool())
//     val isEbreak = Input(Bool())
//     val inv_inst  = Input(Bool())
//   })
// 
//   setInline("DPIC.v",
//             s"""
//               |module DPIC (
//               |           input clk,
//               |           input rst,
//               |           input isEbreak,
//               |           input inv_inst,
//               |           input [${NR_GPRS} * ${XLEN} - 1:0] regfile);
//               |
//               |  // only cpp simulation environment can execute ebreak()
//               |  import "DPI-C" function void ebreak();
//               |  always@(*) begin
//               |    if(isEbreak)
//               |      ebreak();   
//               |  end
//               |
//               |  // used to report invalid inst error
//               |  import "DPI-C" function void invalid();
//               |    always@(posedge clk)
//               |      if (~rst && inv_inst)
//               |        invalid();
//               |
//               |endmodule
//             """.stripMargin)
// 
// }
// 
//     val regfile = Input(UInt((NR_GPRS * XLEN).W))
//               这段代码已经迁移到了 Difftest.scala 中
//               |  // expose regfile for difftest
//               |  import "DPI-C" function void set_gpr_ptr(input logic [${XLEN}-1:0] a []);
//               |  wire [${XLEN}-1:0] regs [${NR_GPRS}-1:0];
//               |  genvar i;
//               |  generate
//               |    for(i = 0; i < ${NR_GPRS}; i = i+1) begin
//               |      assign regs[i] = regfile[(i+1)*${XLEN} - 1 : i*${XLEN}]; 
//               |    end
//               |  endgenerate
//               |  initial set_gpr_ptr(regs);
//               |

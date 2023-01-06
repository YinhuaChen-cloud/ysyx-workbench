// Generated by CIRCT unknown git version
// Standard header to adapt well known macros to our needs.
`ifdef RANDOMIZE_REG_INIT
  `define RANDOMIZE
`endif // RANDOMIZE_REG_INIT

// RANDOM may be set to an expression that produces a 32-bit random unsigned value.
`ifndef RANDOM
  `define RANDOM $random
`endif // not def RANDOM

// Users can define INIT_RANDOM as general code that gets injected into the
// initializer block for modules with registers.
`ifndef INIT_RANDOM
  `define INIT_RANDOM
`endif // not def INIT_RANDOM

// If using random initialization, you can also define RANDOMIZE_DELAY to
// customize the delay used, otherwise 0.002 is used.
`ifndef RANDOMIZE_DELAY
  `define RANDOMIZE_DELAY 0.002
`endif // not def RANDOMIZE_DELAY

// Define INIT_RANDOM_PROLOG_ for use in our modules below.
`ifdef RANDOMIZE
  `ifdef VERILATOR
    `define INIT_RANDOM_PROLOG_ `INIT_RANDOM
  `else  // VERILATOR
    `define INIT_RANDOM_PROLOG_ `INIT_RANDOM #`RANDOMIZE_DELAY begin end
  `endif // VERILATOR
`else  // RANDOMIZE
  `define INIT_RANDOM_PROLOG_
`endif // RANDOMIZE

module IFU(	// <stdin>:2:10
  input         clock,
                reset,
  output [31:0] io_pc);

  reg [31:0] pc_reg;	// IFU.scala:30:23
  always @(posedge clock) begin
    if (reset)
      pc_reg <= 32'h80000000;	// IFU.scala:30:23
    else
      pc_reg <= pc_reg + 32'h4;	// IFU.scala:30:23, :31:48
  end // always @(posedge)
  `ifndef SYNTHESIS	// <stdin>:2:10
    `ifdef FIRRTL_BEFORE_INITIAL	// <stdin>:2:10
      `FIRRTL_BEFORE_INITIAL	// <stdin>:2:10
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin	// <stdin>:2:10
      automatic logic [31:0] _RANDOM_0;	// <stdin>:2:10
      `ifdef INIT_RANDOM_PROLOG_	// <stdin>:2:10
        `INIT_RANDOM_PROLOG_	// <stdin>:2:10
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// <stdin>:2:10
        _RANDOM_0 = `RANDOM;	// <stdin>:2:10
        pc_reg = _RANDOM_0;	// IFU.scala:30:23
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// <stdin>:2:10
      `FIRRTL_AFTER_INITIAL	// <stdin>:2:10
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  assign io_pc = pc_reg;	// <stdin>:2:10, IFU.scala:30:23
endmodule

module top(	// <stdin>:15:10
  input  clock,
         reset,
  output io_led);

  wire [31:0] _ifu_io_pc;	// top.scala:11:19
  IFU ifu (	// top.scala:11:19
    .clock (clock),
    .reset (reset),
    .io_pc (_ifu_io_pc)
  );
  assign io_led = _ifu_io_pc[1];	// <stdin>:15:10, top.scala:11:19, :14:22
endmodule


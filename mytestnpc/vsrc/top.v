//module MuxKey #(NR_KEY = 2, KEY_LEN = 1, DATA_LEN = 1) (
//  output [DATA_LEN-1:0] out, // out is 1 bit
//  input [KEY_LEN-1:0] key, // key is 1 bit
//  input [NR_KEY*(KEY_LEN + DATA_LEN)-1:0] lut // lut is 4 bit
//);
//  MuxKeyInternal #(NR_KEY, KEY_LEN, DATA_LEN, 0) i0 (out, key, {DATA_LEN{1'b0}}, lut);
//endmodule

module top(
	output [1:0] Y,
	input [1:0] F,
	input [1:0] X0,
	input [1:0] X1,
	input [1:0] X2,
	input [1:0] X3
);

	wire [15:0] lut;
	wire [7:0] X;

	assign X = {X3, X2, X1, X0};

  generate
    for (genvar n = 0; n < 4; n = n + 1) begin
			assign lut[n*4+3:n*4] = {n[1:0], X[n*2+1:n*2]};
    end
  endgenerate

  MuxKey #(4, 2, 2) i0 (Y, F, lut);

endmodule
//NR_KEY: number of choices
//KEY_LEN: bit len of sel
//DATA_LEN: bit len of out
//HAS_DEFAULT: whether define default output
// parameter : 2 1 1 0
module MuxKeyInternal #(NR_KEY = 2, KEY_LEN = 1, DATA_LEN = 1, HAS_DEFAULT = 0) (
  output reg [DATA_LEN-1:0] out, // 1 bit
  input [KEY_LEN-1:0] key, // 1 bit
  input [DATA_LEN-1:0] default_out, // 1 bit
  input [NR_KEY*(KEY_LEN + DATA_LEN)-1:0] lut // 4 bit
);

  localparam PAIR_LEN = KEY_LEN + DATA_LEN; // 2 bit
  wire [PAIR_LEN-1:0] pair_list [NR_KEY-1:0];
  wire [KEY_LEN-1:0] key_list [NR_KEY-1:0];
  wire [DATA_LEN-1:0] data_list [NR_KEY-1:0];

  generate
    for (genvar n = 0; n < NR_KEY; n = n + 1) begin
      assign pair_list[n] = lut[PAIR_LEN*(n+1)-1 : PAIR_LEN*n];
      assign data_list[n] = pair_list[n][DATA_LEN-1:0];
      assign key_list[n]  = pair_list[n][PAIR_LEN-1:DATA_LEN];
    end
  endgenerate

  reg [DATA_LEN-1 : 0] lut_out;
  reg hit;
  integer i;
  always @(*) begin
    lut_out = 0;
    hit = 0;
    for (i = 0; i < NR_KEY; i = i + 1) begin
      lut_out = lut_out | ({DATA_LEN{key == key_list[i]}} & data_list[i]);
      hit = hit | (key == key_list[i]);
    end
    if (!HAS_DEFAULT) out = lut_out;
    else out = (hit ? lut_out : default_out);
  end

endmodule

//NR_KEY: number of choices
//KEY_LEN: bit len of sel
//DATA_LEN: bit len of out
//lut: (key, val) pairs table
module MuxKey #(NR_KEY = 2, KEY_LEN = 1, DATA_LEN = 1) (
  output [DATA_LEN-1:0] out, // out is 1 bit
  input [KEY_LEN-1:0] key, // key is 1 bit
  input [NR_KEY*(KEY_LEN + DATA_LEN)-1:0] lut // lut is 4 bit
);
  MuxKeyInternal #(NR_KEY, KEY_LEN, DATA_LEN, 0) i0 (out, key, {DATA_LEN{1'b0}}, lut);
endmodule

module MuxKeyWithDefault #(NR_KEY = 2, KEY_LEN = 1, DATA_LEN = 1) (
  output [DATA_LEN-1:0] out,
  input [KEY_LEN-1:0] key,
  input [DATA_LEN-1:0] default_out,
  input [NR_KEY*(KEY_LEN + DATA_LEN)-1:0] lut
);
  MuxKeyInternal #(NR_KEY, KEY_LEN, DATA_LEN, 1) i0 (out, key, default_out, lut);
endmodule

module top (clk, we, inaddr, outaddr, din, seg0, seg1, seg3, seg4, seg6, seg7);
  input clk;
  input we;
  input [2:0] inaddr;
  input [2:0] outaddr;
  input [7:0] din;
	output [7:0] seg0, seg1, seg3, seg4, seg6, seg7;

  reg [7:0] dout0,dout1,dout2;

  reg [7:0] ram [7:0];

  initial
  begin
  ram[7] = 8'hf0; ram[6] = 8'h23; ram[5] = 8'h20; ram[4] = 8'h50;
  ram[3] = 8'h03; ram[2] = 8'h21; ram[1] = 8'h82; ram[0] = 8'h0D;
  end

  always @(posedge clk)
  begin
      if (we)
          ram[inaddr] <= din;
      else
          dout0 <= ram[outaddr];
  end
  always @(negedge clk)
  begin
      if (!we)
          dout1 <= ram[outaddr];
  end
  assign  dout2 = ram[outaddr];
	
	reg [7:0] segs [15:0];
	assign segs[0] = 8'b11111100;
	assign segs[1] = 8'b01100000;
	assign segs[2] = 8'b11011010;
	assign segs[3] = 8'b11110010;
	assign segs[4] = 8'b01100110;
	assign segs[5] = 8'b10110110;
	assign segs[6] = 8'b10111110;
	assign segs[7] = 8'b11100000;
	assign segs[8] = 8'b11111110;
	assign segs[9] = 8'b11110110;
	assign segs[10] = 8'b11101110;
	assign segs[11] = 8'b11111111;
	assign segs[12] = 8'b10011100;
	assign segs[13] = 8'b11111101;
	assign segs[14] = 8'b10011110;
	assign segs[15] = 8'b10001110;

	assign seg0 = ~segs[dout0[3:0]];
	assign seg1 = ~segs[dout0[7:4]];
	assign seg3 = ~segs[dout1[3:0]];
	assign seg4 = ~segs[dout1[7:4]];
	assign seg6 = ~segs[dout2[3:0]];
	assign seg7 = ~segs[dout2[7:4]];

endmodule

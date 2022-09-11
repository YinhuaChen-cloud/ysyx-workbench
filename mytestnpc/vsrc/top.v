module top (clk, we, inaddr, outaddr, din, seg0, seg1);
  input clk;
  input we;
  input [2:0] inaddr;
  input [2:0] outaddr;
  input [7:0] din;
	output [7:0] seg0, seg1;

  reg [7:0] dout;

  reg [7:0] registers [15:0];

  initial
  begin
		$readmemh("./mem1.txt", registers, 0, 15);
  end

  always @(posedge clk)
      if (we)
          registers[{1'b0, inaddr}] <= din;

  assign  dout = registers[{1'b0, outaddr}];
	
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

	assign seg0 = ~segs[dout[3:0]];
	assign seg1 = ~segs[dout[7:4]];

endmodule

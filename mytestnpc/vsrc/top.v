module top(
	input clk,
	input rst,
	output VGA_VSYNC,
	output VGA_HSYNC,
	output VGA_BLANK_N,
	output [7:0] VGA_R,
	output [7:0] VGA_G,
	output [7:0] VGA_B
);
//	1. a storage storing dot matrix of all ascii char
//	2. a vmem 30 * 70
//	3. a keyboard writing to vmem
//	4. a vga control which keep scanning vmem
//	note : the screen is 640 * 480

//	The way access dotmatrix:
//		1. get a 8-bit ascii data "asciidata" from vmem
//		2. dotmatrix[16*asciidata] - dotmatrix[16*asciidata + 15] is the dot matrix
//	To eliminate "*":
//		16 = 2^4
//		dotmatrix[{asciidata, 4'h0}] - dotmatrix[{asciidata, 4'hF}]
		
	reg [11:0] dotmatrix [4095:0];
	reg [7:0]	vmem [2239: 0]; // col-priority 32*70 = 2240
	initial begin
		$readmemh("resource/vga_font.txt", dotmatrix);
		vmem[0] = 8'd66;
	end

//	The vga control:
//	row = (v_addr/16) col = (h_addr/9)
/* verilator lint_off WIDTH */
	wire [4:0] row;
	reg [6:0] col;
	reg [3:0] col_remainder;
	assign row = v_addr[8:4];
	integer i;
	integer j;
	always@(*) begin
		col = 0;
		col_remainder = 0;
		for(i = 0; i < 70; i = i+1) begin
			if(i*9 <= h_addr && h_addr < i*9 + 9)
				col = i;
			for(j = 0; j < 9; j = j+1)
				if(i*70 + j == h_addr)
					col_remainder = j;
		end
	end

//	asciidata = vmem(col, row)
//	font = dotmatrix(asciidata*16) - *16+15 0:15
//	vga_data = font(v_addr%16)(h_addr%9) ? 0xFFFFFF : 0x000000;
//	To be synthesizable:
//		wire [11:0] font [15:0];
//		assign font = dotmatrix[v_addr[:4]];
	wire [7:0] asciidata;	
	assign asciidata = vmem[{col, row}];

	wire [11:0] font [15:0];
	assign font[0] = dotmatrix[{asciidata, 4'h0}];
	assign font[1] = dotmatrix[{asciidata, 4'h1}];
	assign font[2] = dotmatrix[{asciidata, 4'h2}];
	assign font[3] = dotmatrix[{asciidata, 4'h3}];
	assign font[4] = dotmatrix[{asciidata, 4'h4}];
	assign font[5] = dotmatrix[{asciidata, 4'h5}];
	assign font[6] = dotmatrix[{asciidata, 4'h6}];
	assign font[7] = dotmatrix[{asciidata, 4'h7}];
	assign font[8] = dotmatrix[{asciidata, 4'h8}];
	assign font[9] = dotmatrix[{asciidata, 4'h9}];
	assign font[10] = dotmatrix[{asciidata, 4'ha}];
	assign font[11] = dotmatrix[{asciidata, 4'hb}];
	assign font[12] = dotmatrix[{asciidata, 4'hc}];
	assign font[13] = dotmatrix[{asciidata, 4'hd}];
	assign font[14] = dotmatrix[{asciidata, 4'he}];
	assign font[15] = dotmatrix[{asciidata, 4'hf}];

	always@(*) begin
		$display("col_remainder");
		vga_data = font[v_addr[3:0]][col_remainder] ? 12'hfff : 12'h0;
	end
		
	wire [9:0]    h_addr;   
	wire [9:0]    v_addr;
	reg [23:0] vga_data; // the pixel info of 1 dot
	vga_ctrl my_vga_ctrl(
    .pclk(clk),     
    .reset(rst),  
    .vga_data(vga_data),  // we need to dealt with
    .h_addr(h_addr),   // with help of this
    .v_addr(v_addr),  // with help of this
    .hsync(VGA_HSYNC),    
    .vsync(VGA_VSYNC),
    .valid(VGA_BLANK_N),    
    .vga_r(VGA_R),    
    .vga_g(VGA_G),
    .vga_b(VGA_B)
	);

endmodule

module top(
	input clk,
	input rst,
	input ps2_clk,
	input ps2_data,
	output VGA_VSYNC,
	output VGA_HSYNC,
	output VGA_BLANK_N,
	output [7:0] VGA_R,
	output [7:0] VGA_G,
	output [7:0] VGA_B,
	output overflow
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
		vmem[1] = 8'd65;
	end

	// part3: keyboard writing to vmem
	reg nextdata;
	wire ready;	
	wire [7:0] data;
	reg [6:0] x, y; // the coordinate of cusor
	reg skip; // used when meets F0
	// x: 0 - 69  y: 0-29
	always@(posedge clk)
		if(rst) begin
			nextdata <= 0;
			x <= 0;
			y <= 0;
		end
		else begin
			if(ready) begin
				// 1. convert SCANCODE to ASCII
				
				// 2. writing to vmem
				vmem[]	
			end
		end
	// ps2_keyboard
	ps2_keyboard mykbd(
    .clk(clk),
		.rst(rst),
		.ps2_clk(ps2_clk),
		.ps2_data(ps2_data),
		.nextdata(nextdata),
		.ready(ready),
		.overflow(overflow),
		.data(data)
	);	

//	The vga control:
//	row = (v_addr/16) col = (h_addr/9)
/* verilator lint_off WIDTH */
	wire [4:0] row;
	reg [6:0] col;
	reg [3:0] col_remainder;
	assign row = v_addr[8:4];
	integer i;
	integer j;
	// TODO: after wake up, remember to ask problems about this
	always@(*) begin
		col = 0;
		col_remainder = 0;
		for(i = 0; i < 70; i = i+1) begin
			if(i*9 <= h_addr && h_addr < i*9 + 9)
				col = i;
			for(j = 0; j < 9; j = j+1)
				if(i*9 + j == h_addr)
					col_remainder = j;
		end
	end

	wire [7:0] asciidata;	
	assign asciidata = vmem[{col, row}];

	wire [11:0] font [15:0];
	// TODO: after wake up, remember to ask problems about this
	// ANSWER: we can use generate syntax to generate the following
	genvar k;	
	generate  
		for(k = 0; k < 16; k = k+1) begin
			assign font[k] = dotmatrix[{asciidata, k[3:0]}];
		end
	endgenerate

	always@(*) begin
		$display("col_remainder");
		vga_data = font[v_addr[3:0]][col_remainder] ? 24'hffffff : 12'h0;
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

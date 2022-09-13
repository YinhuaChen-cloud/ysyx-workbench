module vga(
	input clk,
	input rst,
	output VGA_VSYNC,
	output VGA_HSYNC,
	output VGA_BLANK_N,
	output [7:0] VGA_R,
	output [7:0] VGA_G,
	output [7:0] VGA_B
);

	wire [9:0] h_addr, v_addr;
	wire [23:0] vga_data;
	// 1. initialization of mem to store image
	reg [23:0] vmem [307200:0];
	initial begin
		$readmemh("resource/inputHex.txt", vmem);
	end
	 
	// 2. generate VGA_CLK
	// seems no need for this yet
	 
	// 3. VGA_CTRL
	assign vga_data = vmem[v_addr*640 + h_addr];
//	assign vga_data = vmem[{v_addr[8:0], h_addr}];
	vga_ctrl my_vga_ctrl(
    .pclk(clk),     
    .reset(rst),    
    .vga_data(vga_data), 
    .h_addr(h_addr),   
    .v_addr(v_addr),
    .hsync(VGA_HSYNC),    
    .vsync(VGA_VSYNC),
    .valid(VGA_BLANK_N),    
    .vga_r(VGA_R),    
    .vga_g(VGA_G),
    .vga_b(VGA_B)
	);

endmodule


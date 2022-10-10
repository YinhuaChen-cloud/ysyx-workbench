`timescale 1ns / 1ps
module keyboard_sim;

/* parameter */
parameter [31:0] clock_period = 10;

/* ps2_keyboard interface signals */
reg clk,clrn;
wire [7:0] data;
wire ready,overflow;
//wire kbd_clk, kbd_data;
reg kbd_clk, kbd_data;
reg nextdata_n;

//ps2_keyboard_model model(
//    .ps2_clk(kbd_clk),
//    .ps2_data(kbd_data)
//);

ps2_keyboard inst(
    .clk(clk),
    .clrn(clrn),
    .ps2_clk(kbd_clk),
    .ps2_data(kbd_data),
    .data(data),
    .ready(ready),
    .nextdata_n(nextdata_n),
    .overflow(overflow)
);

initial begin /* clock driver */
    clk = 0;
    forever
        #(clock_period/2) clk = ~clk;
end

initial
 begin
    $dumpfile("cyh.vcd");
    $dumpvars(0,keyboard_sim);
 end

initial begin
    clrn = 1'b0;  #20;
    clrn = 1'b1;  #20;
		kbd_clk = 1'b1;	kbd_data = 1'b0; #30
		kbd_clk = 1'b0;	kbd_data = 1'b0; #30
		kbd_clk = 1'b1;	kbd_data = 1'b1; #30
		kbd_clk = 1'b0;	kbd_data = 1'b1; #30
		kbd_clk = 1'b1;	kbd_data = 1'b0; #30
		kbd_clk = 1'b0;	kbd_data = 1'b0; #30
		kbd_clk = 1'b1;	kbd_data = 1'b1; #30
		kbd_clk = 1'b0;	kbd_data = 1'b1; #30
		kbd_clk = 1'b1;	kbd_data = 1'b1; #30
		kbd_clk = 1'b0;	kbd_data = 1'b1; #30
		kbd_clk = 1'b1;	kbd_data = 1'b1; #30
		kbd_clk = 1'b0;	kbd_data = 1'b1; #30
		kbd_clk = 1'b1;	kbd_data = 1'b1; #30
		kbd_clk = 1'b0;	kbd_data = 1'b1; #30
		kbd_clk = 1'b1;	kbd_data = 1'b1; #30
		kbd_clk = 1'b0;	kbd_data = 1'b1; #30
		kbd_clk = 1'b1;	kbd_data = 1'b1; #30
		kbd_clk = 1'b0;	kbd_data = 1'b1; #30
		kbd_clk = 1'b1;	kbd_data = 1'b0; #30
		kbd_clk = 1'b0;	kbd_data = 1'b0; #30
		kbd_clk = 1'b1;	kbd_data = 1'b1; #30
		kbd_clk = 1'b0;	kbd_data = 1'b1; #30
    #20 nextdata_n =1'b0; #20 nextdata_n =1'b1; //read data
//    model.kbd_sendcode(8'h1C); // press 'A'
//    #20 nextdata_n =1'b0; #20 nextdata_n =1'b1;//read data
//    model.kbd_sendcode(8'hF0); // break code
//    #20 nextdata_n =1'b0; #20 nextdata_n =1'b1; //read data
//    model.kbd_sendcode(8'h1C); // release 'A'
//    #20 nextdata_n =1'b0; #20 nextdata_n =1'b1; //read data
//    model.kbd_sendcode(8'h1B); // press 'S'
//    #20 model.kbd_sendcode(8'h1B); // keep pressing 'S'
//    #20 model.kbd_sendcode(8'h1B); // keep pressing 'S'
//    model.kbd_sendcode(8'hF0); // break code
//    model.kbd_sendcode(8'h1B); // release 'S'
    #20;
    $stop;
end

endmodule

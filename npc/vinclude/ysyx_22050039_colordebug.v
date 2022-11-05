`ifndef ysyx_22050039_COLORDEBUG_V
`define ysyx_22050039_COLORDEBUG_V
/* verilator lint_off WIDTH */
//program clr_display();

`define ysyx_22050039_COLOR(message) \
	$display(message)

/*	begin \
		$write("%c[4;33m",27); \ // BROWN 
		$display(message); \
		$write("%c[0m",27); \
	end 
*/

//	initial
//begin
//	$write("%c[1;34m",27);
//	$display("*********** This is in blue ***********");
//	$write("%c[0m",27);
//
//	$write("%c[1;31m",27);
//	$display("*********** This is in red ***********");
//	$write("%c[0m",27);
//
//	$write("%c[4;33m",27);
//	$display("*********** This is in brown ***********");
//	$write("%c[0m",27);
//
//	$write("%c[5;34m",27);
//	$display("*********** This is in green ***********");
//	$write("%c[0m",27);
//
//	$write("%c[7;34m",27);
//	$display("*********** This is in Back groung colour ***********");
//	$write("%c[0m",27);
//end

`endif

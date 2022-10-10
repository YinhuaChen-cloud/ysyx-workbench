// May be you can say top == cpu
module ysyx_22050039_top #(XLEN=64) (
  input clk,
  input rst,
	output [XLEN-1:0] pc
);
endmodule

//  reg [31:0] count;
//  always @(posedge clk) begin
//    if (rst) begin led <= 1; count <= 0; end
//    else begin
//      if (count == 0) led <= {led[14:0], led[15]};
//      count <= (count >= 5000000 ? 32'b0 : count + 1);
//    end
//  end


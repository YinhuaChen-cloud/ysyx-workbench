module ps2_keyboard(
    input clk,rst,ps2_clk,ps2_data,
    output reg ready,
		output [7:0] seg0,
		output [7:0] seg1
);
    // internal signal, for test
    reg [15:0] data;
    reg [9:0] buffer;        // ps2_data bits
    reg [3:0] count;  // count ps2_data bits
    // detect falling edge of ps2_clk
    reg [2:0] ps2_clk_sync;

    always @(posedge clk) begin // check negedge of ps2_clk
        ps2_clk_sync <=  {ps2_clk_sync[1:0],ps2_clk};
    end

    wire sampling = ps2_clk_sync[2] & ~ps2_clk_sync[1];

    always @(posedge clk) begin
        if (rst) begin // rst
            count <= 0; 
						ready <= 0;
        end
        else begin
						ready <= 0; 
            if (sampling) begin
              if (count == 4'd10) begin
                if ((buffer[0] == 0) &&  // start bit
                    (ps2_data)       &&  // stop bit
                    (^buffer[9:1])) begin      // odd  parity
                    $display("receive %x", buffer[8:1]);
										data <= {data[7:0], buffer[8:1]};
										ready <= (data[7:0] == 8'hF0) ? 0 : 1;
                end
                count <= 0;     // for next
              end else begin
                buffer[count] <= ps2_data;  // store ps2_data
                count <= count + 3'b1;
              end
						end // endif sampling
        end
    end

		// show scancode part
//		1. two segs to represent scancode	(data)
//		2. ps2_clk and ps2_data connected to correct ports
//		3. a counter to count ps2_data bits(all bits sampling at negedge of ps2_clk)
//		4. 8-bit DFFs to store ps2_data bits
//		5. a comparator check whether data is 0xF0, if yes, disable all segs

	wire [7:0] segs [15:0];
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

	assign seg0 = ready ? ~segs[data[3:0]] : '1;
	assign seg1 = ready ? ~segs[data[7:4]] : '1;

	// show push times 
endmodule


module ps2_keyboard(
    input clk,rst,ps2_clk,ps2_data,nextdata,
		output reg ready,
		output reg overflow,
		output [7:0] data
);
    reg [9:0] buffer;        // ps2_data bits
    reg [3:0] count;  // count ps2_data bits
    // detect falling edge of ps2_clk
		reg [7:0] fifo [7:0];
		reg [2:0] w_ptr, r_ptr;
    reg [2:0] ps2_clk_sync;

    always @(posedge clk) begin // check negedge of ps2_clk
        ps2_clk_sync <=  {ps2_clk_sync[1:0],ps2_clk};
    end

    wire sampling = ps2_clk_sync[2] & ~ps2_clk_sync[1];

    always @(posedge clk) begin
        if (rst) begin // rst
            count <= 0; 
						w_ptr <= 0;
						r_ptr <= 0;
						ready <= 0;
						overflow <= 0;
        end
        else begin
					if(ready) begin
						if(nextdata) begin // TODO:
							r_ptr <= r_ptr + 1;
							if(r_ptr+1 == w_ptr)
								ready <= 0;
						end
					end
					// if detect correct data, push it to fifo
					if (sampling) begin
						if (count == 4'd10) begin
							if ((buffer[0] == 0) &&  // start bit
									(ps2_data)       &&  // stop bit
									(^buffer[9:1])) begin      // odd  parity
									$display("receive %x", buffer[8:1]);
									// when w_ptr == r_ptr, fifo is empty
									fifo[w_ptr] <= buffer[8:1];
									w_ptr <= w_ptr + 1;
									ready <= 1; // ready is high whenever fifo is with sth 
									overflow <= overflow | (w_ptr + 1 == r_ptr);
							end
							count <= 0;     // for next
						end else begin
							buffer[count] <= ps2_data;  // store ps2_data
							count <= count + 3'b1;
						end
					end // endif sampling
        end
    end
		
		assign data = fifo[r_ptr];

endmodule


module ps2_keyboard(
    input clk,rst,ps2_clk,ps2_data
);
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
            if (sampling) begin
              if (count == 4'd10) begin
                if ((buffer[0] == 0) &&  // start bit
                    (ps2_data)       &&  // stop bit
                    (^buffer[9:1])) begin      // odd  parity
                    $display("receive %x", buffer[8:1]);
										data <= {data[7:0], buffer[8:1]};
                    $display("(data[7:0] == 8'hF0) %b", (data[7:0] == 8'hF0));
										if(data[7:0] == 8'hF0) begin
											ready <= 0;
										end
										else
											ready <= 1;
                end
                count <= 0;     // for next
              end else begin
                buffer[count] <= ps2_data;  // store ps2_data
                count <= count + 3'b1;
              end
						end // endif sampling
        end
    end

endmodule


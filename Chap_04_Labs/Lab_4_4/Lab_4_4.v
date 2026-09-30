module serial (
    			output reg       bit_out,
    			input  wire [7:0] byte_in,
    			input  wire       clk,
    			input  wire       reset
);

reg [7:0] shift_reg;
reg [2:0] count;

always @(posedge clk or posedge reset)
begin
    if (reset)
    begin
        shift_reg <= 8'b0;
        count     <= 3'd0;
        bit_out   <= 1'b0;
    end

    else
    begin
        // Every 8th clock, load a new byte
        if (count == 3'd0)
        begin
            bit_out   <= byte_in[7];
            shift_reg <= {byte_in[6:0], 1'b0};
            count     <= count + 1;
        end

        // Send remaining bits one at a time
        else
        begin
            bit_out   <= shift_reg[7];
            shift_reg <= shift_reg << 1;

            if (count == 3'd7)
                count <= 3'd0;
            else
                count <= count + 1;
        end
    end
end

endmodule
module fifo #(parameter Width = 8, parameter Depth = 128)
(
    output reg  [Width-1:0] d_out,
    output wire full,
    output wire empty,
    input  wire [Width-1:0] d_in,
    input  wire d_in_valid,
    input  wire d_out_req,
    input  wire clk,
    input  wire reset
);

// Counters
reg [6:0] rd_ptr;
reg [6:0] wr_ptr;
reg [7:0] count;

// Memory
reg [Width-1:0] mem [0:Depth-1];

// Read and Write operations
always @(posedge clk or posedge reset)
begin

    if (reset)
    begin
        wr_ptr <= 7'd0;
        rd_ptr <= 7'd0;
        count  <= 8'd0;
        d_out  <= 8'd0;
    end

    else
    begin

        // Write operation
        if (d_in_valid && !full)
        begin
            mem[wr_ptr] <= d_in;
            wr_ptr      <= wr_ptr + 1;
        end
 
        // Read operation
        if (d_out_req && !empty)
        begin
            d_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
        end

        // Update FIFO count 
        case ({(d_in_valid && !full), (d_out_req && !empty)})
            2'b10: count <= count + 1;  // Write only
            2'b01: count <= count - 1;  // Read only
            2'b11: count <= count;      // Read + Write
            2'b00: count <= count;      // Nothing
    endcase

    end
end

// FIFO status
assign empty = (count == 0);
assign full  = (count == Depth);

endmodule
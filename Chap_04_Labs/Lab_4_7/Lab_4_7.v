module regfile #(parameter Width = 8, parameter Depth = 16)
(
    output wire  [Width-1:0] d_out,
    input  wire [Width-1:0] d_in,
    input  wire [3:0]       addr_in,
    input  wire             r_w,
    input  wire             clk
);

reg [Width-1:0] mem [0:Depth-1];

// Write operation
always @(posedge clk) begin
    if (r_w)
        mem[addr_in] <= d_in;
end

// Read operation
assign d_out = (!r_w) ? mem[addr_in] : {Width{1'b0}};

endmodule
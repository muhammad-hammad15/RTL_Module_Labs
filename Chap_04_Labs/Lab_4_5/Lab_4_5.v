module edge_detect  (
                        output reg [7:0] count,
                        input wire insig,
                        input wire p_edge,
                        input wire n_edge, 
                        input wire clk,
                        input wire rst
                    );          

reg prev_insig;

always @(posedge clk or posedge reset)
begin
    if (reset)
    begin
        count      <= 8'd0;
        prev_insig <= 1'b0;
    end

    else
    
    begin

        // Positive edge: previous = 0, current = 1
        if (p_edge && insig && !prev_insig)
            count <= count + 1;

        // Negative edge: previous = 1, current = 0
        else if (n_edge && !insig && prev_insig)
            count <= count + 1;

        else
            count <= count;

        // Save current input for next clock
        prev_insig <= insig;
        end
end

endmodule
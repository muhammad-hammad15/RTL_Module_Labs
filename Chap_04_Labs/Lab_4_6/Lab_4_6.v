module seq_detect (
                    output reg out,
                    input wire clk,
                    input wire rst,
                    input wire in_wire
                  );
    
reg [2:0] state;
reg [2:0] next_state;

parameter IDLE = 3'd0,        // nothing useful received yet
          S0   = 3'd1,        // received 0
          S01  = 3'd2,        // received 01
          S011 = 3'd3,        // received 011
          S010 = 3'd4;        // received 010


// State Register
always@ (posedge clk)
begin
    if(rst) 
    state <= IDLE;
    else
    state <= next_state;
end

// Next State Combinational Logic
always@(*) begin
        next_state = state;

    case(state)
    
    IDLE: begin
        if (in_wire == 1'b0)        // 0
        next_state = S0;
        else
        next_state = IDLE;          // nothing IDLE
    end

    S0: begin 
        if(in_wire == 1'b1)         // 01
        next_state = S01;
        else
        next_state = S0;            // 0
    end

    S01: begin 
        if(in_wire == 1'b1)
        next_state = S011;          // 011
        else
        next_state = S010;          // 010
    end

    S010: begin 
        if(in_wire == 1'b1)
        next_state = IDLE;          // 0101 Detected
        else
        next_state = S0;            // 0100, Sequence mismatch
    end

    S011: begin 
        if(in_wire == 1'b0)
        next_state = IDLE;          // 0110 Detected 
        else
        next_state = IDLE;          // 0111, Sequence mismatch
    end

    default: 
    next_state = IDLE;

    endcase

end

// Output Combinational Logic
always @(*) begin
    if (rst)
    out = 1'b0;
    else begin
        if ((state == S010 && in_wire == 1'b1) || (state == S011 && in_wire == 1'b0))
            out = 1'b1;
        else 
            out = 1'b0;
    end
end

endmodule
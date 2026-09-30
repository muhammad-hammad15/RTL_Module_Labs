module  majority_counter(
						  input  wire clk,
						  input  wire rst,
						  input	 wire in,
						  output reg out
						);
	
reg [2:0] state;
reg [2:0] next_state;

parameter S0      = 3'd0,	// Waiting for first sample
          S1_0    = 3'd1,   // First sample = 0
          S1_1    = 3'd2,   // First sample = 1
          S2_00   = 3'd3,   // First two samples = 00
          S2_MIX  = 3'd4,   // First two samples = 01 or 10
          S2_11   = 3'd5,   // First two samples = 11
          OUT_0   = 3'd6,   // Majority result = 0
          OUT_1   = 3'd7;   // Majority result = 1


// State Register
always@ (posedge clk or posedge rst)
	begin
		if (rst)
		state <= S0;
		else
		state <= next_state;
	end	

// Next State Combinational Logic 
always@ (*)
begin

	next_state = state;

	case(state)
	
		// First sample
		S0 : begin
			if (in)
			next_state = S1_1;		// 1
			else 
			next_state = S1_0;		// 0
		end

		// Second Sample
		S1_0 : begin
			if (in)
			next_state = S2_MIX;	// 01
			else
			next_state = S2_00;		// 00
		end

		S1_1: begin
			if (in)
			next_state = S2_11;  	// 11
			else 
			next_state = S2_MIX;	// 10
		end

		// Third Sample
		S2_00 : begin
			next_state = OUT_0; 	// Majority are 0's so output will be 0
		end

		S2_11 : begin
			next_state = OUT_1;		// Majority are 1's so output will be 1
		end

		S2_MIX: begin
			if (in)
			next_state = OUT_1;		            // First two samples are 01 or 10
			else 								// Third sample decides majority
			next_state = OUT_0;
		end	

		// Result States
		OUT_0: begin
			next_state = S0;
		end

		OUT_1: begin
			next_state = S0;
		end

        default:
            next_state = S0;

	endcase

end


// Moore output logic (Output depends ONLY on state)
always@ (*)
begin
	if (state == OUT_1)
		out = 1'b1;
	else 
		out = 1'b0;

end

endmodule
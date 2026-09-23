module Lab1_2 (input wire CLK,
	       input wire RESET,
	       input wire LOAD,
	       input wire ADD,
	       input wire [7:0] DIN,
	       output reg [7:0] CLKCNT,
	       output reg [7:0] SUM);

// Sequential Block 
always @(posedge CLK)
	begin 
		if(RESET) 				// Syncrohonous Reset
		begin
		 CLKCNT <= 0;
		 SUM    <= 0;
	   	end
		else if (LOAD)			// LOAD Value
		CLKCNT  <= DIN;
		else if (ADD)			// ADD Value 
		SUM <= DIN + CLKCNT;
	   else 
		CLKCNT <= CLKCNT + 1;	// Increment Value
	end

endmodule

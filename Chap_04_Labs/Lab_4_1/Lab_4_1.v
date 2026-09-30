module sync_sc_ff (
					output reg [7:0] out,
					input  wire set,
					input  wire clear,
					input  wire clk,
					input  wire en
				  );
	
always@ (posedge clk)
begin
	if(clear)						// If clear = 1, then out = 0 
		out <= 8'b0;
	else if (set)					// If set = 1, then out is assigned out = 16  
		out <= 8'd16;
	else if (en && out > 0)			// If en = 1 and out should be greater than 0, then counter starts to decrement 
		out <= out - 1;
	else 							// If non of the conditions met out will hold its previous value
		out <= out;
end
endmodule
module   decoder_3to8 (
					   output wire [7:0] d,
				 	   input  wire [2:0] din,
				 	   input  wire en 
					  );

// Decoder 3to8 Implementation using Continuous Assignment
assign d[0] = en & ~din[2] & ~din[1] & ~din[0]; 
assign d[1] = en & ~din[2] & ~din[1] &  din[0]; 
assign d[2] = en & ~din[2] &  din[1] & ~din[0]; 
assign d[3] = en & ~din[2] &  din[1] &  din[0]; 
assign d[4] = en &  din[2] & ~din[1] & ~din[0]; 
assign d[5] = en &  din[2] & ~din[1] &  din[0]; 
assign d[6] = en &  din[2] &  din[1] & ~din[0]; 
assign d[7] = en &  din[2] &  din[1] &  din[0]; 

endmodule 

// Below their is Case Statement implementation of the same 3to8 Decoder.
/*module   decoder_3to8 (
					   output wire [7:0] d,
				 	   input  wire [2:0] din,
				 	   input  wire en 
					  );

// Decoder 3to8 Implementation using Case Statement
always@ (*)
begin
		d = 8'b00000000;
	if (en)
	begin
		case(din) 
		3'b000 : d = 8'b00000001;
		3'b001 : d = 8'b00000010;
		3'b010 : d = 8'b00000100;		
		3'b011 : d = 8'b00001000;
		3'b100 : d = 8'b00010000;
		3'b101 : d = 8'b00100000;
		3'b110 : d = 8'b01000000;
		3'b111 : d = 8'b10000000;
		endcase
	end
end
endmodule */ 
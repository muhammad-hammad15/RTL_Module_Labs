module mux2x1 ( input  A,
	        	input  B, 
				input  SEL, 
				output Y);

// Continuous assignment 
assign Y = SEL? B : A;

endmodule

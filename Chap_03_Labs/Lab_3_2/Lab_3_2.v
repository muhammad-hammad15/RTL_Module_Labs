module comparator_rel (
					   output wire EQ,
				 	   output wire GT,
				 	   output wire LT,
				 	   input  wire [7:0] a,
				 	   input  wire [7:0] b
					  );

// Comparator Implementation using Relational operators
assign EQ = ( a == b );
assign GT =   a > b ;
assign LT =   a < b ;

endmodule 
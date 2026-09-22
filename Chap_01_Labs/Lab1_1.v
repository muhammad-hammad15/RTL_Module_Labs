module full_adder (output reg Sum,
	           output reg Cout,
		   input  wire A,
		   input  wire B,
		   input  wire Cin);

// Sum = A XOR B XOR Cin
assign Sum  = A ^ B ^ Cin;

// Cout = AB + BCin + ACin
assign Cout = (A & B) | (B & Cin) | (A & Cin);

endmodule
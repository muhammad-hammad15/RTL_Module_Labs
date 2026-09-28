module ALU  ( input  wire rst,
			  input  wire clk,
			  input  wire [3:0]  opcode,
			  input  wire [31:0] A,
			  input  wire [31:0] B,
			  output reg  [31:0] Dout
			);

// Sequential Block for ALU
always@ (posedge clk)
begin
	if (rst)
		Dout <= 32'b0;
    else 
	begin
		case(opcode)
		4'd0 : Dout <= A + B;			// ADD
		4'd1 : Dout <= A - B;			// SUBTRACT
		4'd2 : Dout <= ~A;				// INVERT A
		4'd3 : Dout <= ~B;				// INVERT B
		4'd4 : Dout <= A & B;			// AND
		4'd5 : Dout <= A | B;			// OR
		4'd6 : Dout <= A ^ B;			// XOR
		4'd7 : Dout <= A ~^ B;			// XNOR
		4'd8 : Dout <= ~(A & B);		// NAND
		4'd9 : Dout <= ~(A | B);		// NOR
		4'd10: Dout <= A << 1;			// SHIFT LEFT  'A' BY 1
		4'd11: Dout <= A >> 1;			// SHIFT RIGHT 'A' BY 1
		4'd12: Dout <= B << 1;			// SHIFT LEFT  'B' BY 1
		4'd13: Dout <= B >> 1;			// SHIFT RIGHT 'B' BY 1
		4'd14: Dout <= A << B[4:0];		// LEFT  BARREL SHIFTER 
		4'd15: Dout <= A >> B[4:0];		// RIGHT BARREL SHIFTER
		default: Dout <= 32'b0;
		endcase
	
	end

end

endmodule
module Shifter_8_bit (output reg [7:0] dout, 
		      input wire CLK,
		      input wire SHL,
		      input wire SHR,
		      input wire Load,
		      input wire [7:0] din);

always@ (posedge CLK)
    begin 
	if (Load)		// Load Value
	dout <= din;

	else if(SHL)		// Shift Left
	dout <= dout << 1;

	else if (SHR)		// Shift Right
	dout <= dout >> 1;

	else			// Hold Previous Value 
	dout <= dout;
    end
	
endmodule 
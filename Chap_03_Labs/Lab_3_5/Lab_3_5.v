module Parity_Gen (
	output reg [35:0] DOUT,
	input wire        CLK,
	input wire [31:0] DIN
);
	

always@ (posedge CLK)
	begin
		// DOUT will be assigned the 32-bit input on every clock edge
		DOUT[31:0] <= DIN;		

		// DOUT 32-35 bits are used to calculate parity 
		DOUT[32] <= ^ DIN[7:0];
		DOUT[33] <= ^ DIN[15:8];
		DOUT[34] <= ^ DIN[23:16];
		DOUT[35] <= ^ DIN[31:24];

	end

endmodule
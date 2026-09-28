module mult3 (
				output reg [7:0] mult_out,
				input wire 		 en,
				input wire [5:0] mult_in
			 );

reg [7:0] ext_mult_in;
reg [7:0] ext_mult;

always@ (*)
	begin
			mult_out    = 8'b00000000;
			ext_mult_in = 8'b00000000;
			ext_mult    = 8'b00000000;

		if (en)
					//mult * 3 = mult << 1 + mult;
			begin
				ext_mult_in = {2'b00,mult_in};        //Extend it to 8-bits cuz if mult_in contain 6 straight one's then the MSB will be lost during shifting
				ext_mult    = ext_mult_in << 1;       // Shift by 1 means multiply by 2
				mult_out    = ext_mult + ext_mult_in; // Add the original no with the shifted one's.
			end

	end

endmodule
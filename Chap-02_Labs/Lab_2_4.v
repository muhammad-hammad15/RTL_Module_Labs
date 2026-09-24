module Lab_2_4 (output reg [7:0] dout,
		input  wire clk,
		input  wire [1:0] c,
		input  wire [7:0] din);


always @(posedge clk)
	begin
	   case(c)
	     2'b00 : dout <= din;	// Load Data
	     2'b01 : dout <= dout + 1;  // Increment by 1
	     2'b10 : dout <= dout - 1;  // Decrement by 1
	     2'b11 : dout <= 8'b0;	// Reset
	   endcase
	end

endmodule 
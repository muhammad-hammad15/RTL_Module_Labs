module Mux_8to1 (output [4:0] dout,
				input  [2:0] sel,
				input  [4:0] a0,
				input  [4:0] a1,
				input  [4:0] a2,
				input  [4:0] a3,
				input  [4:0] a4,
				input  [4:0] a5,
				input  [4:0] a6,
				input  [4:0] a7
				);

// Case Statement Mux_8to1 Implementation
always @( sel or a0 or a1 or a2 or a3 or a4 or a5 or a6 or a7)
	begin
	   case(sel)
	     3'd0 : dout = a0;	// a0 will be selected if sel = 0
	     3'd1 : dout = a1;  // a1 will be selected if sel = 1
	     3'd2 : dout = a2;  // a2 will be selected if sel = 2
	     3'd3 : dout = a3;	// a3 will be selected if sel = 3
		 3'd4 : dout = a4;	// a4 will be selected if sel = 4
	     3'd5 : dout = a5;  // a5 will be selected if sel = 5
	     3'd6 : dout = a6;  // a6 will be selected if sel = 6
	     3'd7 : dout = a7;	// a7 will be selected if sel = 7
	   endcase
	end

endmodule 
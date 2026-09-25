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

// Ternary Operator Mux_8to1 Implementation
assign dout = (sel == 3'd0) ? a0 :
			  (sel == 3'd1) ? a1 :
			  (sel == 3'd2) ? a2 :
			  (sel == 3'd3) ? a3 :
			  (sel == 3'd4) ? a4 :
			  (sel == 3'd5) ? a5 :
			  (sel == 3'd6) ? a6 : a7;


endmodule 
module mux8x1(	output out,
	      	input  wire [2:0] sel,
	      	input  wire d0,
 	      	input  wire d1,
	      	input  wire d2,
		input  wire d3,	
		input  wire d4,
		input  wire d5,
		input  wire d6,
		input  wire d7);

assign out =  (sel == 3'd0)? d0 :		// Ternary operators used for this lab
	      (sel == 3'd1)? d1 :		// if any condition becomes true like for sel = 0, d0 will be selected 
	      (sel == 3'd2)? d2 :		// else it will go towards the second condition. 
	      (sel == 3'd3)? d3 :
	      (sel == 3'd4)? d4 :
	      (sel == 3'd5)? d5 :
	      (sel == 3'd6)? d6 : d7;

endmodule 
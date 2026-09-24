module Lab_2_6 (output reg [3:0] count, 
		input wire [31:0] din);

reg [4:0] i;

always@ (*)
  begin 
 	count = 0; 

	for (i = 0; i < 30; i = i + 1)
         begin
	   
	   if({din[i],din[i+1],din[i+2]} == 3'b010) 	// Main sequence checking 
		
		count = count + 1; 		        // If detected count should be incremented
	   else
   		
		count = count;				// else remains the same, without this else latch will be inferred
	 
	end
   end

endmodule
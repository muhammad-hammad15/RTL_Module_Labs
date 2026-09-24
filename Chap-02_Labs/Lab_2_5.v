module Lab_2_5 (output reg  [14:0] result,
		output reg  [1:0]  remainder,
		input  wire [15:0] din);

reg [15:0] i; 			 //temporary variable for subtraction  

always @(*)
   begin  
      i   = din;
      result = 0;	

      while (i >= 3)
	 begin 
	    i = i - 3;
	    result = result + 1; // result will store the iterations of getting divided
	 end

      remainder = i[1:0]; 	// remainder will store the remaining value 
 
   end

endmodule
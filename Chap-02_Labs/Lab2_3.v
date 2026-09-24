module Control_Lab ( input  wire [7:0] a, 
	       	     input  wire [7:0] b, 
	       	     output reg g,
	       	     output reg l,
	             output reg e);

always@(*)
  begin 
     if (a>b)			// check if a > b = true then, g, l and e will be assigned the values
	 begin
	  g = 1;
	  l = 0;
	  e = 0;
	 end
      else if (a < b)
	 begin 
	  g = 0;
	  l = 1;
	  e = 0;
	 end
      else if (a == b)
	 begin
	  g = 0;
	  l = 0;
	  e = 1;
	 end 
      else
	 begin
	  g = 1;
	  l = 1;
	  e = 1;
	 end
  end 

endmodule
module Counter  (
					input wire clk,
					input wire rst,
					input wire up_down,
					output reg [7:0] count
				);

// Asynchronous Up_down Counter
always@ (posedge clk or posedge rst)  // Asynchronous Active High Reset 
begin
	if (rst)
		count <= 8'd0; 
	else if (up_down)				  //  If up_down = 1, Upcounter
		count <= count + 1;
	else 							  // Else Downcounter
		count <= count - 1;
end 

endmodule
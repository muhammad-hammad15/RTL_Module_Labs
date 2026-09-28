module Lab_3_4 (
				output reg [3:0] Num,
				output reg [2:0] pos,
				input wire [7:0] VAL,
				input wire RESET,
				input wire CLK
);

integer i;
reg [3:0] temp_Num;
reg [2:0] temp_pos;
reg found;

always@ (posedge CLK)	
begin
	if (RESET)
	begin
		Num <= 0;
		pos <= 0;
	end
	else 
	begin

		temp_Num = 0;
		temp_pos = 0;
		found    = 0;

		for (i = 0; i < 8; i = i + 1)
		begin

			if (VAL[i] == 1'b1)
			temp_Num = temp_Num + 1;

			if ((VAL[i] == 1'b1) && (found == 1'b0))
			begin
				temp_pos = i;
				found    = 1'b1;
			end
		end
			Num <= temp_Num;
			pos <= temp_pos;
	end

end

endmodule
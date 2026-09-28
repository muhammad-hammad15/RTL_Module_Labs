`timescale 1ns/1ps

module Lab_3_4_tb;

    reg        CLK;
    reg        RESET;
    reg  [7:0] VAL;

    wire [3:0] Num;
    wire [2:0] pos;

    // DUT
    Lab_3_4 dut (.Num(Num),.pos(pos),.VAL(VAL),.RESET(RESET),.CLK(CLK));

    // 10 ns clock period
    always #5 CLK = ~CLK;

    initial begin

        $dumpfile("Lab_3_4.vcd");
        $dumpvars(0, Lab_3_4_tb);

        CLK   = 0;
        RESET = 1;
        VAL   = 8'b00000000;

        // Reset
        #10;
        RESET = 0;

        // No ones
        VAL = 8'b00000000;
        #10;

        // One 1 at position 3
        VAL = 8'b00001000;
        #10;

        // Four ones, first at position 2
        VAL = 8'b10110100;
        #10;

        // All ones
        VAL = 8'b11111111;
        #10;

        // First one at position 0
        VAL = 8'b10101001;
        #10;

        // Only bit 7 is 1
        VAL = 8'b10000000;
        #10;

        $finish;
    end

    initial begin
        $monitor("Time=%0t RESET=%b VAL=%b Num=%0d pos=%0d", $time, RESET, VAL, Num, pos);
    end

endmodule
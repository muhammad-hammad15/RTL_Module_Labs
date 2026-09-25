`timescale 1ns/1ps

module Shifter_8_bit_tb;

    reg        CLK;
    reg        SHL;
    reg        SHR;
    reg        Load;
    reg  [7:0] din;

    wire [7:0] dout;

    // DUT
    Shifter_8_bit DUT(.dout(dout),.CLK(CLK),.SHL(SHL),.SHR(SHR),.Load(Load),.din(din));

    // Clock generation: 10 ns period
    always #5 CLK = ~CLK;

    initial begin

        $dumpfile("Shifter_8_bit.vcd");
        $dumpvars(0, Shifter_8_bit_tb);

        // Initial values
        CLK  = 0;
        SHL  = 0;
        SHR  = 0;
        Load = 0;
        din  = 8'b0;

        // Load initial value
        din  = 8'b10110010;
        Load = 1;
        #10;

        // Hold value
        Load = 0;
        #10;

        // Shift left
        SHL = 1;
        #10;

        // Shift left again
        #10;

        // Shift right
        SHL = 0;
        SHR = 1;
        #10;

        // Shift right again
        #10;

        // Load a new value
        SHR  = 0;
        Load = 1;
        din  = 8'b00001111;
        #10;

        // Hold value
        Load = 0;
        #10;

        $finish;

    end

    initial begin
        $monitor("Time=%0t Load=%b SHL=%b SHR=%b din=%b dout=%b", $time, Load, SHL, SHR, din, dout);
    end

endmodule
`timescale 1ns/1ps

module Parity_Gen_tb;

    reg         CLK;
    reg  [31:0] DIN;
    wire [35:0] DOUT;

    // DUT
    Parity_Gen DUT (.DOUT(DOUT),.CLK(CLK),.DIN(DIN));

    // 10 ns clock period
    always #5 CLK = ~CLK;

    initial begin

        $dumpfile("Parity_Gen.vcd");
        $dumpvars(0, Parity_Gen_tb);

        CLK = 0;
        DIN = 32'b0;

        // Test 1
        DIN = 32'h00000000;
        #10;

        // Test 2
        DIN = 32'hFFFFFFFF;
        #10;

        // Test 3
        DIN = 32'h12345678;
        #10;

        // Test 4
        DIN = 32'hA5A5A5A5;
        #10;

        // Test 5
        DIN = 32'h00000001;
        #10;

        $finish;

    end

    initial begin
        $monitor( "Time=%0t DIN=%h DOUT=%h Parity=%b", $time, DIN, DOUT, DOUT[35:32]);
    end

endmodule
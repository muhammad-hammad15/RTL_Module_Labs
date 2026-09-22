`timescale 1ns/1ps

module mux2x1_tb;

    reg A;
    reg B;
    reg SEL;

    wire Y;

    // DUT
    mux2x1 DUT(.A(A),.B(B),.SEL(SEL),.Y(Y));

    initial begin

        $dumpfile("mux2x1.vcd");
        $dumpvars(0, mux2x1_tb);

        // Test 1
        A = 0;
        B = 0;
        SEL = 0;
        #10;

        // Test 2
        A = 0;
        B = 1;
        SEL = 0;
        #10;

        // Test 3
        A = 0;
        B = 1;
        SEL = 1;
        #10;

        // Test 4
        A = 1;
        B = 0;
        SEL = 0;
        #10;

        // Test 5
        A = 1;
        B = 0;
        SEL = 1;
        #10;

        // Test 6
        A = 1;
        B = 1;
        SEL = 0;
        #10;

        // Test 7
        SEL = 1;
        #10;

        $finish;
    end

    initial begin
        $monitor("Time=%0t A=%b B=%b SEL=%b Y=%b", $time, A, B, SEL, Y);
    end

endmodule
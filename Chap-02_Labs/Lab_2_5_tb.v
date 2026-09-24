`timescale 1ns/1ps

module Lab_2_5_tb;

    reg  [15:0] din;
    wire [14:0] result;
    wire [1:0]  remainder;

    // DUT
    Lab_2_5 DUT (.din(din),.result(result),.remainder(remainder));

    initial begin

        $dumpfile("Lab_2_5.vcd");
        $dumpvars(0, Lab_2_5_tb);

        // Test 1
        din = 16'd3;
        #10;

        // Test 2
        din = 16'd4;
        #10;

        // Test 3
        din = 16'd10;
        #10;

        // Test 4
        din = 16'd15;
        #10;

        // Test 5
        din = 16'd20;
        #10;

        // Test 6
        din = 16'd100;
        #10;

        // Test 7
        din = 16'd255;
        #10;

        $finish;

    end

    initial begin
        $monitor("Time=%0t din=%0d result=%0d remainder=%0d", $time, din, result, remainder);
    end

endmodule
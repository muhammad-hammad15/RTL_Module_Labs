`timescale 1ns/1ps

module Lab_2_6_tb;

    reg  [31:0] din;
    wire [3:0]  count;

    // DUT
    Lab_2_6 DUT (.count(count), .din(din));

    initial begin

        $dumpfile("Lab_2_6.vcd");
        $dumpvars(0, Lab_2_6_tb);

        // Test 1: no 010
        din = 32'b00000000000000000000000000000000;
        #10;

        // Test 2: one 010 pattern
        din = 32'b00000000000000000000000000000010;
        #10;

        // Test 3: two overlapping 010 patterns, lower bits = 01010 
        din = 32'b00000000000000000000000000001010;
        #10;

        // Test 4: several 010 patterns
        din = 32'b00000000000000000000001010101010;
        #10;

        // Test 5: another mixed pattern
        din = 32'b01000100100010001000100010001000;
        #10;

        $finish;

    end

    initial begin
        $monitor("Time=%0t din=%b count=%0d", $time, din, count);
    end

endmodule
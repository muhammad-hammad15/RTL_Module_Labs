`timescale 1ns/1ps

module Control_Lab_tb;

    reg  [7:0] a;
    reg  [7:0] b;

    wire g;
    wire l;
    wire e;

    // DUT instance
    Control_Lab DUT (.a(a),.b(b),.g(g),.l(l),.e(e));

    initial begin

        // Waveform dump
        $dumpfile("Control_Lab.vcd");
        $dumpvars(0, Control_Lab_tb);

        // Test 1: a > b
        a = 8'd20;
        b = 8'd10;
        #10;

        // Test 2: a < b
        a = 8'd5;
        b = 8'd15;
        #10;

        // Test 3: a == b
        a = 8'd25;
        b = 8'd25;
        #10;

        // Test 4: default case
	a = 8'bxxxxxxxx;
	b = 8'd10;
	#10;

        $finish;

    end

    initial begin
        $monitor("Time=%0t a=%0d b=%0d | g=%b l=%b e=%b", $time, a, b, g, l, e);
    end

endmodule
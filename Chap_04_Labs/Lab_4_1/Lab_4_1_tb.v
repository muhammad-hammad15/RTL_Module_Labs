`timescale 1ns/1ps

module sync_sc_ff_tb;

    reg set;
    reg clear;
    reg clk;
    reg en;

    wire [7:0] out;

    // DUT
    sync_sc_ff DUT (.out(out),.set(set),.clear(clear),.clk(clk),.en(en));

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin

        $dumpfile("sync_sc_ff.vcd");
        $dumpvars(0, sync_sc_ff_tb);

        clk   = 0;
        set   = 0;
        clear = 0;
        en    = 0;

        // Clear counter
        clear = 1;
        #10;

        // Set counter to 16
        clear = 0;
        set   = 1;
        #10;

        // Start counting down
        set = 0;
        en  = 1;
        #10;        // 15
        #10;        // 14
        #10;        // 13
        #10;        // 12

        // Disable counter - hold value
        en = 0;
        #20;

        // Enable again
        en = 1;
        #20;

        // Clear while enabled
        clear = 1;
        #10;

        clear = 0;

        // Try decrementing below zero
        // Your condition should keep out at 0
        en = 1;
        #20;

        $finish;
    end

    initial begin
        $monitor("Time=%0t clear=%b set=%b en=%b out=%0d", $time, clear, set, en, out);
    end

endmodule
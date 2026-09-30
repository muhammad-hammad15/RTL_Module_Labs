`timescale 1ns/1ps

module majority_counter_tb;

    reg in;
    reg clk;
    reg rst;
    wire out;

    majority_counter DUT (.in(in),.clk(clk),.rst(rst),.out(out));

    // 10 ns clock
    always #5 clk = ~clk;

    initial begin

        $dumpfile("majority_counter.vcd");
        $dumpvars(0, majority_counter_tb);

        clk   = 0;
        rst = 1;
        in    = 0;

        // Reset FSM
        #10;
        rst = 0;
         
        // Test 1: 1 0 1
        // Majority = 1
        in = 1;
        #10;

        in = 0;
        #10;

        in = 1;
        #10;

        // OUT_1 state
        #10;

        // Test 2: 0 1 0
        // Majority = 0
        in = 0;
        #10;

        in = 1;
        #10;

        in = 0;
        #10;

        // OUT_0 state
        #10;

        // Test 3: 1 1 0
        // Majority = 1
        in = 1;
        #10;

        in = 1;
        #10;

        in = 0;
        #10;

        // OUT_1 state
        #10;
         
        // Test 4: 0 0 1
        // Majority = 0
        in = 0;
        #10;

        in = 0;
        #10;

        in = 1;
        #10;

        // OUT_0 state
        #10;

        $finish;

    end


    initial begin
        $monitor("Time=%0t rst=%b in=%b state=%0d out=%b", $time, rst, in, DUT.state, out);
    end

endmodule
`timescale 1ns/1ps

module Counter_tb;

    reg clk;
    reg rst;
    reg up_down;
    wire [7:0] count;

    Counter DUT (.clk(clk),.rst(rst),.up_down(up_down),.count(count));

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin

        $dumpfile("Counter.vcd");
        $dumpvars(0, Counter_tb);

        clk = 0;
        rst = 0;
        up_down = 1;

        // Apply asynchronous reset
        #3;
        rst = 1;
        #2;
        rst = 0;

        // Count up
        up_down = 1;
        #40;

        // Count down
        up_down = 0;
        #30;

        // Test asynchronous reset between clock edges
        #2;
        rst = 1;
        #2;
        rst = 0;

        // Count up again
        up_down = 1;
        #30;

        $finish;

    end

    initial begin
        $monitor("Time=%0t rst=%b up_down=%b count=%0d", $time, rst, up_down, count);
    end

endmodule
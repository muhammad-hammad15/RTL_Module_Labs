`timescale 1ns/1ps

module edge_detect_tb;

    reg insig;
    reg p_edge;
    reg n_edge;
    reg clk;
    reg reset;
    wire [7:0] count;

    // DUT
    edge_detect DUT (.insig(insig),.p_edge(p_edge),.n_edge(n_edge),.clk(clk),.reset(reset),.count(count));

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin

        $dumpfile("edge_detect.vcd");
        $dumpvars(0, edge_detect_tb);

        clk    = 0;
        reset  = 1;
        insig  = 0;
        p_edge = 0;
        n_edge = 0;

        // Reset
        #10;
        reset = 0;

         
        // Test 1: Positive edges only
        p_edge = 1;
        n_edge = 0;

        insig = 0;
        #10;

        insig = 1;   // positive edge -> count + 1
        #10;

        insig = 0;   // negative edge -> ignored
        #10;

        insig = 1;   // positive edge -> count + 1
        #10;


        // Reset count
        reset = 1;
        #10;
        reset = 0;


        // Test 2: Negative edges only
        p_edge = 0;
        n_edge = 1;

        insig = 1;
        #10;

        insig = 0;   // negative edge -> count + 1
        #10;

        insig = 1;   // positive edge -> ignored
        #10;

        insig = 0;   // negative edge -> count + 1
        #10;


        // Reset count
        reset = 1;
        #10;
        reset = 0;


        // Test 3: Count both edges
        p_edge = 1;
        n_edge = 1;

        insig = 0;
        #10;

        insig = 1;   // positive -> +1
        #10;

        insig = 0;   // negative -> +1
        #10;

        insig = 1;   // positive -> +1
        #10;

        insig = 0;   // negative -> +1
        #10;

         
        // Test 4: Disable both
        p_edge = 0;
        n_edge = 0;

        insig = 1;
        #10;

        insig = 0;
        #10;

        $finish;
    end


    initial begin
        $monitor("Time=%0t reset=%b p_edge=%b n_edge=%b insig=%b count=%0d", $time, reset, p_edge, n_edge, insig, count);
    end

endmodule
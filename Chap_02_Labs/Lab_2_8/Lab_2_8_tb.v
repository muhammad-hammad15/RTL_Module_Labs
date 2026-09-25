`timescale 1ns/1ps

module mux8x1_tb;

    reg [2:0] sel;

    reg d0;
    reg d1;
    reg d2;
    reg d3;
    reg d4;
    reg d5;
    reg d6;
    reg d7;

    wire out;

    mux8x1 dut (.out(out),.sel(sel),.d0(d0),.d1(d1),.d2(d2),.d3(d3),.d4(d4),.d5(d5),.d6(d6),.d7(d7));

    initial begin

        $dumpfile("mux8x1.vcd");
        $dumpvars(0, mux8x1_tb);

        // Give inputs different values
        d0 = 0;
        d1 = 1;
        d2 = 0;
        d3 = 1;
        d4 = 1;
        d5 = 0;
        d6 = 1;
        d7 = 0;

        // Select each input one by one
        sel = 3'd0;
        #10;

        sel = 3'd1;
        #10;

        sel = 3'd2;
        #10;

        sel = 3'd3;
        #10;

        sel = 3'd4;
        #10;

        sel = 3'd5;
        #10;

        sel = 3'd6;
        #10;

        sel = 3'd7;
        #10;

        $finish;
    end

    initial begin
        $monitor("Time=%0t sel=%b out=%b", $time, sel, out);
    end

endmodule
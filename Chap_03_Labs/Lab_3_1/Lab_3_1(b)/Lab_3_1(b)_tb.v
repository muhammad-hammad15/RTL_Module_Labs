`timescale 1ns/1ps

module Mux_8to1_tb;

    reg  [2:0] sel;
    reg  [4:0] a0;
    reg  [4:0] a1;
    reg  [4:0] a2;
    reg  [4:0] a3;
    reg  [4:0] a4;
    reg  [4:0] a5;
    reg  [4:0] a6;
    reg  [4:0] a7;
    wire [4:0] dout;

    // DUT instance
    Mux_8to1 dut (.dout(dout),.sel(sel),.a0(a0),.a1(a1),.a2(a2),.a3(a3),.a4(a4),.a5(a5),.a6(a6),.a7(a7));

    initial begin

        // Waveform dump
        $dumpfile("Mux_8to1.vcd");
        $dumpvars(0, Mux_8to1_tb);

        // Assign different values to each input
        a0 = 5'd2;
        a1 = 5'd4;
        a2 = 5'd6;
        a3 = 5'd8;
        a4 = 5'd10;
        a5 = 5'd12;
        a6 = 5'd14;
        a7 = 5'd16;

        // Select each input
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
        $monitor( "Time=%0t sel=%0d dout=%0d", $time, sel, dout);
    end

endmodule
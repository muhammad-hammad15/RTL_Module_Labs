`timescale 1ns/1ps

module comparator_rel_tb;

    reg  [7:0] a;
    reg  [7:0] b;

    wire EQ;
    wire GT;
    wire LT;

    // DUT
    comparator_rel dut (.EQ(EQ),.GT(GT),.LT(LT),.a(a),.b(b));

    initial begin

        $dumpfile("comparator_rel.vcd");
        $dumpvars(0, comparator_rel_tb);

        // a = b
        a = 8'd10;
        b = 8'd10;
        #10;

        // a > b
        a = 8'd20;
        b = 8'd10;
        #10;

        // a < b
        a = 8'd5;
        b = 8'd15;
        #10;

        // another equal case
        a = 8'd255;
        b = 8'd255;
        #10;

        // another greater case
        a = 8'd100;
        b = 8'd50;
        #10;

        // another less case
        a = 8'd25;
        b = 8'd60;
        #10;

        $finish;

    end

    initial begin
        $monitor( "Time=%0t a=%0d b=%0d | EQ=%b GT=%b LT=%b", $time, a, b, EQ, GT, LT);
    end

endmodule
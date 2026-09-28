`timescale 1ns/1ps

module mult3_tb;

    reg        en;
    reg  [5:0] mult_in;
    wire [7:0] mult_out;

    // DUT
    mult3 DUT (.mult_out(mult_out),.en(en),.mult_in(mult_in));

    initial begin

        $dumpfile("mult3.vcd");
        $dumpvars(0, mult3_tb);

        // Disable
        en = 0;
        mult_in = 6'd10;
        #10;

        // 5 x 3 = 15
        en = 1;
        mult_in = 6'd5;
        #10;

        // 10 x 3 = 30
        mult_in = 6'd10;
        #10;

        // 20 x 3 = 60
        mult_in = 6'd20;
        #10;

        // 32 x 3 = 96
        mult_in = 6'd32;
        #10;

        // Maximum input: 63 x 3 = 189
        mult_in = 6'd63;
        #10;

        // Disable again
        en = 0;
        #10;

        $finish;

    end

    initial begin
        $monitor("Time=%0t en=%b mult_in=%0d mult_out=%0d", $time, en, mult_in, mult_out);
    end

endmodule
`timescale 1ns/1ps

module decoder_3to8_tb;

    reg  [2:0] din;
    reg        en;
    wire [7:0] d;

    // DUT
    decoder_3to8 dut (.d(d),.din(din),.en(en));

    initial begin

        $dumpfile("decoder_3to8.vcd");
        $dumpvars(0, decoder_3to8_tb);

        // Disable decoder
        en  = 0;
        din = 3'b000;
        #10;

        // Enable decoder
        en = 1;

        din = 3'b000;
        #10;

        din = 3'b001;
        #10;

        din = 3'b010;
        #10;

        din = 3'b011;
        #10;

        din = 3'b100;
        #10;

        din = 3'b101;
        #10;

        din = 3'b110;
        #10;

        din = 3'b111;
        #10;

        // Disable again
        en = 0;
        #10;

        $finish;
    end

    initial begin
        $monitor( "Time=%0t en=%b din=%b d=%b", $time, en, din, d );
    end

endmodule
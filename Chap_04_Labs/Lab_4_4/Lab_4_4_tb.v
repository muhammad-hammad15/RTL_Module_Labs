`timescale 1ns/1ps

module serial_tb;

    reg        clk;
    reg        reset;
    reg  [7:0] byte_in;
    wire       bit_out;

    // DUT
    serial DUT (.bit_out(bit_out),.byte_in(byte_in),.clk(clk),.reset(reset));

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin

        $dumpfile("serial.vcd");
        $dumpvars(0, serial_tb);

        clk     = 0;
        reset   = 1;
        byte_in = 8'b00000000;

        // Reset
        #10;
        reset = 0;

        // First byte
        byte_in = 8'b10110010;

        // Wait 8 clock cycles
        #80;

        // Second byte
        byte_in = 8'b11001001;

        // Wait another 8 clock cycles
        #80;

        // Third byte
        byte_in = 8'b11110000;
        #80;

        $finish;

    end

    initial begin
        $monitor("Time=%0t reset=%b byte_in=%b bit_out=%b", $time, reset, byte_in, bit_out);
    end

endmodule
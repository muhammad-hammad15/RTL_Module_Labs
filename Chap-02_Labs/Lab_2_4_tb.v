`timescale 1ns/1ps

module Lab_2_4_tb;

    reg        clk;
    reg  [1:0] c;
    reg  [7:0] din;

    wire [7:0] dout;

    // DUT instance
    Lab_2_4 dut (.dout(dout),.clk(clk),.c(c),.din(din));

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin

        // Waveform dump
        $dumpfile("Lab_2_4.vcd");
        $dumpvars(0, Lab_2_4_tb);

        // Initial values
        clk = 0;
        c   = 2'b11;
        din = 8'd0;

        // Reset dout to 0
        #10;

        // Load 10 into dout
        c   = 2'b00;
        din = 8'd10;
        #10;

        // Increment
        c = 2'b01;
        #10;

        // Increment again
        #10;

        // Decrement
        c = 2'b10;
        #10;

        // Load another value
        c   = 2'b00;
        din = 8'd25;
        #10;

        // Decrement
        c = 2'b10;
        #10;

        // Reset
        c = 2'b11;
        #10;

        $finish;

    end

    initial begin
        $monitor("Time=%0t c=%b din=%0d dout=%0d", $time, c, din, dout);
    end

endmodule
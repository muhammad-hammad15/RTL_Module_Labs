`timescale 1ns/1ps

module regfile_tb;

    reg         clk;
    reg         r_w;
    reg  [3:0]  addr_in;
    reg  [7:0]  d_in;
    wire [7:0]  d_out;

    // DUT
    regfile DUT (.d_out(d_out),.d_in(d_in),.addr_in(addr_in),.r_w(r_w),.clk(clk));

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin

        $dumpfile("regfile.vcd");
        $dumpvars(0, regfile_tb);

        clk     = 0;
        r_w     = 0;
        addr_in = 0;
        d_in    = 0;

         
        // Write 25 to address 3
        r_w     = 1;
        addr_in = 4'd3;
        d_in    = 8'd25;
        #10;

         
        // Write 50 to address 7
        addr_in = 4'd7;
        d_in    = 8'd50;
        #10;

         
        // Write 100 to address 12
        addr_in = 4'd12;
        d_in    = 8'd100;
        #10;

         
        // Read address 3, Expected d_out = 25
        r_w     = 0;
        addr_in = 4'd3;
        #10;

         
        // Read address 7, Expected d_out = 50
        addr_in = 4'd7;
        #10;

         
        // Read address 12, Expected d_out = 100
        addr_in = 4'd12;
        #10;

        $finish;
    end

    initial begin
        $monitor("Time=%0t r_w=%b addr=%0d d_in=%0d d_out=%0d", $time, r_w, addr_in, d_in, d_out);
    end

endmodule
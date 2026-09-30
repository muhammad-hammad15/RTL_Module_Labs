`timescale 1ns/1ps

module fifo_tb;

    reg        clk;
    reg        reset;
    reg  [7:0] d_in;
    reg        d_in_valid;
    reg        d_out_req;
    wire [7:0] d_out;
    wire       full;
    wire       empty;

    // DUT
    fifo DUT (.d_out(d_out),.full(full),.empty(empty),.d_in(d_in),.d_in_valid(d_in_valid),.d_out_req(d_out_req),.clk(clk),.reset(reset));

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin

        $dumpfile("fifo.vcd");
        $dumpvars(0, fifo_tb);

        clk        = 0;
        reset      = 1;
        d_in       = 0;
        d_in_valid = 0;
        d_out_req  = 0;

        // Reset
        #10;
        reset = 0;
         
        // Write 100
        d_in       = 8'd100;
        d_in_valid = 1;
        #10;

        // Write 200
        d_in = 8'd200;
        #10;

        // Write 300
        d_in = 8'd300;
        #10;

        // Stop writing
        d_in_valid = 0;


         
        // Read first value, Expected: 100
        d_out_req = 1;
        #10;

        // Read second value, Expected: 200
        #10;

        // Read third value, Expected: 300
        #10;

        d_out_req = 0;

        // FIFO should now be empty
        #10;

        // Write again
        d_in       = 8'd50;
        d_in_valid = 1;
        #10;

        d_in       = 8'd60;
        #10;

        d_in_valid = 0;
         
        // Simultaneous read/write, Read 50 and write 70
        d_in       = 8'd70;
        d_in_valid = 1;
        d_out_req  = 1;
        #10;

        // Stop writing, continue reading
        d_in_valid = 0;

        // Expected: 60
        #10;

        // Expected: 70
        #10;
        d_out_req = 0;

        #10;
        $finish;
    end


    initial begin
        $monitor("Time=%0t reset=%b write=%b read=%b d_in=%0d d_out=%0d count=%0d empty=%b full=%b", $time,reset,d_in_valid,d_out_req,d_in,d_out,DUT.count,empty,full);
    end

endmodule
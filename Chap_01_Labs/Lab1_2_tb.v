`timescale 1ns/1ps

module Lab1_2_tb;

    reg CLK;
    reg RESET;
    reg LOAD;
    reg ADD;
    reg [7:0] DIN;

    wire [7:0] CLKCNT;
    wire [7:0] SUM;

    // DUT instance
    Lab1_2 DUT (.CLK(CLK),.RESET(RESET),.LOAD(LOAD),.ADD(ADD),.DIN(DIN),.CLKCNT(CLKCNT),.SUM(SUM));

    // Clock generation: 10 ns period
    always #5 CLK = ~CLK;

    initial begin

        // Waveform dump
        $dumpfile("Lab1_2.vcd");
        $dumpvars(0, Lab1_2_tb);

        // Initial values
        CLK   = 0;
        RESET = 0;
        LOAD  = 0;
        ADD   = 0;
        DIN   = 0;

        // Test 1: Reset
        RESET = 1;
        #10;
        RESET = 0;
 
        // Test 2: Normal counting
        #30;
 
        // Test 3: Load DIN into CLKCNT
        DIN  = 8'd20;
        LOAD = 1;
        #10;
        LOAD = 0;

        // Test 4: Count again
        #20;
 
        // Test 5: ADD
        // SUM = DIN + CLKCNT
 
        DIN = 8'd10;
        ADD = 1;
        #10;
        ADD = 0;

        // Test 6: Continue counting
        #20;

        $finish;

    end

    // Print signal values
    initial begin
        $monitor(
            "Time=%0t RESET=%b LOAD=%b ADD=%b DIN=%0d CLKCNT=%0d SUM=%0d", $time, RESET, LOAD, ADD, DIN, CLKCNT, SUM);
   
 end

endmodule
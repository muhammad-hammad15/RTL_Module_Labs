`timescale 1ns/1ps

module ALU_tb;

    reg         rst;
    reg         clk;
    reg  [3:0]  opcode;
    reg  [31:0] A;
    reg  [31:0] B;
    wire [31:0] Dout;

    // DUT
    ALU DUT (.rst(rst),.clk(clk),.opcode(opcode),.A(A),.B(B),.Dout(Dout));

    // Clock generation - 10 ns period
    always #5 clk = ~clk;

    initial begin

        $dumpfile("ALU.vcd");
        $dumpvars(0, ALU_tb);

        // Initial values
        clk    = 0;
        rst    = 1;
        opcode = 0;
        A      = 32'd10;
        B      = 32'd3;

        // Reset
        #10;
        rst = 0;

        // ADD: 10 + 3 = 13
        opcode = 4'd0;
        #10;

        // SUBTRACT: 10 - 3 = 7
        opcode = 4'd1;
        #10;

        // INVERT A
        opcode = 4'd2;
        #10;

        // INVERT B
        opcode = 4'd3;
        #10;

        // AND
        opcode = 4'd4;
        #10;

        // OR
        opcode = 4'd5;
        #10;

        // XOR
        opcode = 4'd6;
        #10;

        // XNOR
        opcode = 4'd7;
        #10;

        // NAND
        opcode = 4'd8;
        #10;

        // NOR
        opcode = 4'd9;
        #10;

        // A shift left by 1
        opcode = 4'd10;
        #10;

        // A shift right by 1
        opcode = 4'd11;
        #10;

        // B shift left by 1
        opcode = 4'd12;
        #10;

        // B shift right by 1
        opcode = 4'd13;
        #10;

        // Barrel shift A left by B[4:0]
        // B = 3, so A << 3
        opcode = 4'd14;
        #10;

        // Barrel shift A right by B[4:0]
        opcode = 4'd15;
        #10;

        // Reset again
        rst = 1;
        #10;

        $finish;

    end

    initial begin
        $monitor("Time=%0t rst=%b opcode=%0d A=%0d B=%0d Dout=%h", $time, rst, opcode, A, B, Dout);
    end

endmodule
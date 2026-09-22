`timescale 1ns/1ps

module full_adder_tb();

    // Testbench signals
    reg A;
    reg B;
    reg Cin;

    wire Sum;
    wire Cout;

    // Instantiate the DUT
    full_adder DUT (.A(A),.B(B),.Cin(Cin),.Sum(Sum),.Cout(Cout));

    initial begin
        $dumpfile("full_adder.vcd");
        $dumpvars(0, full_adder_tb);
    end

    // Test all possible combinations
    initial begin

        $display("A B Cin | Sum Cout");
        $display("------------------");

        A = 0; B = 0; Cin = 0;
        #10;
        $display("%b %b  %b  |  %b    %b", A, B, Cin, Sum, Cout);

        A = 0; B = 0; Cin = 1;
        #10;
        $display("%b %b  %b  |  %b    %b", A, B, Cin, Sum, Cout);

        A = 0; B = 1; Cin = 0;
        #10;
        $display("%b %b  %b  |  %b    %b", A, B, Cin, Sum, Cout);

        A = 0; B = 1; Cin = 1;
        #10;
        $display("%b %b  %b  |  %b    %b", A, B, Cin, Sum, Cout);

        A = 1; B = 0; Cin = 0;
        #10;
        $display("%b %b  %b  |  %b    %b", A, B, Cin, Sum, Cout);

        A = 1; B = 0; Cin = 1;
        #10;
        $display("%b %b  %b  |  %b    %b", A, B, Cin, Sum, Cout);

        A = 1; B = 1; Cin = 0;
        #10;
        $display("%b %b  %b  |  %b    %b", A, B, Cin, Sum, Cout);

        A = 1; B = 1; Cin = 1;
        #10;
        $display("%b %b  %b  |  %b    %b", A, B, Cin, Sum, Cout);

        $finish;
    end

endmodule
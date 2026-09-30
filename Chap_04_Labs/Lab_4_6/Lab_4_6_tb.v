module tb_seq_detect;

reg clk;
reg rst;
reg in_wire;
wire out;

// DUT Instantiation
seq_detect dut (.out(out),.clk(clk),.rst(rst),.in_wire(in_wire));

// Clock Generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Input Task
task send_bit;
    input bit_value;
    begin
        @(negedge clk);
        in_wire = bit_value;
    end
endtask

// Test Sequence
initial begin

    $dumpfile("seq_detect.vcd");
    $dumpvars(0, tb_seq_detect);


    // Initial values
    rst = 1;
    in_wire = 0;

    // Reset
    #12;
    rst = 0;

    // Test 0101
    send_bit(0);
    send_bit(1);
    send_bit(0);
    send_bit(1);

    // Some gap
    send_bit(1);
    send_bit(1);

    // Test 0110
    send_bit(0);
    send_bit(1);
    send_bit(1);
    send_bit(0);

    // Another sequence
    send_bit(0);
    send_bit(1);
    send_bit(0);
    send_bit(1);

    #20;

    $finish;
end

// Monitor
initial begin
    $monitor("Time=%0t rst=%b in=%b state=%0d out=%b", $time, rst, in_wire, dut.state, out);
end

endmodule
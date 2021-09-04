`timescale 1ns/100ps

module testbench();

    reg a;
    wire o;

    not_gate dut (
        .a(a),
        .o(o)
    );

    initial
    begin
        a = 0;
        #10 a = 1;
        #10 a = 0;
        #10 a = 1;
    end

    initial
    begin
        $display("%t ns: %b - %b", $time, a, o);
        #10 $display("%t ns: %b - %b", $time, a, o);
        #10 $display("%t ns: %b - %b", $time, a, o);
        #10 $display("%t ns: %b - %b", $time, a, o);
	#10;
        $finish;
    end

    initial
    begin
        $fsdbDumpfile("test.fsdb");
        $fsdbDumpvars(0);
    end

endmodule

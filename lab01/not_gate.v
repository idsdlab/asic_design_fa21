`timescale 1ns/100ps

module not_gate (
    input a,
    output o
);

    assign o = ~a;

endmodule

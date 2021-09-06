/** @file
	Implement a 16-sequence LFSR
*/

`ifndef LFSR16_V_
`define LFSR16_V_

/*
	Sequence:
	10000
	00001
	00011
	00111
	01111
	11110
	11101
	11010
	10101
	01011
	10110
	01100
	11001
	10010
	00100
	01000
*/

/** The LFSR module
	@param[in] clk clock input
	@param[in] rst reset line input
	@param[in] cen core enable
	@param[in] wen write enable
	@param[in] din data input
	@param[out] dout data output (augmented lfsr value)
*/

`timescale 1ns/1ps

module lfsr16(
	clk, rst,
	cen, wen, din, dout
);

input clk, rst;
input cen, wen;
input [4:0] din;
output [4:0] dout;

reg [4:0] lfsr; ///< lfsr[4:1] stores the previous value
wire corr_bit = ~|lfsr[2:0];
wire next_bit = lfsr[3]^lfsr[0]^corr_bit;

assign dout = lfsr;

// sequential machine
always @(posedge clk)
	if (rst) lfsr <= 5'b10000; // reset value
	else if (cen) begin
		if (wen) lfsr <= din;
	 	else lfsr <= {lfsr[3:0], next_bit};
	end

endmodule

`endif // LFSR16_V_

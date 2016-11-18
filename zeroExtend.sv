// Zero Extender Module
// Zero-extends an input of 12 bits to 64 bits.

`timescale 1ns/10ps
module ZE(out, in);
	output logic [63:0] out;
	input logic [11:0] in;

	assign out = {52'b0, in};

endmodule
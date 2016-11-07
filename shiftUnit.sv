`timescale 1ns/10ps

module shiftUnit(out, in);

	output logic [63:0] out;
	input logic [63:0] in;

	assign out = in << 2;
	
endmodule

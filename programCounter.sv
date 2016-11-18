// Program Counter for CPU. Keeps track of current instruction address.
`timescale 1ns/10ps
module PC (out, in, reset, clk);
	output logic [63:0] out;
	input logic [63:0] in;
	input logic reset, clk;
	
	DFF64 register (.q(out), .d(in), .reset, .clk, .enable(1'b1));
	
endmodule

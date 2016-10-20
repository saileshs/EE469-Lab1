//`timescale 1ns/10ps
module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	output logic negative, zero, overflow, carry_out;
	output logic [63:0] result;
	input logic [63:0] A, B;
	input logic [2:0] cntrl;
	
	logic [63:0] addsub_out, and_out, or_out, xor_out, less_than_out;
	
	
	addSub64 addsub (.carryOut(carry_out), .result(addsub_out), .overflow, .a(A), .b(B), .carryIn(cntrl[0]));
	and64 ander (.out(and_out), .a(A), .b(B));
	or64 orer (.out(or_out), .a(A), .b(B));
	//nor64 norer (.out(nor_out), .a(A), .b(B));
	
	mux_8to1 m (.out(result), .control(cntrl), .in({64'bx, 64'bx, xor_out, or_out, and_out, addsub_out, addsub_out, B}));
	assign negative = result[63];
	nor64 nor0 (.out(zero), .in(result));
	
endmodule

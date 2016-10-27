`timescale 1ns/10ps
module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	output logic negative, zero, overflow, carry_out;
	output logic [63:0] result;
	input logic [63:0] A, B;
	input logic [2:0] cntrl;
	
	logic [63:0] addsub_out, and_out, or_out, xor_out, less_than_out;
	logic [63:0] alu_input [7:0]; 
	
	addSub64 addsub (.carryOut(carry_out), .result(addsub_out), .overflow, .a(A), .b(B), .carryIn(cntrl[0]));
	and64 ander (.out(and_out), .a(A), .b(B));
	or64 orer (.out(or_out), .a(A), .b(B));
	xor64 xorer (.out(xor_out), .a(A), .b(B));
	
	assign alu_input[0] = B;
	assign alu_input[1] = 64'bx;
	assign alu_input[2] = addsub_out;
	assign alu_input[3] = addsub_out;
	assign alu_input[4] = and_out;
	assign alu_input[5] = or_out;
	assign alu_input[6] = xor_out;
	assign alu_input[7] = 64'bx;
	
	mux_8to1 m (.out(result), .control(cntrl), .in(alu_input));
	
	assign negative = result[63];
	nor64 nor0 (.out(zero), .in(result));
	
endmodule

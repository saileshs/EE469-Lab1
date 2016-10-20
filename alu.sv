module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	output logic negative, zero, overflow, carry_out;
	output logic [63:0] result;
	input logic [63:0] A, B;
	input logic [2:0] cntrl;
	
	logic [63:0] add_out, sub_out, and_out, or_out, nor_out, less_than_out;
	
	
	addSub64 addsub (.carryOut(carry_out), .result, .a(A), .b(B), .carryIn(cntrl[0]));
	and64 ander (.out(and_out), .a(A), .b(B));
	or64 orer (.out(or_out), .a(A), .b(B));
	nor64 norer (.out(nor_out), .a(A), .b(B));
	
	mux_8to1 m (.out(result), .control(cntrl), .in({64'bx, 64'bx, nor_out, less_than_out, sub_out, add_out, or_out, and_out}));
	
	
endmodule

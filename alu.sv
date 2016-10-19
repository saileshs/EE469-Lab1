module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	output logic negative, zero, overflow, carry_out;
	output logic [63:0] result;
	input logic [63:0] A, B;
	input logic [2:0] control;
	
	
	
endmodule

module alu_1bit (A, B, cntrl, carry_in, result, negative, zero, overflow, carry_out);
	output logic result, negative, zero, overflow, carry_out;
	input logic A, B;
	input logic [2:0] control;
	

	
endmodule
`timescale 1ns/10ps
module branchSE (out, in);
	output logic [63:0] out;
	input logic [31:0] in;
	
	logic [63:0] whichInstr [1:0];
	

	assign whichInstr[1] = {{45{in[23]}}, in[23:5]};	// B.Cond (Imm19)
	
	assign whichInstr[2] = 
	
	mux_2to1 mux0 (.out, .control(in[26]), .in(whichInstr[1:0]));
	
endmodule

module dataSE (out, in);

	assign whichInstr[0] = {{55{in[20]}}, in[20:12]}; 	// LDUR/STUR (Imm9)
	
endmodule


module SE_testbench();
	logic [63:0] out;
	logic [31:0] in;
	SE dut (out, in);
	
	initial begin
		in = 32'b11111001111101111111000000000000;
		#200;
	end
	
endmodule
// Sign Extend Module. 
// Depending on which instruction is given, sign extends the immediate values 
// so that they are 64 bits wide.

`timescale 1ns/10ps
module SE (out, in);
	output logic [63:0] out;
	input logic [31:0] in;
	
	logic [63:0] whichInstr [1:0];

	parameter CBZ = 11'b10110100xxx, B = 11'b000101xxxxx, BL = 11'b100101xxxxx, BLT = 11'b01010100xxx, LDUR = 11'b11111000010, STUR = 11'b11111000000;
	
	// Takes varying width immediate value and adds however many 
	// sign bits are necessary to make it 64 bits wide.
	always_comb begin
		casex (in[31:21])
			CBZ: 	out = {{45{in[23]}}, in[23:5]};
			BLT:	out = {{45{in[23]}}, in[23:5]};
			B: 	out = {{38{in[25]}}, in[25:0]};
			BL: 	out = {{38{in[25]}}, in[25:0]};
			LDUR: out = {{55{in[20]}}, in[20:12]};
			STUR: out = {{55{in[20]}}, in[20:12]};
			default : out = 64'bx;
		endcase
	end	
endmodule

module SE_testbench();
	logic [63:0] out;
	logic [31:0] in;
	SE dut (out, in);
	
	initial begin
		// Test CBZ. Output should be sign extended 1111111111001111001
		in = 32'b10110100111111111100111100111111;
		#200;
	
		// Test B. Output should be all 0s
		in = 32'b00010100000000000000000000000000;
		#200;
		
		// Test BL. Output should be sign extended 1s
		in = 32'b10010111111111111111111111111111;
		#200;
		
		// Test B.LT. Output should be sign extended 1111111111001111001
		in = 32'b10110100111111111100111100111111;
		#200;
		
		// Test LDUR. Output should be sign extended 10101010101
		in = 32'b11111000010101010101001000011100;
		#200;
		
		// Test STUR. Output should be sign extended 10101010101
		in = 32'b11111000000101010101001000011100;
		#200;
		
	end
	
endmodule

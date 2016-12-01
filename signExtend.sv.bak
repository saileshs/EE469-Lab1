`timescale 1ns/10ps
module SE (out, in);
	output logic [63:0] out;
	input logic [31:0] in;
	
	logic [63:0] whichInstr [1:0];

	parameter CBZ = 11'b10110100xxx, B = 11'b000101xxxxx, BL = 11'b100101xxxxx, BLT = 11'b01010100xxx, LDUR = 11'b11111000010, STUR = 11'b11111000000;
	
	always_comb begin
		case (in[31:21])
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
		in = 32'b11111001111101111111000000000000;
		#200;
	end
	
endmodule

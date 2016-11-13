`timescale 1ns/10ps
module shifter (out, in);
	output logic [63:0] out;
	input logic [63:0] in;
	
	assign out = {in[61:0], 2'b00};
	
endmodule

module shift_testbench();
	logic [63:0] out, in;
	shifter dut (out, in);
	
	parameter delay = 20;
	
	initial begin
		in = 64'b1111110001111111111111111111111111111111111111111111111111111111;
		#(delay);
	end
endmodule
	
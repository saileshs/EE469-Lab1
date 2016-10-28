`timescale 1ns/10ps

// A 5 to 32 decoder built with several smaller decoders, 
// including a 2 to 4 decorder and 3 to 8 decorders.
module decoder_5to32(out, in, RegWrite);
	output logic [31:0] out;
	input logic [4:0] in;
	input logic RegWrite;
	logic [3:0] enable;
	
	decoder_2to4 d0(.out(enable), .in(in[4:3]), .enable(RegWrite));
	decoder_3to8 d1(.out(out[31:24]), .in(in[2:0]), .enable(enable[3]));
	decoder_3to8 d2(.out(out[23:16]), .in(in[2:0]), .enable(enable[2]));
	decoder_3to8 d3(.out(out[15:8]), .in(in[2:0]), .enable(enable[1]));
	decoder_3to8 d4(.out(out[7:0]), .in(in[2:0]), .enable(enable[0]));
endmodule

module decoder_2to4(out, in, enable);
	output logic [3:0] out;
	input logic [1:0] in;
	input logic enable;
	
	logic in0_not, in1_not;
	
	not #50 not0 (in0_not, in[0]);
	not #50 not1 (in1_not, in[1]);
	
	and #50 and0 (out[0], in1_not, in0_not, enable);
	and #50 and1 (out[1], in1_not, in[0], enable);
	and #50 and2 (out[2], in[1], in0_not, enable);
	and #50 and3 (out[3], in[1], in[0], enable);
	
endmodule
	
module decoder_3to8(out, in, enable);
	output logic [7:0] out;
	input logic [2:0] in;
	input logic enable;
	
	logic in0_not, in1_not, in2_not;
	
	not #50 n0 (in0_not, in[0]);
	not #50 n1 (in1_not, in[1]);
	not #50 n2 (in2_not, in[2]);
	
	and #50 and0 (out[0], in0_not, in1_not, in2_not, enable);
	and #50 and1 (out[1], in[0], in1_not, in2_not, enable);
	and #50 and2 (out[2], in0_not, in[1], in2_not, enable);
	and #50 and3 (out[3], in[0], in[1], in2_not, enable);
	and #50 and4 (out[4], in0_not, in1_not, in[2], enable);
	and #50 and5 (out[5], in[0], in1_not, in[2], enable);
	and #50 and6 (out[6], in0_not, in[1], in[2], enable);
	and #50 and7 (out[7], in[0], in[1], in[2], enable);
	
endmodule

module decoder_testbench();
	logic [31:0] out;
	logic [4:0] in;
	logic RegWrite;
	
	decoder_5to32 dut (.out, .in, .RegWrite);
	integer i;
	initial begin
		#350; RegWrite <= 1; #350;
		for (i = 0; i < 31; i++) begin
			in = i; #350;
		end
	end
endmodule

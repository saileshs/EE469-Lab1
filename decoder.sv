`timescale 1ns/10ps
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

//module decoder_5to32big(out, in, enable);
//	output logic [31:0] out;
//	input logic [4:0] in;
//	input logic enable;
//	
//	logic in0_not, in1_not, in2_not, in3_not, in4_not;
//	not #50 n0 (in0_not, in[0]);
//	not #50 n1 (in1_not, in[1]);
//	not #50 n2 (in2_not, in[2]);
//	not #50 n3 (in3_not, in[3]);
//	not #50 n4 (in4_not, in[4]);
//
//	and #50 and0 (out[0], in0_not, in1_not, in2_not, in3_not, in4_not, enable);
//	and #50 and1 (out[1], in[0], in1_not, in2_not, in3_not, in4_not, enable);
//	and #50 and2 (out[2], in0_not, in[1], in2_not, in3_not, in4_not, enable);
//	and #50 and3 (out[3], in[0], in[1], in2_not, in3_not, in4_not, enable);
//	and #50 and4 (out[4], in0_not, in1_not, in[2], in3_not, in4_not, enable);
//	and #50 and5 (out[5], in[0], in1_not, in[2], in3_not, in4_not, enable);
//	and #50 and6 (out[6], in0_not, in[1], in[2], in3_not, in4_not, enable);
//	and #50 and7 (out[7], in[0], in[1], in[2], in3_not, in4_not, enable);
//	and #50 and8 (out[8], in0_not, in1_not, in2_not, in[3], in4_not, enable);
//	and #50 and9 (out[9], in[0], in1_not, in2_not, in[3], in4_not, enable);
//	and #50 and10 (out[10], in0_not, in[1], in2_not, in[3], in4_not, enable);
//	and #50 and11 (out[11], in[0], in[1], in2_not, in[3], in4_not, enable);
//	and #50 and12 (out[12], in0_not, in1_not, in[2], in[3], in4_not, enable);
//	and #50 and13 (out[13], in[0], in1_not, in[2], in[3], in4_not, enable);
//	and #50 and14 (out[14], in0_not, in[1], in[2], in[3], in4_not, enable);
//	and #50 and15 (out[15], in[0], in[1], in[2], in[3], in4_not, enable);
//	and #50 and16 (out[16], in0_not, in1_not, in2_not, in3_not, in[4], enable);
//	and #50 and17 (out[17], in[0], in1_not, in2_not, in3_not, in[4], enable);
//	and #50 and18 (out[18], in0_not, in[1], in2_not, in3_not, in[4], enable);
//	and #50 and19 (out[19], in[0], in[1], in2_not, in3_not, in[4], enable);
//	and #50 and20 (out[20], in0_not, in1_not, in[2], in3_not, in[4], enable);
//	and #50 and21 (out[21], in[0], in1_not, in[2], in3_not, in[4], enable);
//	and #50 and22 (out[22], in0_not, in[1], in[2], in3_not, in[4], enable);
//	and #50 and23 (out[23], in[0], in[1], in[2], in3_not, in[4], enable);
//	and #50 and24 (out[24], in0_not, in1_not, in2_not, in[3], in[4], enable);
//	and #50 and25 (out[25], in[0], in1_not, in2_not, in[3], in[4], enable);
//	and #50 and26 (out[26], in0_not, in[1], in2_not, in[3], in[4], enable);
//	and #50 and27 (out[27], in[0], in[1], in2_not, in[3], in[4], enable);
//	and #50 and28 (out[28], in0_not, in1_not, in[2], in[3], in[4], enable);
//	and #50 and29 (out[29], in[0], in1_not, in[2], in[3], in[4], enable);
//	and #50 and30 (out[30], in0_not, in[1], in[2], in[3], in[4], enable);
//	and #50 and31 (out[31], in[0], in[1], in[2], in[3], in[4], enable);
//
//endmodule
	
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
	
	
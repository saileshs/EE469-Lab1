`timescale 1ns/10ps
module regfile (ReadData1, ReadData2, ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, clk);
	output logic [63:0] 	ReadData1, ReadData2;
	input logic  [4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	input logic  [63:0] 	WriteData;
	input logic 			RegWrite, clk;
	logic			 [63:0] 	registerOutput [31:0];
	logic 		 [31:0] 	enableRegister;
	logic reset;
	
	//assign reset = 1'b0;
	
	decoder_5to32big pickWriteRegister (.out(enableRegister), .in(WriteRegister), .enable(RegWrite));
	
	
	genvar i;
	generate
		for(i=0; i < 31; i++) begin : eachRegister
			DFF64 register (.q(registerOutput[i]), .d(WriteData), .reset, .clk, .enable(enableRegister[i]));
		end
	endgenerate
	
	assign registerOutput[31] = 64'b0;
	
	mux_32to1 readRegister1 (.out(ReadData1), .readReg(ReadRegister1), .in(registerOutput));
	mux_32to1 readRegister2 (.out(ReadData2), .readReg(ReadRegister2), .in(registerOutput));
	
endmodule

// D flip-flop w/ synchronous reset
module DFF1 (q, d, reset, clk, enable); 
	output reg q;
	input logic d, reset, clk, enable;
	
	always_ff @(posedge clk) // Hold val until clock edge
		if (reset)
			q <= 0; // On reset, set to 0
		else if (enable)
			q <= d; // Otherwise out = d
endmodule
	

module DFF4(q, d, reset, clk, enable);
	output logic [3:0] q;
	input logic [3:0] d;
	input logic reset, clk, enable;
	
	DFF1 dff1 (.q(q[0]), .d(d[0]), .reset, .clk, .enable);
	DFF1 dff2 (.q(q[1]), .d(d[1]), .reset, .clk, .enable);
	DFF1 dff3 (.q(q[2]), .d(d[2]), .reset, .clk, .enable);
	DFF1 dff4 (.q(q[3]), .d(d[3]), .reset, .clk, .enable);
endmodule

module DFF16(q, d, reset, clk, enable);
	output logic [15:0] q;
	input logic [15:0] d;
	input logic clk, reset, enable;
	
	DFF4 dff1 (.q(q[3:0]), .d(d[3:0]), .reset, .clk, .enable);
	DFF4 dff2 (.q(q[7:4]), .d(d[7:4]), .reset, .clk, .enable);
	DFF4 dff3 (.q(q[11:8]), .d(d[11:8]), .reset, .clk, .enable);
	DFF4 dff4 (.q(q[15:12]), .d(d[15:12]), .reset, .clk, .enable);
endmodule

module DFF64(q, d, reset, clk, enable);
	output logic [63:0] q;
	input logic [63:0] d;
	input logic clk, reset, enable;
	
	DFF16 dff1 (.q(q[15:0]),  .d(d[15:0]),  .reset, .clk, .enable);
	DFF16 dff2 (.q(q[31:16]), .d(d[31:16]), .reset, .clk, .enable);
	DFF16 dff3 (.q(q[47:32]), .d(d[47:32]), .reset, .clk, .enable);
	DFF16 dff4 (.q(q[63:48]), .d(d[63:48]), .reset, .clk, .enable);
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

module decoder_5to32big(out, in, enable);
	output logic [31:0] out;
	input logic [4:0] in;
	input logic enable;
	
	logic in0_not, in1_not, in2_not, in3_not, in4_not;
	not #50 n0 (in0_not, in[0]);
	not #50 n1 (in1_not, in[1]);
	not #50 n2 (in2_not, in[2]);
	not #50 n3 (in3_not, in[3]);
	not #50 n4 (in4_not, in[4]);

	and #50 and0 (out[0], in0_not, in1_not, in2_not, in3_not, in4_not, enable);
	and #50 and1 (out[1], in[0], in1_not, in2_not, in3_not, in4_not, enable);
	and #50 and2 (out[2], in0_not, in[1], in2_not, in3_not, in4_not, enable);
	and #50 and3 (out[3], in[0], in[1], in2_not, in3_not, in4_not, enable);
	and #50 and4 (out[4], in0_not, in1_not, in[2], in3_not, in4_not, enable);
	and #50 and5 (out[5], in[0], in1_not, in[2], in3_not, in4_not, enable);
	and #50 and6 (out[6], in0_not, in[1], in[2], in3_not, in4_not, enable);
	and #50 and7 (out[7], in[0], in[1], in[2], in3_not, in4_not, enable);
	and #50 and8 (out[8], in0_not, in1_not, in2_not, in[3], in4_not, enable);
	and #50 and9 (out[9], in[0], in1_not, in2_not, in[3], in4_not, enable);
	and #50 and10 (out[10], in0_not, in[1], in2_not, in[3], in4_not, enable);
	and #50 and11 (out[11], in[0], in[1], in2_not, in[3], in4_not, enable);
	and #50 and12 (out[12], in0_not, in1_not, in[2], in[3], in4_not, enable);
	and #50 and13 (out[13], in[0], in1_not, in[2], in[3], in4_not, enable);
	and #50 and14 (out[14], in0_not, in[1], in[2], in[3], in4_not, enable);
	and #50 and15 (out[15], in[0], in[1], in[2], in[3], in4_not, enable);
	and #50 and16 (out[16], in0_not, in1_not, in2_not, in3_not, in[4], enable);
	and #50 and17 (out[17], in[0], in1_not, in2_not, in3_not, in[4], enable);
	and #50 and18 (out[18], in0_not, in[1], in2_not, in3_not, in[4], enable);
	and #50 and19 (out[19], in[0], in[1], in2_not, in3_not, in[4], enable);
	and #50 and20 (out[20], in0_not, in1_not, in[2], in3_not, in[4], enable);
	and #50 and21 (out[21], in[0], in1_not, in[2], in3_not, in[4], enable);
	and #50 and22 (out[22], in0_not, in[1], in[2], in3_not, in[4], enable);
	and #50 and23 (out[23], in[0], in[1], in[2], in3_not, in[4], enable);
	and #50 and24 (out[24], in0_not, in1_not, in2_not, in[3], in[4], enable);
	and #50 and25 (out[25], in[0], in1_not, in2_not, in[3], in[4], enable);
	and #50 and26 (out[26], in0_not, in[1], in2_not, in[3], in[4], enable);
	and #50 and27 (out[27], in[0], in[1], in2_not, in[3], in[4], enable);
	and #50 and28 (out[28], in0_not, in1_not, in[2], in[3], in[4], enable);
	and #50 and29 (out[29], in[0], in1_not, in[2], in[3], in[4], enable);
	and #50 and30 (out[30], in0_not, in[1], in[2], in[3], in[4], enable);
	and #50 and31 (out[31], in[0], in[1], in[2], in[3], in[4], enable);

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

module decoder_5to32(out, in, RegWrite);
	output logic [31:0] out;
	input logic [4:0] in;
	input logic RegWrite;
	logic [3:0] enable;
	
	decoder_2to4 d0(.out(enable), .in(in[4:3]), .enable(RegWrite));
	decoder_3to8 d1(.out(out[31:24]), .in(in[2:0]), .enable(enable[0]));
	decoder_3to8 d2(.out(out[23:16]), .in(in[2:0]), .enable(enable[1]));
	decoder_3to8 d3(.out(out[15:8]), .in(in[2:0]), .enable(enable[2]));
	decoder_3to8 d4(.out(out[7:0]), .in(in[2:0]), .enable(enable[3]));
endmodule
	
module mux_2to1(out, control, in);
	output logic out;
	input logic [1:0] in;
	input logic control;
	
	logic con_not;
	
	not #50 not0 (con_not, control);
	and #50 and0 (out, in[0], con_not);
	and #50 and1 (out, in[1], control);
endmodule

module mux_4to1(out, control, in);
	output logic out;
	input logic [3:0] in;
	input logic [1:0] control;
	
	logic out_mux0, out_mux1;
	
	mux_2to1 mux0 (.out(out_mux0), .control(control[1]), .in(in[1:0]));
	mux_2to1 mux1 (.out(out_mux1), .control(control[1]), .in(in[3:2]));
	mux_2to1 mux2 (.out(out), .control(control[0]), .in({out_mux1, out_mux0}));
endmodule

module mux_16to1(out, control, in);
	output logic out;
	input logic [15:0] in;
	input logic [3:0] control;
	
	logic out_mux0, out_mux1, out_mux2, out_mux3;
	
	mux_4to1 mux0 (.out(out_mux0), .control(control[3:2]), .in(in[3:0]));
	mux_4to1 mux1 (.out(out_mux1), .control(control[3:2]), .in(in[7:4]));
	mux_4to1 mux2 (.out(out_mux2), .control(control[3:2]), .in(in[11:8]));
	mux_4to1 mux3 (.out(out_mux3), .control(control[3:2]), .in(in[15:12]));
	mux_4to1 mux4 (.out(out), .control(control[1:0]), .in({out_mux3, out_mux2, out_mux1, out_mux0}));
endmodule

module mux_32to1(out, readReg, in);
	output logic [63:0] out;
	input logic [63:0] in [31:0];
	input logic [4:0] readReg;
	
	genvar i;
	generate
		for(i=0; i<64; i++) begin : sixtyfour32to1mux
			logic out_mux0, out_mux1;

			mux_16to1 mux0 (.out(out_mux0), .control(readReg[4:1]), .in(in[i][15:0]));
			mux_16to1 mux1 (.out(out_mux1), .control(readReg[4:1]), .in(in[i][31:16]));
			mux_2to1 mux2 (.out(out[i]), .control(readReg[0]), .in({out_mux1, out_mux0}));
		end
	endgenerate 
endmodule



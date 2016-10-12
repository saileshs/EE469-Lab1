module RegisterFile (readReg1, readReg2, writeReg, writeData, regWrite, readData1, readData2);
	input logic [4:0] readReg1, readReg2, writeReg;
	input logic [63:0] writeData;
	input logic regWrite;
	output logic [63:0] readData1, readData2;
	logic [63:0] registerOutput;
	logic reset, clk;
	logic [31:0] enableRegister;
	
<<<<<<< HEAD
	//Decoder decode (.in(writeReg), .enable(regWrite), .out(enableRegister));
	
	
	DFF64 registers[31:0] (.q(registerOutput), .d(writeData), .reset, .clk, .enable(0));
=======
	decoder_5to32 decode (.out(enableRegister), .in(writeReg), .regWrite);
>>>>>>> 6528fbfd5a8f86cf84db6c60ac7cf96ffcb06735

	genvar i;
	generate
		for(i=0; i < 32; i++) begin : eachRegister
			DFF64 register (.q(registerOutput), .d(writeData), .reset, .clk, .enable(enableRegister[i]));
		end
	endgenerate
endmodule

// D flip-flop w/synchronous reset
module DFF1 (q, d, reset, clk, enable); 
	output logic q;
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
	input logic clk, reset, enable;
	
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

<<<<<<< HEAD
/*
module Decoder(in, enable, out);
=======
module decoder_2to4(out, in, enable);
	output logic [3:0] out;
	input logic [1:0] in;
	input logic enable;
	
	logic in0_not, in1_not;
	
	not not1 (in0_not, in[0]);
	not not2 (in1_not, in[1]);
	
	and and0 (out[0], in0_not, in1_not);
	and and1 (out[1], in[0], in1_not);
	and and2 (out[2], in[1], in0_not);
	and and3 (out[3], in[0], in[1]);
	
endmodule
 
module decoder_3to8(out, in, enable);
	output logic [7:0] out;
	input logic [2:0] in;
	input logic enable;
	
	logic in0_not, in1_not, in2_not;
	
	not n0 (in0_not, in[0]);
	not n1 (in1_not, in[1]);
	not n2 (in2_not, in[2]);
	
	and and0 (out[0], in0_not, in1_not, in2_not);
	and and1 (out[1], in[0], in1_not, in2_not);
	and and2 (out[2], in0_not, in[1], in2_not);
	and and3 (out[3], in[0], in[1], in2_not);
	and and4 (out[4], in0_not, in1_not, in[2]);
	and and5 (out[5], in[0], in1_not, in[2]);
	and and6 (out[6], in0_not, in[1], in[2]);
	and and7 (out[7], in[0], in[1], in[2]);
	
endmodule

module decoder_5to32(out, in, regWrite);
>>>>>>> 6528fbfd5a8f86cf84db6c60ac7cf96ffcb06735
	output logic [31:0] out;
	input logic [4:0] in;
	input logic regWrite;
	logic [3:0] enable;
	
	decoder_2to4 d0(.out(enable), .in(in[4:3]), .enable(regWrite));
	decoder_3to8 d1(.out(out[31:24]), .in(in[2:0]), .enable(enable[0]));
	decoder_3to8 d2(.out(out[23:16]), .in(in[2:0]), .enable(enable[1]));
	decoder_3to8 d3(.out(out[15:8]), .in(in[2:0]), .enable(enable[2]));
	decoder_3to8 d4(.out(out[7:0]), .in(in[2:0]), .enable(enable[3]));
endmodule
<<<<<<< HEAD
*/


module decoder_2to4(Y3, Y2, Y1, Y0, A, B, enable);

	output Y3, Y2, Y1, Y0;
	input A, B;
	input enable;

	always_comb
		begin
		if (enable == 1'b1)
			case ( {A,B} )
				2'b00: {Y3,Y2,Y1,Y0} = 4'b1110;
				2'b01: {Y3,Y2,Y1,Y0} = 4'b1101;
				2'b10: {Y3,Y2,Y1,Y0} = 4'b1011;
				2'b11: {Y3,Y2,Y1,Y0} = 4'b0111;
				default: {Y3,Y2,Y1,Y0} = 4'bxxxx;
			endcase
		if (enable == 0)
			{Y3,Y2,Y1,Y0} = 4'b1111;
		end
endmodule
 
module decoder_3to8(Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0, C, D, E, enable);

	output Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0;
	input C, D, E;
	input enable;
	
	always_comb
		begin
		if (enable == 1'b1)
			case ( {C,D,E} )
				4'b1000: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b11111110;
				4'b1001: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b11111101;
				4'b1010: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b11111011;
				4'b1011: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b11110111;
				4'b1100: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b11101111;
				4'b1101: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b11011111;
				4'b1110: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b10111111;
				4'b1111: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b01111111;
				default: {Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'bxxxxxxxx;
			endcase
		if (enable == 0)
			{Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0} = 8'b11111111;
		end
endmodule
 
=======
	

	
module mux_4to1(out, control, in);
	output logic  out;
	input logic [3:0] in;
	input logic [1:0] control;
	
	logic con0_not, con1_not;
	logic [3:0] temp;
	
	not n0 (con0_not, control[0]);
	not n1 (con1_not, control[1]);
	
	and and0 (temp[0], in[0], con0_not, con1_not);
	and and1 (temp[1], in[1], control[0], con1_not);
	and and2 (temp[2], in[2], con0_not, control[1]);
	and and3 (temp[3], in[3], control[0], control[1]);
	
	or or0 (out, temp[0], temp[1], temp[2], temp[3]);
	
endmodule

module mux_16to1(out, control, in);
	output logic out;
	input logic [15:0] in;
	input logic [3:0] control;
	
	logic [3:0] temp;
	
	mux_4to1 mux0 (.out(temp[0]), .control(control[3:2]), .in(in[15:12]));
	mux_4to1 mux1 (.out(temp[1]), .control(control[3:2]), .in(in[11:8]));
	mux_4to1 mux2 (.out(temp[2]), .control(control[3:2]), .in(in[7:4]));
	mux_4to1 mux3 (.out(temp[3]), .control(control[3:2]), .in(in[3:0]));
	
	mux_4to1 mux4 (.out, .control(control[1:0]), .in(temp));
	
endmodule

module mux_32to1(out, in, readReg);
	output logic [63:0] out;
	input logic [31:0][63:0] in;
	input logic [4:0] readReg;
	
	
			
	
>>>>>>> 6528fbfd5a8f86cf84db6c60ac7cf96ffcb06735

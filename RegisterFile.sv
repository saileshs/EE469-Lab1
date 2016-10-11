module RegisterFile (readReg1, readReg2, writeReg, writeData, regWrite, readData1, readData2);
	input logic [5:0] readReg1, readReg2, writeReg;
	input logic [63:0] writeData;
	input logic regWrite;
	output logic [63:0] readData1, readData2;
	logic [63:0] registerOutput;
	logic reset, clk;
	logic [31:0] enableRegister;
	
	Decoder decode (.in(writeReg), .enable(regWrite), .out(enableRegister));	
	DFF64 registers[31:0] (.q(registerOutput), .d(writeData), .reset, .clk, .enable(0));	
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



module Decoder(in, enable, out);
	output logic [31:0] out;
	input logic [4:0] in;
	input logic enable;	
	
	always_comb 
		begin
			case(in)
				0: out = ;
			endcase
		end
endmodule

`timescale 1ns/10ps
module regfile (ReadData1, ReadData2, ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, clk);
	output logic [63:0] 	ReadData1, ReadData2;
	input logic  [4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	input logic  [63:0] 	WriteData;
	input logic 			RegWrite, clk;
	logic			 [63:0] 	registerOutput [31:0];
	logic 		 [31:0] 	enableRegister;
	logic reset;
	
	assign reset = 1'b0;
	
	decoder_5to32 pickWriteRegister (.out(enableRegister), .in(WriteRegister), .RegWrite);
	
	
	genvar i;
	generate
		for(i=0; i < 31; i++) begin : eachRegister
			DFF64 register (.q(registerOutput[i]), .d(WriteData), .reset, .clk, .enable(enableRegister[i]));
		end
	endgenerate
	
	assign registerOutput[31] = 64'b0;
	
	mux_32to1 readRegister1 (.out(ReadData1), .control(ReadRegister1), .in(registerOutput));
	mux_32to1 readRegister2 (.out(ReadData2), .control(ReadRegister2), .in(registerOutput));
	
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
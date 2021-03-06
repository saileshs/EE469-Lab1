`timescale 1ns/10ps

// D flip-flop w/ synchronous reset
module D_FF (q, d, reset, clk);
	output reg q;
	input d, reset, clk;
	
	always_ff @(posedge clk)
		if (reset)
			q <= 0; // On reset, set to 0
		else
			q <= d; // Otherwise out = d
endmodule

// DFF with enable signal
module DFF1_enable (q, d, reset, clk, enable);
	output logic q;
	input logic d, reset, clk, enable;
	logic mux_out;
	
	mux_2to1_1bit m (.out(mux_out), .control(enable), .in({d, q}));
	D_FF dff0 (.q, .d(mux_out), .reset, .clk);
endmodule

module DFF_2 (q, d, reset, clk, enable);
	output logic [1:0] q;
	input logic [1:0] d;
	input logic reset, clk, enable;

	DFF1_enable dff1 (.q(q[0]), .d(d[0]), .reset, .clk, .enable);
	DFF1_enable dff2 (.q(q[1]), .d(d[1]), .reset, .clk, .enable);
endmodule

module DFF3 (q, d, reset, clk, enable);
	output logic [2:0] q;
	input logic [2:0] d;
	input logic reset, clk, enable;

	DFF_2 dff1 (.q(q[1:0]), .d(d[1:0]), .reset, .clk, .enable);
	DFF1_enable dff2 (.q(q[2]), .d(d[2]), .reset, .clk, .enable);
endmodule
	
// 4 bit DFF helper
module DFF4(q, d, reset, clk, enable);
	output logic [3:0] q;
	input logic [3:0] d;
	input logic reset, clk, enable;
	
	DFF_2 dff1 (.q(q[1:0]), .d(d[1:0]), .reset, .clk, .enable);
	DFF_2 dff2 (.q(q[3:2]), .d(d[3:2]), .reset, .clk, .enable);
endmodule

module DFF5(q, d, reset, clk, enable);
	output logic [4:0] q;
	input logic [4:0] d;
	input logic reset, clk, enable;
	
	DFF4 dff1 (.q(q[3:0]), .d(d[3:0]), .reset, .clk, .enable);
	DFF1_enable dff2 (.q(q[4]), .d(d[4]), .reset, .clk, .enable);
endmodule

// 16 bit DFF helper
module DFF16(q, d, reset, clk, enable);
	output logic [15:0] q;
	input logic [15:0] d;
	input logic clk, reset, enable;
	
	DFF4 dff1 (.q(q[3:0]), .d(d[3:0]), .reset, .clk, .enable);
	DFF4 dff2 (.q(q[7:4]), .d(d[7:4]), .reset, .clk, .enable);
	DFF4 dff3 (.q(q[11:8]), .d(d[11:8]), .reset, .clk, .enable);
	DFF4 dff4 (.q(q[15:12]), .d(d[15:12]), .reset, .clk, .enable);
endmodule

module DFF32(q, d, reset, clk, enable);
	output logic [31:0] q;
	input logic [31:0] d;
	input logic clk, reset, enable;
	
	DFF16 dff1 (.q(q[15:0]), .d(d[15:0]), .reset, .clk, .enable);
	DFF16 dff2 (.q(q[31:16]), .d(d[31:16]), .reset, .clk, .enable);
endmodule

// 64 bit DFF
module DFF64(q, d, reset, clk, enable);
	output logic [63:0] q;
	input logic [63:0] d;
	input logic clk, reset, enable;
	
	DFF32 dff1 (.q(q[31:0]),  .d(d[31:0]),  .reset, .clk, .enable);
	DFF32 dff2 (.q(q[63:32]), .d(d[63:32]), .reset, .clk, .enable);
endmodule

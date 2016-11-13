`timescale 1ns/10ps

// Several different muxes

// Mux 2 to 1, 1 bit input.
module mux_2to1_1bit(out, control, in);
	input logic control;
	input logic [1:0] in;
	output logic out;
	
	logic con_not, and0_out, and1_out;
	
	not #50 not0 (con_not, control);
	and #50 and0 (and0_out, in[0], con_not);
	and #50 and1 (and1_out, in[1], control);
	or #50 or0 (out, and0_out, and1_out);

endmodule

// Mux 2 to 1, 64-bit input
module mux_2to1(out, control, in);
	output logic [63:0] out;
	input logic [63:0] in [1:0];
	input logic control;
	
	genvar i;
	generate
		for(i=0; i < 64; i++) begin: mux2to1_64bit
			logic con_not;
			logic [63:0] and0_out, and1_out;
		
			not #50 not0 (con_not, control);
			and #50 and0 (and0_out[i], in[0][i], con_not);
			and #50 and1 (and1_out[i], in[1][i], control);
			or #50 or0 (out[i], and0_out[i], and1_out[i]);
		end
	endgenerate
	
endmodule

// Mux 2 to 1 5-bits
module mux_2to1_5bit(out, control, in);
	output logic [4:0] out;
	input logic [4:0] in [1:0];
	input logic control;
	
	genvar i;
	generate
		for(i=0; i < 5; i++) begin: mux2to1_64bit
			logic con_not;
			logic [4:0] and0_out, and1_out;
		
			not #50 not0 (con_not, control);
			and #50 and0 (and0_out[i], in[0][i], con_not);
			and #50 and1 (and1_out[i], in[1][i], control);
			or #50 or0 (out[i], and0_out[i], and1_out[i]);
		end
	endgenerate
	
endmodule

// Mux 4 to 1, 64-bit input
module mux_4to1(out, control, in);
	output logic [63:0] out;
	input logic [63:0] in [3:0];
	input logic [1:0] control;
	
	logic [63:0] out_mux [1:0];
	
	mux_2to1 mux0 (.out(out_mux[0]), .control(control[0]), .in(in[1:0]));
	mux_2to1 mux1 (.out(out_mux[1]), .control(control[0]), .in(in[3:2]));
	mux_2to1 mux2 (.out, .control(control[1]), .in(out_mux));
endmodule

// Mux 8 to 1, 64-bit input
module mux_8to1(out, control, in);
	output logic [63:0] out;
	input logic [63:0] in [7:0];
	input logic [2:0] control;
	
	logic [63:0] mux_out [1:0];
	
	mux_4to1 m0 (.out(mux_out[0]), .control(control[1:0]), .in(in[3:0]));
	mux_4to1 m1 (.out(mux_out[1]), .control(control[1:0]), .in(in[7:4]));
	mux_2to1 m2 (.out, .control(control[2]), .in(mux_out));
endmodule


// Mux 16 to 1, 64-bit input
module mux_16to1(out, control, in);
	output logic [63:0] out;
	input logic [63:0] in [15:0];
	input logic [3:0] control;
	
	logic [63:0] out_mux [3:0];
	
	mux_4to1 mux0 (.out(out_mux[0]), .control(control[1:0]), .in(in[3:0]));
	mux_4to1 mux1 (.out(out_mux[1]), .control(control[1:0]), .in(in[7:4]));
	mux_4to1 mux2 (.out(out_mux[2]), .control(control[1:0]), .in(in[11:8]));
	mux_4to1 mux3 (.out(out_mux[3]), .control(control[1:0]), .in(in[15:12]));
	mux_4to1 mux4 (.out, .control(control[3:2]), .in(out_mux));
endmodule

// Mux 32 to 1, 64-bit input
module mux_32to1(out, control, in);
	output logic [63:0] out;
	input logic [63:0] in [31:0];
	input logic [4:0] control;

	logic [63:0] out_mux [1:0];

	mux_16to1 mux0 (.out(out_mux[0]), .control(control[3:0]), .in(in[15:0]));
	mux_16to1 mux1 (.out(out_mux[1]), .control(control[3:0]), .in(in[31:16]));
	mux_2to1 mux2 (.out, .control(control[4]), .in(out_mux));

endmodule


module mux_testbench();
	logic [63:0] out;
	logic [63:0] in [7:0];
	logic [2:0] control;
	
	mux_8to1 dut (.out, .control, .in);
	integer i, j;
	initial begin
		#1000;
		for (j = 0; j < 8; j++) begin
			in[j] = j;
		end
		#1000;
		for (i = 0; i < 8; i++) begin
			control = i; #1000;
		end
	end
endmodule

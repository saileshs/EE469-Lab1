`timescale 1ns/10ps
module regfile (ReadData1, ReadData2, ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, clk);
	output logic [63:0] ReadData1, ReadData2;
	input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input logic [63:0] WriteData;
	input logic RegWrite, clk;
	logic [63:0] registerOutput [31:0];
	logic [31:0] enableRegister;
	logic reset; // Do we need this??
	
	decoder_5to32 WriteRegisterister (.out(enableRegister), .in(WriteRegister), .RegWrite);
	
	genvar i;
	generate
		for(i=0; i < 32; i++) begin : eachRegister
			DFF64 register (.q(registerOutput[i]), .d(WriteData), .reset, .clk, .enable(enableRegister[i]));
		end
	endgenerate
	
	mux_32to1 readRegister1 (.out(ReadData1), .readReg(ReadRegister1), .in(registerOutput));
	mux_32to1 readRegister2 (.out(ReadData2), .readReg(ReadRegister2), .in(registerOutput));
	
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

module decoder_2to4(out, in, enable);
	output logic [3:0] out;
	input logic [1:0] in;
	input logic enable;
	
	logic in0_not, in1_not;
	
	not #50 not1 (in0_not, in[0]);
	not #50 not2 (in1_not, in[1]);
	
	and #50 and0 (out[0], in0_not, in1_not);
	and #50 and1 (out[1], in[0], in1_not);
	and #50 and2 (out[2], in[1], in0_not);
	and #50 and3 (out[3], in[0], in[1]);
	
endmodule
 
module decoder_3to8(out, in, enable);
	output logic [7:0] out;
	input logic [2:0] in;
	input logic enable;
	
	logic in0_not, in1_not, in2_not;
	
	not #50 n0 (in0_not, in[0]);
	not #50 n1 (in1_not, in[1]);
	not #50 n2 (in2_not, in[2]);
	
	and #50 and0 (out[0], in0_not, in1_not, in2_not);
	and #50 and1 (out[1], in[0], in1_not, in2_not);
	and #50 and2 (out[2], in0_not, in[1], in2_not);
	and #50 and3 (out[3], in[0], in[1], in2_not);
	and #50 and4 (out[4], in0_not, in1_not, in[2]);
	and #50 and5 (out[5], in[0], in1_not, in[2]);
	and #50 and6 (out[6], in0_not, in[1], in[2]);
	and #50 and7 (out[7], in[0], in[1], in[2]);
	
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
	
module mux_4to1(out, control, in);
	output logic [63:0] out;
	input logic [63:0] in [3:0];
	input logic [1:0] control;
	
	genvar i;
	generate
		for(i=0; i<64; i++) begin : each64bit4to1Mux
			logic con0_not, con1_not;
			logic [3:0] temp;
			
			not #50 n0 (con0_not, control[0]);
			not #50 n1 (con1_not, control[1]);
			
			and #50 and0 (temp[0], in[0][i], con0_not, con1_not);
			and #50 and1 (temp[1], in[1][i], control[0], con1_not);
			and #50 and2 (temp[2], in[2][i], con0_not, control[1]);
			and #50 and3 (temp[3], in[3][i], control[0], control[1]);
			
			or #50 or0 (out[i], temp[0], temp[1], temp[2], temp[3]);
		end
	endgenerate 
	
	
	
endmodule


module mux_16to1(out, control, in);
	output logic [63:0] out;
	input logic [63:0] in [15:0];
	input logic [3:0] control;
	
	logic [63:0] temp [3:0];
	
	mux_4to1 mux0 (.out(temp[0]), .control(control[3:2]), .in(in[15:12]));
	mux_4to1 mux1 (.out(temp[1]), .control(control[3:2]), .in(in[11:8]));
	mux_4to1 mux2 (.out(temp[2]), .control(control[3:2]), .in(in[7:4]));
	mux_4to1 mux3 (.out(temp[3]), .control(control[3:2]), .in(in[3:0]));
	
	mux_4to1 mux4 (.out, .control(control[1:0]), .in(temp));
	
endmodule

module mux_32to1(out, readReg, in);
	output logic [63:0] out;
	input logic [63:0] in [31:0];
	input logic [4:0] readReg;
	
	logic [63:0] temp [1:0];
	logic readRegNot;
	
	
	logic [63:0] temp1 [3:0];
	assign temp1[0] = temp[0];
	assign temp1[1] = temp[1];
	assign temp1[2] = 64'b0;
	assign temp1[3] = 64'b0;
	
	
	mux_16to1 mux0 (.out(temp[0]), .control(readReg[4:1]), .in(in[31:16]));
	mux_16to1 mux1 (.out(temp[1]), .control(readReg[4:1]), .in(in[15:0]));
	
	mux_4to1 mux2 (.out, .control({1'b0, readReg[0]}), .in(temp1));
	

endmodule

module regstim(); 		

	parameter ClockDelay = 5000;

	logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	logic [63:0]	WriteData;
	logic 			RegWrite, clk;
	logic [63:0]	ReadData1, ReadData2;

	integer i;

	// Your register file MUST be named "regfile".
	// Also you must make sure that the port declarations
	// match up with the module instance in this stimulus file.
	regfile dut (.ReadData1, .ReadData2, .WriteData, 
					 .ReadRegister1, .ReadRegister2, .WriteRegister,
					 .RegWrite, .clk);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

	initial begin
		// Try to write the value 0xA0 into register 31.
		// Register 31 should always be at the value of 0.
		RegWrite <= 5'd0;
		ReadRegister1 <= 5'd0;
		ReadRegister2 <= 5'd0;
		WriteRegister <= 5'd31;
		WriteData <= 64'h00000000000000A0;
		@(posedge clk);
		
		$display("%t Attempting overwrite of register 31, which should always be 0", $time);
		RegWrite <= 1;
		@(posedge clk);

		// Write a value into each  register.
		$display("%t Writing pattern to all registers.", $time);
		for (i=0; i<31; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000010204080001;
			@(posedge clk);
			
			RegWrite <= 1;
			@(posedge clk);
		end

		// Go back and verify that the registers
		// retained the data.
		$display("%t Checking pattern.", $time);
		for (i=0; i<32; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000000000000100+i;
			@(posedge clk);
		end
		$stop;
	end
endmodule

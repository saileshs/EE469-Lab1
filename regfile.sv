`timescale 1ns/10ps

//32x64-bit Regfile: Takes in one register to write to and two registers to read from. Register 31 is reserved
// as 64'b0 and cannot be written to.
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
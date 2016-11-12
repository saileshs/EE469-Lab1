`timescale 1ns/10ps

module controlUnit(reg2loc, aluSrc, memToReg, regWrite, 
						 memWrite, brTaken, uncondBr, aluOp, 
						 xThirtyWrite, brCtrl, opCode);

	// To Store the 11-bit OpCode 
	input[31:21] opCode;

	// Control Signals for the datapath
	output logic reg2loc, memToReg, regWrite, memWrite, 
					 uncondBr, xThirtyWrite, brCtrl;
	output logic [1:0] aluSrc;
	output logic [1:0] brTaken;
	output logic [2:0] aluOp;
	
	parameter [31:21] ADD = 11'b10001011000, SUB = 11'b11001011000,
							LDUR = 11'b11111000010, STUR = 11'b11111000000,
							B = 11'b000101xxxxx, CBZ = 11'b10110100xxx,
							ADDI = 11'b1001000100x, ADDS = 11'b10101011000,
							BL = 11'b100101xxxxx, BR = 11'b11010110000,
							SUBS = 11'b11101011000;
							
	
	logic [13:0] controlSignals;
	
	// controlSignals contains the following signals:
	// (13)reg2loc, (12)memToReg, (11)RegWrite, (10)memWrite, 
	// (9)unCondBr, (8)xThirtyWrite, (7)brCtrl, (6)aluSrc[1], 
	// (5)aluSrc[0], (4)brTaken[1], (3)brTaken[0], (2)aluOp[2], 
	// (1)aluOp[1], (0)aluOp[0]
	
	always_comb begin
		case (opCode)
				
				ADD : controlSignals = 14'b1010x000000010;
				
				SUB : controlSignals = 14'b1010x000000011;
				
				LDUR : controlSignals = 14'bx110x000100010;
				
				STUR : controlSignals = 14'b0x01x000100010;
				
				B : controlSignals = 14'bxx0010?xx01xxx;
				
				CBZ : controlSignals = 14'b0x0000000??000;
				
				ADDI : controlSignals = 14'bx010x001000010;
				
				ADDS : controlSignals = 14'b1010x000000010;
				
				// X30write = 1
				BL : controlSignals = 14'b;
				
				BR : controlSignals = 14'b0x00x00xx10xxx;
				
				SUBS : controlSignals = 14'b1010x000000011;
				
				default : controlSignals = 14'bxxxxxxxxxx;
				
		endcase
	end
	
	assign reg2loc = controlSignals[13];
	assign memToReg = controlSignals[12];
	assign regWrite = controlSignals[11];
	assign memWrite = controlSignals[10];
	assign unCondBr = controlSignals[9];
	assign xThirtyWrite = controlSignal[8];
	assign brCtrl = controlSignal[7];
	assign aluSrc = controlSignals[6:5];
	assign brTaken = controlSignals[4:3];
	assign aluOp = controlSignals[2:0];
	
endmodule

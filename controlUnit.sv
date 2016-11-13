`timescale 1ns/10ps

module controlUnit(Reg2Loc, ALUSrc, MemToReg, RegWrite, 
						 MemWrite, BrTaken, UncondBr, ALUOp, 
						 xThirtyWrite, BrCtrl, OpCode);

	// To Store the 11-bit OpCode 
	input[31:21] OpCode;

	// Control Signals for the datapath
	output logic Reg2Loc, MemToReg, RegWrite, MemWrite, 
					 UncondBr, xThirtyWrite, BrCtrl;
	output logic [1:0] ALUSrc;
	output logic [1:0] BrTaken;
	output logic [2:0] ALUOp;
	
	parameter [31:21] LDUR = 11'b11111000010, STUR = 11'b11111000000,
							B = 11'b000101xxxxx, CBZ = 11'b10110100xxx,
							ADDI = 11'b1001000100x, ADDS = 11'b10101011000,
							BL = 11'b100101xxxxx, BR = 11'b11010110000,
							SUBS = 11'b11101011000;
							
	
	logic [13:0] controlSignals;
	
	// controlSignals contains the following signals:
	// (13)Reg2Loc, (12)MemToReg, (11)RegWrite, (10)MemWrite, 
	// (9)UncondBr, (8)xThirtyWrite, (7)BrCtrl, (6)ALUSrc[1], 
	// (5)ALUSrc[0], (4)BrTaken[1], (3)BrTaken[0], (2)ALUOp[2], 
	// (1)ALUOp[1], (0)ALUOp[0]
	
	always_comb begin
		case (OpCode)
				
				LDUR : controlSignals = 14'bx110x000100010;
				
				STUR : controlSignals = 14'b0x01x000100010;
				
				B : controlSignals = 14'bxx001xxxx01xxx;
				
				CBZ : controlSignals = 14'b0x0000000xx000;
				
				ADDI : controlSignals = 14'bx010x001000010;
				
				ADDS : controlSignals = 14'b1010x000000010;
				
				// X30write = 1
				BL : controlSignals = 14'bxx10111xx01xxx;
				
				BR : controlSignals = 14'b0x00x00xx10xxx;
				
				SUBS : controlSignals = 14'b1010x000000011;
				
				default : controlSignals = 14'bxxxxxxxxxxxxxx;
				
		endcase
	end
	
	assign Reg2Loc = controlSignals[13];
	assign MemToReg = controlSignals[12];
	assign RegWrite = controlSignals[11];
	assign MemWrite = controlSignals[10];
	assign UncondBr = controlSignals[9];
	assign xThirtyWrite = controlSignals[8];
	assign BrCtrl = controlSignals[7];
	assign ALUSrc = controlSignals[6:5];
	assign BrTaken = controlSignals[4:3];
	assign ALUOp = controlSignals[2:0];
	
endmodule

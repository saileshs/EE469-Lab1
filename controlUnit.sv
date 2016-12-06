`timescale 1ns/10ps

module controlUnit(Reg2Loc, ALUSrc, MemToReg, RegWrite, 
						 MemWrite, BrTaken, UncondBr, ALUOp, 
						 X30Write, opCode, negativeFlag, zeroFlag, overflowFlag);

	// To Store the 11-bit opCode 
	input logic [31:21] opCode;

	// ALU Flags
	input logic negativeFlag, zeroFlag, overflowFlag;

	// Control Signals for the datapath
	output logic Reg2Loc, MemToReg, RegWrite, MemWrite, 
					 UncondBr, X30Write;
	output logic [1:0] ALUSrc;
	output logic [1:0] BrTaken;
	output logic [2:0] ALUOp;
	
	parameter [31:21] LDUR = 11'b11111000010, STUR = 11'b11111000000,
							B = 11'b000101xxxxx, CBZ = 11'b10110100xxx,
							ADDI = 11'b1001000100x, ADDS = 11'b10101011000,
							BL = 11'b100101xxxxx, BR = 11'b11010110000,
							SUBS = 11'b11101011000, BCOND = 11'b01010100xxx;
							
	
	logic [12:0] controlSignals;

	logic BLTLogic;
	assign BLTLogic = negativeFlag ^ overflowFlag;
	
	// controlSignals contains the following signals:
	// (13)Reg2Loc, (12)MemToReg, (11)RegWrite, (10)MemWrite, 
	// (9)UncondBr, (8)X30Write, (7)BLCtrl, (6)ALUSrc[1], 
	// (5)ALUSrc[0], (4)BrTaken[1], (3)BrTaken[0], (2)ALUOp[2], 
	// (1)ALUOp[1], (0)ALUOp[0]
	
	always_comb begin
		casex (opCode)
				
				LDUR : controlSignals = 13'bx110x00100010;
				
				STUR : controlSignals = 13'b0x01x00100010;
				
				B : controlSignals = 13'bxx001xxx01xxx;
				
				CBZ : begin 
						controlSignals = 13'b0x0000000x000;
						controlSignals[3] = zeroFlag;
					end
				
				ADDI : controlSignals = 13'bx010x01000010;
				
				ADDS : controlSignals = 13'b1010x00000010;

				BL : controlSignals = 13'bx010111101000;
				
				BR : controlSignals = 13'b0x00x0xx10xxx;
				
				SUBS : controlSignals = 13'b1010x00000011;

				BCOND : begin 
							controlSignals = 13'b0x0000000xxxx;
							controlSignals[3] = BLTLogic;
						end
				
				default : controlSignals = 13'bxx00xxxx00xxx;
				
		endcase
	end
	
	assign Reg2Loc = controlSignals[12];
	assign MemToReg = controlSignals[11];
	assign RegWrite = controlSignals[10];
	assign MemWrite = controlSignals[9];
	assign UncondBr = controlSignals[8];
	assign X30Write = controlSignals[7];
	assign ALUSrc = controlSignals[6:5];
	assign BrTaken = controlSignals[4:3];
	assign ALUOp = controlSignals[2:0];

endmodule

module controlUnit_testbench();
	logic [31:21] opCode;
	logic negativeFlag, zeroFlag, overflowFlag;
	logic Reg2Loc, MemToReg, RegWrite, MemWrite, UncondBr, X30Write, BLCtrl;
	logic [1:0] ALUSrc;
	logic [1:0] BrTaken;
	logic [2:0] ALUOp;
	
	controlUnit dut (Reg2Loc, ALUSrc, MemToReg, RegWrite, MemWrite, BrTaken, UncondBr, ALUOp, X30Write, BLCtrl, opCode, negativeFlag, zeroFlag, overflowFlag);
	
	initial begin
		negativeFlag = 0; zeroFlag = 0; overflowFlag = 0;
		
		// Test LDUR
		opCode = 11'b11111000010;
		#200;
		//assert(Reg2Loc == 1'bx && X30Write == 1'b0 && RegWrite == 1'b1 && ALUSrc == 2'b01 && ALUOp == 3'b010 && 
			//	MemWrite == 1'b0 && MemToReg == 1'b1 && BLCtrl == 1'b0 && BrTaken == 2'b00 && UncondBr == 1'bx);
			
		// Test STUR
		opCode = 11'b11111000000;
		#200;
		
		// Test BL
		opCode = 11'b100101xxxxx;
		#200;
		
		// Test CBZ with zeroFlag = 0
		opCode = 11'b10110100xxx;
		#200;
		
		// Test CBZ with zeroFlag = 1
		zeroFlag = 1'b1;
		#200;
		zeroFlag = 1'b0;
		
		// Test B.LT when overflowFlag == negativeFLag
		opCode = 11'b01010100xxx;
		#200;
		
		// Test B.LT when overflowFlag != negativeFLag
		overflowFlag = 1'b1;
		#200;
		

	end
endmodule

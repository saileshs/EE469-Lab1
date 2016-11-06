`timescale 1ns/10ps

module controlUnit(reg2loc, aluSrc, memToReg, regWrite, memWrite, brTaken, uncondBr, aluOp, opCode);

	// To Store the 11-bit OpCode 
	input[31:21] opCode;

	// Control Signals for the datapath
	output logic reg2loc, aluSrc, memToReg, regWrite, memWrite, brTaken, uncondBr;
	output logic [2:0] aluOp;
	
	parameter [31:21] ADD = 11'b10001011000, SUB = 11'b11001011000,
							LDUR = 11'b11111000010, STUR = 11'b11111000000,
							B = 11'b000101xxxxx, CBZ = 11'b10110100xxx;
	
	logic [9:0] controlSignals;
	
	always_comb begin
		case (opCode)
				
				ADD : controlSignals = 10'b100100x010;
				
				SUB : controlSignals = 10'b100100x011;
				
				LDUR : controlSignals = 10'bx11100x010;
				
				STUR : controlSignals = 10'b01x010x010;
				
				B : controlSignals = 10'bxxx0011xxx;
				
				CBZ : controlSignals = 10'b00x0000000;
				
				default : controlSignals = 10'bxxxxxxxxxx;
				
		endcase
	end
	
	assign reg2loc = controlSignals[9];
	assign aluSrc = controlSignals[8];
	assign memToReg = controlSignals[7];
	assign regWrite = controlSignals[6];
	assign memWrite = controlSignals[5];
	assign brTaken = controlSignals[4];
	assign unCondBr = controlSignals[3];
	assign aluOp = controlSignals[2:0];
	
endmodule

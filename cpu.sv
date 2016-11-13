`timescale 1ns/10ps
module cpu ();
	logic [4:0] chooseWriteReg [1:0]; // for X30Write mux (for BR instruction)
	logic [4:0] X30MuxOut;

	// Control Logic
	logic Reg2Loc, RegWrite, MemWrite, MemToReg, UncondBr, X30Write, BLCtrl;
	logic [1:0] ALUSrc, BrTaken;
	logic [2:0] ALUOp;
	
	logic clk, reset, negativeFlag, zeroFlag, overflowFlag, carryOutFlag;
	logic overflow1, overflow2, carryout1, carryout2; // Output flags from adders
	logic [63:0] ReadData1, ReadData2, WriteData, ReadRegister, ALUOut, DataMemOut, PCInput, uncondBrOut, brShifterOut, memToRegOut, ALUMuxOut;
	logic [63:0] address = 64'b0;
	logic [63:0] RegRmRd [1:0]; // For Reg2Loc mux
	logic [63:0] ALUOrMemOut [1:0]; // For MemToReg mux
	logic [63:0] WhichBranch [3:0]; // For BrTaken mux
	logic [63:0] ALUMuxIn [3:0]; // For ALUSrc mux
	logic [31:0] instruction; // 32-bit instruction coming out of Instruction Memory
	logic [10:0] opCode = instruction[31:21];
	logic [4:0] Rd = instruction[4:0];
	logic [4:0] Rm = instruction[20:16];
	logic [4:0] Rn = instruction[9:5];
	logic [11:0] imm12 = instruction[21: 10]; // For ADDI
	logic [63:0] branchImmediates [1:0]; // For UncondBr branch
	logic [63:0] WhichWriteData [1:0]; // For BL instruction. BLCtrl mux.
	
	// Logic selecting whether to read data from Rd or Rm 
	assign RegRmRd[0] = Rd;
	assign RegRmRd[1] = Rm;
	
	mux_2to1 reg_mux (.out(ReadRegister), .control(Reg2Loc), .in(RegRmRd));

	assign chooseWriteReg[0] = Rd;
	assign chooseWriteReg[1] = 5'b11110; // X30 register for BL instruction
	assign WhichWriteData[0] = memToRegOut;
	assign WhichWriteData[1] = WhichBranch[0];
	mux_2to1 x30_write_mux (.out(X30MuxOut), .control(X30Write), .in(chooseWriteReg)); // Choosing between Rd and X30 for Write Register
	mux_2to1 BL_mux (.out(WriteData), .control(BLCtrl), .in(WhichWriteData)); // Choosing which data to write to register
	
	// Calling the RegFile to access data and write data to registers.
	regfile rf (.ReadData1, .ReadData2, .ReadRegister1(Rn), .ReadRegister2(ReadRegister), .WriteRegister(X30MuxOut), .WriteData, .RegWrite, .clk);
	
	// Calling ALU unit for arithmetic operations and setting flags.
	alu a (.A(ReadData1), .B(ALUMuxOut), .cntrl(ALUOp), .result(ALUOut), .negative(negativeFlag), .zero(zeroFlag), .overflow(overflowFlag), .carry_out(carryOutFlag));
	
	// Calling Data Memory unit to store to and read from memory.
	datamem memory (.address(ALUOut), .write_enable(MemWrite), .read_enable(MemToReg), .write_data(ReadData2), .clk, .xfer_size(4'd8), .read_data(DataMemOut));
	
	// Logic selecting whether to read data from ALUOut or DataMemOut
	assign ALUOrMemOut[0] = ALUOut;
	assign ALUOrMemOut[1] = DataMemOut;
	
	mux_2to1 mem_mux (.out(memToRegOut), .control(MemToReg), .in(ALUOrMemOut));
	
	// ALUSrc Datapath
	SE extend_imm9 (.out(ALUMuxIn[1]), .in(instruction));
	ZE extend_imm12 (.out(ALUMuxIn[2]), .in(imm12)); // For ADDI
	assign ALUMuxIn[0] = ReadData2;
	assign ALUMuxIn[3] = 64'bx;

	mux_4to1 alu_mux (.out(ALUMuxOut), .control(ALUOp), .in(ALUMuxIn));
	
	// Program counter calculates address of next instruction.
	PC program_counter (.out(address), .in(PCInput), .reset, .clk);
	
	instructmem instruction_memory (.address, .instruction, .clk);

	controlUnit control (.Reg2Loc, .ALUSrc, .MemToReg, .RegWrite, .MemWrite, .BrTaken, .UncondBr, .ALUOp, .X30Write, .BLCtrl, .opCode, .negativeFlag, .zeroFlag, .overflowFlag);
	
	// Compute BrTaken mux input 0
	addSub64 pcPlus4 (.carryOut(carryout1), .result(WhichBranch[0]), .overflow(overflow1), .a(address), .b(64'd4), .carryIn(1'b0));
	
	// Compute BrTaken mux input 1
	SE extend_imm19 (.out(branchImmediates[0]), .in(instruction));
	SE extend_imm26 (.out(branchImmediates[1]), .in(instruction));
	mux_2to1 uncondbr_mux (.out(uncondBrOut), .control(UncondBr), .in(branchImmediates));
	shifter shift_imm (.out(brShifterOut), .in(uncondBrOut));
	addSub64 branch_imm_adder (.carryOut(carryout2), .result(WhichBranch[1]), .overflow(overflow2), .a(address), .b(brShifterOut), .carryIn(1'b0));
	
	assign WhichBranch[2] = ReadData2; // For BR instruction
	assign WhichBranch[3] = 64'bx;

	mux_4to1 brtaken_mux (.out(PCInput), .control(BrTaken), .in(WhichBranch));

endmodule

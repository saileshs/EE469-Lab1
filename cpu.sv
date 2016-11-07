module cpu (Rd, Rm, Rn, RegWrite, Reg2Loc, ALUSrc, ALUOp, MemWrite, MemToReg, BrTaken);
	input logic Reg2Loc, RegWrite, ALUSrc, ALUOp, MemWrite, MemToReg, BrTaken;
	input logic [63:0] Rd, Rm, Rn;
	
	logic clk, reset, negativeFlag, zeroFlag, overflowFlag, carryOutFlag;
	logic overflow1, overflow2, carryout1, carryout2; // Output flags from adders
	logic [63:0] ReadData1, ReadData2, WriteData, ReadRegister, ALUOut, DataMemOut, address, PCInput;
	logic [63:0] RegRmRd [1:0]; // For Reg2Loc mux
	logic [63:0] ALUOrMemOut [1:0]; // For MemToReg mux
	logic [63:0] WhichBranch [1:0]; // For BrTaken mux
	logic [31:0] instruction; // 32-bit instruction coming out of Instruction Memory
	
	// Logic selecting whether to read data from Rd or Rm 
	assign RegRmRd[0] = Rd;
	assign RegRmRd[1] = Rm;
	
	mux_2to1 reg_mux (.out(ReadRegister), .control(Reg2Loc), .in(RegRmRd));
	
	// Calling the RegFile to access data and write data to registers.
	regfile rf (.ReadData1, .ReadData2, .ReadRegister1(Rn), .ReadRegister2(ReadRegister), .WriteRegister(Rd), .WriteData, .RegWrite, .clk);
	
	// Calling ALU unit for arithmetic operations and setting flags.
	alu a (.A(ReadData1), .B(ReadData2), .cntrl(ALUOp), .result(ALUOut), .negative(negativeFlag), .zero(zeroFlag), .overflow(overflowFlag), .carry_out(carryOutFlag));
	
	// Calling Data Memory unit to store to and read from memory.
	datamem memory (.address(ALUOut), .write_enable(MemWrite), .read_enable(MemToReg), .write_data(ReadData2), .clk, .xfer_size(4'd8), .read_data(DataMemOut));
	
	// Logic selecting whether to read data from ALUOut or DataMemOut
	assign ALUOrMemOut[0] = ALUOut;
	assign ALUOrMemOut[1] = DataMemOut;
	
	mux_2to1 mem_mux (.out(WriteData), .control(MemToReg), .in(ALUOrMemOut));
	
	// Still need to write logic for DAddr9 with SE to ALUSrc
	
	// Program counter calculates address of next instruction.
	PC program_counter (.out(address), .in(PCInput), .reset, .clk);
	
	instructmem instruction_memory (.address, .instruction, .clk);
	
	addSub64 adder (.carryOut(carryout1), .result(WhichBranch[0]), .overflow(overflow1), .a(address), .b(64'd4), .carryIn(1'b0))
	
	mux_2to1 brtaken_mux (.out(PCInput), .control(BrTaken), .in(WhichBranch));
	
	
endmodule

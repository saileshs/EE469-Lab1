`define XFER_SIZE 4'd8 // Set data memory transfer size to 8 bytes.

`timescale 1ns/10ps
module cpu_pipelined (clk, reset);
	input logic clk, reset;
	logic [4:0] chooseWriteReg [1:0]; // for X30Write mux (for BR instruction)
	logic [4:0] ReadRegister, X30MuxOut;

	// Control Logic
	logic Reg2Loc, RegWrite, MemWrite, MemToReg, UncondBr, X30Write, BLCtrl, SetFlag;
	logic [1:0] ALUSrc, BrTaken;
	logic [2:0] ALUOp;
	
	logic negativeFlag, zeroFlag, overflowFlag, carryOutFlag, negativeFlagTemp, zeroFlagTemp, CBZZeroFlag, overflowFlagTemp, carryOutFlagTemp;
	logic overflow1, overflow2, carryout1, carryout2; // Output flags from adders
	logic [63:0] ReadData1, ReadData2, WriteData, ALUOut, DataMemOut, PCInput, uncondBrOut, brShifterOut, memToRegOut, ALUMuxOut;
	logic [63:0] address;
	logic [4:0] RegRmRd [1:0]; // For Reg2Loc mux
	logic [63:0] ALUOrMemOut [1:0]; // For MemToReg mux
	logic [63:0] WhichBranch [3:0]; // For BrTaken mux
	logic [63:0] ALUMuxIn [3:0]; // For ALUSrc mux
	logic [31:0] instruction; // 32-bit instruction coming out of Instruction Memory
	wire [10:0] opCode;
	wire [4:0] Rd, Rm, Rn;
	wire [11:0] imm12; // For ADDI
	logic [63:0] SEImm9, ZEImm12, shiftedAddedBranchAddr;
	logic [63:0] branchImmediates [1:0]; // For UncondBr branch
	logic [63:0] WhichWriteData [1:0]; // For BL instruction. BLCtrl mux.

	// Datapath Wires coming out of the pipeline registers
	logic [63:0]	IFID_pc_out, IFID_pc_plus4_out, IDEX_pc_out, IDEX_se_imm12_out, IDEX_se_imm9_out, 
					IDEX_se_branch_out, IDEX_read_data1_out, IDEX_read_data2_out, EXMEM_branch_out, 
					EXMEM_data2_out, EXMEM_alu_out, MEMWR_alu_out, MEMWR_data_mem_out; 
	logic [31:0] IFID_instr_out;
	logic [4:0] IDEX_rn_out, IDEX_rm_out, IDEX_rd_out, EXMEM_rd_out, MEMWR_rd_out;

	// Control wires coming out of the pipeline registers
	logic [1:0] IDEX_ALUSrc;
	logic [2:0] IDEX_ALUOp;
	logic 	IDEX_MemWrite, IDEX_MemToReg, IDEX_RegWrite, IDEX_SetFlags, EXMEM_MemWrite, EXMEM_MemToReg, EXMEM_RegWrite,
			MEMWR_MemToReg, MEMWR_RegWrite;

	// Forwarding Logic
	logic [63:0] ForwardingMux1 [3:0];
	logic [63:0] ForwardingMux2 [3:0];
	logic [63:0] ALU_input_a;

	
	// Logic selecting whether to read data from Rd or Rm 
	assign RegRmRd[0] = Rd;
	assign RegRmRd[1] = Rm;
	
	mux_2to1_5bit reg_mux (.out(ReadRegister), .control(Reg2Loc), .in(RegRmRd));

	assign chooseWriteReg[0] = MEMWR_rd_out;
	assign chooseWriteReg[1] = 5'b11110; // X30 register for BL instruction
	assign WhichWriteData[0] = memToRegOut;
	assign WhichWriteData[1] = IFID_pc_plus4_out;
	mux_2to1_5bit x30_write_mux (.out(X30MuxOut), .control(X30Write), .in(chooseWriteReg)); // Choosing between Rd and X30 for Write Register
	mux_2to1 BL_mux (.out(WriteData), .control(BLCtrl), .in(WhichWriteData)); // Choosing which data to write to register
	
	// Calling the RegFile to access data and write data to registers.
	// Given negation of clk in order to avoid reading old values in register.
	regfile rf (.ReadData1, .ReadData2, .ReadRegister1(Rn), .ReadRegister2(ReadRegister), .WriteRegister(X30MuxOut), .WriteData, .RegWrite(MEMWR_RegWrite), .clk(~clk));
	
	// Select signals for controling the Forwarding Mux A and Forwarding Mux B.
	logic [1:0] forwardA;
	logic [1:0] forwardB;
	
	// Calling the FORWARDING UNIT to handle EX hazards and Mem Hazards.
	// Returns two 2-bit select signals, which control the ForwardingMux1 and ForwardingMux2.
	FORWARDING_UNIT forward (.forward_A(forwardA), .forward_B(forwardB), .rn_in(IDEX_rn_out), .rm_in(IDEX_rm_out), .EXMEM_RegisterRd(EXMEM_rd_out), .MEMWR_RegisterRd(MEMWR_rd_out), .EXMEM_RegWrite(EXMEM_RegWrite), .MEMWR_RegWrite(MEMWR_RegWrite));
	
	// Forwarding Data Path
	assign ForwardingMux1[0] = IDEX_read_data1_out;
	assign ForwardingMux1[1] = memToRegOut;
	assign ForwardingMux1[2] = EXMEM_alu_out;
	assign ForwardingMux1[3] = 64'bX;
	mux_4to1 forwarding_mux1 (.out(ALU_input_a), .control(forwardA), .in(ForwardingMux1));

	assign ForwardingMux2[0] = IDEX_read_data2_out;
	assign ForwardingMux2[1] = memToRegOut;
	assign ForwardingMux2[2] = EXMEM_alu_out;
	assign ForwardingMux2[3] = 64'bX;
	mux_4to1 forwarding_mux2 (.out(ALUMuxIn[0]), .control(forwardB), .in(ForwardingMux2));

	// Calling ALU unit for arithmetic operations
	alu a (.A(ALU_input_a), .B(ALUMuxOut), .cntrl(IDEX_ALUOp), .result(ALUOut), .negative(negativeFlagTemp), .zero(zeroFlagTemp), .overflow(overflowFlagTemp), .carry_out(carryOutFlagTemp));
	
	// Setting ALU flags if necessary
	
	DFF1_enable neg_flag_dff (.q(negativeFlag), .d(negativeFlagTemp), .reset, .clk, .enable(IDEX_SetFlags));
	DFF1_enable zero_flag_dff (.q(zeroFlag), .d(zeroFlagTemp), .reset, .clk, .enable(IDEX_SetFlags));
	DFF1_enable overflow_flag_dff (.q(overflowFlag), .d(overflowFlagTemp), .reset, .clk, .enable(IDEX_SetFlags));
	DFF1_enable carryOut_flag_dff (.q(carryOutFlag), .d(carryOutFlagTemp), .reset, .clk, .enable(IDEX_SetFlags));
	
	// Calling Data Memory unit to store to and read from memory.
	datamem memory (.address(EXMEM_alu_out), .write_enable(EXMEM_MemWrite), .read_enable(EXMEM_MemToReg), .write_data(EXMEM_data2_out), .clk, .xfer_size(`XFER_SIZE), .read_data(DataMemOut));
	
	// Logic selecting whether to read data from ALUOut or DataMemOut
	assign ALUOrMemOut[0] = MEMWR_alu_out;
	assign ALUOrMemOut[1] = MEMWR_data_mem_out;
	
	mux_2to1 mem_mux (.out(memToRegOut), .control(MEMWR_MemToReg), .in(ALUOrMemOut));
	
	// ALUSrc Datapath
	SE extend_imm9 (.out(SEImm9), .in(IFID_instr_out));
	ZE extend_imm12 (.out(ZEImm12), .in(imm12)); // For ADDI
	// ALUMuxIn[0] is set by the output of forwarding_mux2
	assign ALUMuxIn[1] = IDEX_se_imm9_out;
	assign ALUMuxIn[2] = IDEX_se_imm12_out;
	assign ALUMuxIn[3] = 64'bX;

	mux_4to1 alu_mux (.out(ALUMuxOut), .control(IDEX_ALUSrc), .in(ALUMuxIn));
	
	// Program counter calculates address of next instruction.
	PC program_counter (.out(address), .in(PCInput), .reset, .clk);
	
	instructmem instruction_memory (.address, .instruction, .clk);
	assign opCode = IFID_instr_out[31:21];
	assign Rd = IFID_instr_out[4:0];
	assign Rm = IFID_instr_out[20:16];
	assign Rn = IFID_instr_out[9:5];
	assign imm12 = IFID_instr_out[21:10]; // For ADDI
	
	// Standalone ZeroFlag module -- For CBZ
	nor64 nor0 (.out(CBZZeroFlag), .in(ReadData2));

	controlUnit control (.Reg2Loc, .ALUSrc, .MemToReg, .RegWrite, .MemWrite, .BrTaken, .UncondBr, .ALUOp, .X30Write, .BLCtrl, .SetFlag, .opCode, .negativeFlag, .zeroFlag(CBZZeroFlag), .overflowFlag);
	
	// Compute BrTaken mux input 0
	addSub64 pcPlus4 (.carryOut(carryout1), .result(WhichBranch[0]), .overflow(overflow1), .a(address), .b(64'd4), .carryIn(1'b0));
	
	// Compute BrTaken mux input 1
	SE extend_imm19 (.out(branchImmediates[0]), .in(IFID_instr_out));
	SE extend_imm26 (.out(branchImmediates[1]), .in(IFID_instr_out));
	mux_2to1 uncondbr_mux (.out(uncondBrOut), .control(UncondBr), .in(branchImmediates));
	shifter shift_imm (.out(brShifterOut), .in(IDEX_se_branch_out));
	addSub64 branch_imm_adder (.carryOut(carryout2), .result(shiftedAddedBranchAddr), .overflow(overflow2), .a(IDEX_pc_out), .b(brShifterOut), .carryIn(1'b0));
	
	assign WhichBranch[1] = EXMEM_branch_out;
	assign WhichBranch[2] = IDEX_read_data2_out; // For BR instruction
	assign WhichBranch[3] = 64'bX;

	mux_4to1 brtaken_mux (.out(PCInput), .control(BrTaken), .in(WhichBranch));

	// Pipeline registers breaking up CPU into 5 stages. 
	IF_ID_reg reg1 (.pc_out(IFID_pc_out), .pc_plus4_out(IFID_pc_plus4_out), .instr_out(IFID_instr_out), .pc_in(address), .pc_plus4_in(WhichBranch[0]), .instr_in(instruction), .reset, .clk, .enable(1'b1));
	ID_EX_reg reg2 (.pc_out(IDEX_pc_out), .rn_out(IDEX_rn_out), .rm_out(IDEX_rm_out), .rd_out(IDEX_rd_out), .se_imm12_out(IDEX_se_imm12_out), .se_imm9_out(IDEX_se_imm9_out), .se_branch_out(IDEX_se_branch_out), .read_data1_out(IDEX_read_data1_out), .read_data2_out(IDEX_read_data2_out), .ALUSrc_out(IDEX_ALUSrc), .ALUOp_out(IDEX_ALUOp), .MemWrite_out(IDEX_MemWrite), .MemToReg_out(IDEX_MemToReg), .RegWrite_out(IDEX_RegWrite), .SetFlags_out(IDEX_SetFlags), .pc_in(IFID_pc_out), .rn_in(Rn), .rm_in(Rm), .rd_in(Rd), .se_imm12_in(ZEImm12), .se_imm9_in(SEImm9), .se_branch_in(uncondBrOut), .read_data1_in(ReadData1), .read_data2_in(ReadData2), .ALUSrc_in(ALUSrc), .ALUOp_in(ALUOp), .MemWrite_in(MemWrite), .MemToReg_in(MemToReg), .RegWrite_in(RegWrite), .SetFlags_in(SetFlag), .reset, .clk, .enable(1'b1));
	EX_MEM_reg reg3 (.branch_out(EXMEM_branch_out), .data2_out(EXMEM_data2_out), .alu_out(EXMEM_alu_out), .EXMEM_RegisterRd(EXMEM_rd_out) , .MemWrite_out(EXMEM_MemWrite), .MemToReg_out(EXMEM_MemToReg), .RegWrite_out(EXMEM_RegWrite), .branch_in(shiftedAddedBranchAddr), .data2_in(ALUMuxIn[0]), .rd_in(IDEX_rd_out) , .alu_in(ALUOut), .MemWrite_in(IDEX_MemWrite), .MemToReg_in(IDEX_MemToReg), .RegWrite_in(IDEX_RegWrite), .reset, .clk, .enable(1'b1));
	MEM_WR_reg reg4 (.alu_out(MEMWR_alu_out), .data_mem_out(MEMWR_data_mem_out), .MEMWR_RegisterRd(MEMWR_rd_out), .MemToReg_out(MEMWR_MemToReg), .RegWrite_out(MEMWR_RegWrite), .alu_in(EXMEM_alu_out), .data_mem_in(DataMemOut), .EXMEM_RegisterRd(EXMEM_rd_out), .MemToReg_in(EXMEM_MemToReg), .RegWrite_in(EXMEM_RegWrite), .reset, .clk, .enable(1'b1));

endmodule

module cpu_pipelined_testbench();
	logic clk, reset;
	
	parameter ClockDelay = 100000;
	
	cpu_pipelined dut(clk, reset);
 
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	integer i;
	
	initial // Set up the reset signal
		begin
			reset<=1;	@(posedge clk);
			reset<=0;	@(posedge clk);
			for (i = 0; i < 100; i++)
				@(posedge clk);
		$stop(); // end the simulation
	end

endmodule

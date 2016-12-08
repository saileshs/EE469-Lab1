`define XFER_SIZE 4'd8 // Set data memory transfer size to 8 bytes.

`timescale 1ns/10ps
module cpu_pipelined (clk, reset);
	input logic clk, reset;
	logic [4:0] x30ForwardMuxIn [1:0]; // for x30_write_mux_forwarding (for BL instruction)
	logic [4:0] ReadRegister, X30MuxOutForward;

	// Control Logic
	logic Reg2Loc, RegWrite, MemWrite, MemToReg, UncondBr, X30Write, SetFlag;
	logic [1:0] ALUSrc, BrTaken;
	logic [2:0] ALUOp;
	
	logic negativeFlag, zeroFlag, overflowFlag, carryOutFlag;
	logic negativeFlag_temp, overflowFlag_temp, carryOutFlag_temp, zeroFlag_temp;
	logic overflow1, overflow2, carryout1, carryout2, cbz_zero_flag; // Output flags from adders
	logic [63:0] ReadData1, ReadData2, ALUOut, DataMemOut, PCInput, uncondBrOut, brShifterOut, memToRegOut, ALUMuxOut;
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

	// Datapath Wires coming out of the pipeline registers
	logic [63:0]	IFID_pc_out, IFID_pc_plus4_out, IDEX_se_imm12_out, IDEX_se_imm9_out, 
					IDEX_read_data1_out, IDEX_read_data2_out, IDEX_pc_plus4_out,
					EXMEM_pc_plus4_out, EXMEM_data2_out, EXMEM_alu_out, 
					MEMWR_pc_plus4_out, MEMWR_data_out; 
	logic [31:0] IFID_instr_out;
	logic [4:0] IDEX_rd_out, EXMEM_rd_out, MEMWR_rd_out;

	// Control wires coming out of the pipeline registers
	logic [1:0] IDEX_ALUSrc;
	logic [2:0] IDEX_ALUOp;
	logic 	IDEX_MemWrite, IDEX_MemToReg, IDEX_RegWrite, IDEX_SetFlag, EXMEM_MemWrite, EXMEM_MemToReg, EXMEM_RegWrite,
			MEMWR_RegWrite;

	// Forwarding Logic
	logic [63:0] ForwardingMux1 [3:0];
	logic [63:0] ForwardingMux2 [3:0];
	logic [63:0] forwarding_A_output, forwarding_B_output;

	
	// Logic selecting whether to read data from Rd or Rm 
	assign RegRmRd[0] = Rd;
	assign RegRmRd[1] = Rm;
	
	// Reg2Loc mux.
	mux_2to1_5bit reg_mux (.out(ReadRegister), .control(Reg2Loc), .in(RegRmRd));

	// X30Write Mux. Decides whether to write to Rd or to X30 (for BL instruction).
	assign x30ForwardMuxIn[0] = Rd;
	assign x30ForwardMuxIn[1] = 5'b11110; // Reg X30
	mux_2to1_5bit x30_write_mux_forwarding (.out(X30MuxOutForward), .control(X30Write), .in(x30ForwardMuxIn)); // Choosing between Rd and X30 for Write Register

	// Calling the RegFile to access data and write data to registers.
	// Given negation of clk in order to avoid reading old values in register.
	regfile rf (.ReadData1, .ReadData2, .ReadRegister1(Rn), .ReadRegister2(ReadRegister), .WriteRegister(MEMWR_rd_out), .WriteData(MEMWR_data_out), .RegWrite(MEMWR_RegWrite), .clk(~clk));
	
	// Select signals for controling the Forwarding Mux A and Forwarding Mux B.
	logic [1:0] forwardA;
	logic [1:0] forwardB;
	
	// Calling the FORWARDING UNIT to handle EX hazards and Mem Hazards.
	// Returns two 2-bit select signals, which control the ForwardingMux1 and ForwardingMux2.
	FORWARDING_UNIT forward (.forward_A(forwardA), .forward_B(forwardB), .rn_in(Rn), .rm_in(ReadRegister), .IDEX_RegisterRd(IDEX_rd_out), .EXMEM_RegisterRd(EXMEM_rd_out), .IDEX_RegWrite(IDEX_RegWrite), .EXMEM_RegWrite(EXMEM_RegWrite));
	
	// Forwarding Data Path. Decides whether to take data from regfile, Exec stage, or Mem stage.
	assign ForwardingMux1[0] = ReadData1;
	assign ForwardingMux1[1] = ALUOut;
	assign ForwardingMux1[2] = memToRegOut;
	assign ForwardingMux1[3] = 64'bX;
	mux_4to1 forwarding_mux1 (.out(forwarding_A_output), .control(forwardA), .in(ForwardingMux1));

	assign ForwardingMux2[0] = ReadData2;
	assign ForwardingMux2[1] = ALUOut;
	assign ForwardingMux2[2] = memToRegOut;
	assign ForwardingMux2[3] = 64'bX;
	mux_4to1 forwarding_mux2 (.out(forwarding_B_output), .control(forwardB), .in(ForwardingMux2));

	// Calling ALU unit for arithmetic operations
	alu a (.A(IDEX_read_data1_out), .B(ALUMuxOut), .cntrl(IDEX_ALUOp), .result(ALUOut), .negative(negativeFlag_temp), .zero(zeroFlag_temp), .overflow(overflowFlag_temp), .carry_out(carryOutFlag_temp));
	
	// Calling Data Memory unit to store to and read from memory.
	datamem memory (.address(EXMEM_alu_out), .write_enable(EXMEM_MemWrite), .read_enable(EXMEM_MemToReg), .write_data(EXMEM_data2_out), .clk, .xfer_size(`XFER_SIZE), .read_data(DataMemOut));
	
	// Logic selecting whether to read data from ALUOut or DataMemOut
	assign ALUOrMemOut[0] = EXMEM_alu_out;
	assign ALUOrMemOut[1] = DataMemOut;
	
	// MemToReg mux. Decides whether to take data from datamem or alu.
	mux_2to1 mem_mux (.out(memToRegOut), .control(EXMEM_MemToReg), .in(ALUOrMemOut));
	
	// ALUSrc Datapath
	SE extend_imm9 (.out(SEImm9), .in(IFID_instr_out));
	ZE extend_imm12 (.out(ZEImm12), .in(imm12)); // For ADDI
	assign ALUMuxIn[0] = IDEX_read_data2_out;
	assign ALUMuxIn[1] = IDEX_se_imm9_out;
	assign ALUMuxIn[2] = IDEX_se_imm12_out;
	// For BL instruction. PC + 4 will be passed through the ALU (Exec Stage) and through the MemToReg mux (Mem Stage)
	// so it can be forwarded by the forwarding unit if needed in later instructions.
	assign ALUMuxIn[3] = IDEX_pc_plus4_out;

	// ALU mux. Decides the source of the ALU B input
	mux_4to1 alu_mux (.out(ALUMuxOut), .control(IDEX_ALUSrc), .in(ALUMuxIn));
	
	// Program counter calculates address of next instruction.
	PC program_counter (.out(address), .in(PCInput), .reset, .clk);
	
	// Outputs the instruction given the current address.
	instructmem instruction_memory (.address, .instruction, .clk);

	assign opCode = IFID_instr_out[31:21];
	assign Rd = IFID_instr_out[4:0];
	assign Rm = IFID_instr_out[20:16];
	assign Rn = IFID_instr_out[9:5];
	assign imm12 = IFID_instr_out[21:10]; // For ADDI
	
	// Standalone ZeroFlag module -- For CBZ
	nor64 nor0 (.out(cbz_zero_flag), .in(forwarding_B_output));

	// Control Unit. Gives control signals for all muxes to decide 
	// the correct datapth given the instruction OpCode.
	controlUnit control (.Reg2Loc, .ALUSrc, .MemToReg, .RegWrite, .MemWrite, .BrTaken, .UncondBr, .ALUOp, .X30Write, .SetFlag, .opCode, .negativeFlag(negativeFlag_temp), .zeroFlag(cbz_zero_flag), .overflowFlag(overflowFlag_temp), .DFF_negativeFlag(negativeFlag), .DFF_overflowFlag(overflowFlag), .IDEX_SetFlag);
	
	// Compute BrTaken mux input 0
	addSub64 pcPlus4 (.carryOut(carryout1), .result(WhichBranch[0]), .overflow(overflow1), .a(address), .b(64'd4), .carryIn(1'b0));
	
	// Compute BrTaken mux input 1
	SE extend_imm19 (.out(branchImmediates[0]), .in(IFID_instr_out));
	SE extend_imm26 (.out(branchImmediates[1]), .in(IFID_instr_out));
	mux_2to1 uncondbr_mux (.out(uncondBrOut), .control(UncondBr), .in(branchImmediates));
	shifter shift_imm (.out(brShifterOut), .in(uncondBrOut));
	addSub64 branch_imm_adder (.carryOut(carryout2), .result(shiftedAddedBranchAddr), .overflow(overflow2), .a(IFID_pc_out), .b(brShifterOut), .carryIn(1'b0));
	
	assign WhichBranch[1] = shiftedAddedBranchAddr;
	assign WhichBranch[2] = forwarding_B_output; // For BR instruction
	assign WhichBranch[3] = 64'bX;

	// Branch Taken Mux - Decides whether to take a branch.
	mux_4to1 brtaken_mux (.out(PCInput), .control(BrTaken), .in(WhichBranch));

	// Pipeline registers breaking up CPU into 5 stages. 
	IF_ID_reg IFID (.pc_out(IFID_pc_out), .pc_plus4_out(IFID_pc_plus4_out), .instr_out(IFID_instr_out), .pc_in(address), .pc_plus4_in(WhichBranch[0]), .instr_in(instruction), .reset, .clk, .enable(1'b1));
	ID_EX_reg IDEX (.pc_plus4_out(IDEX_pc_plus4_out), .rd_out(IDEX_rd_out), .se_imm12_out(IDEX_se_imm12_out), .se_imm9_out(IDEX_se_imm9_out), .read_data1_out(IDEX_read_data1_out), .read_data2_out(IDEX_read_data2_out), .ALUSrc_out(IDEX_ALUSrc), .ALUOp_out(IDEX_ALUOp), .MemWrite_out(IDEX_MemWrite), .MemToReg_out(IDEX_MemToReg), .RegWrite_out(IDEX_RegWrite), .SetFlag_out(IDEX_SetFlag),
					.pc_plus4_in(IFID_pc_plus4_out), .rd_in(X30MuxOutForward), .se_imm12_in(ZEImm12), .se_imm9_in(SEImm9), .read_data1_in(forwarding_A_output), .read_data2_in(forwarding_B_output), .ALUSrc_in(ALUSrc), .ALUOp_in(ALUOp), .MemWrite_in(MemWrite), .MemToReg_in(MemToReg), .RegWrite_in(RegWrite), .SetFlag_in(SetFlag), .reset, .clk, .enable(1'b1));
	EX_MEM_reg EXMEM (.pc_plus4_out(EXMEM_pc_plus4_out), .data2_out(EXMEM_data2_out), .alu_out(EXMEM_alu_out), .EXMEM_RegisterRd(EXMEM_rd_out), .MemWrite_out(EXMEM_MemWrite), .MemToReg_out(EXMEM_MemToReg), .RegWrite_out(EXMEM_RegWrite), .pc_plus4_in(IDEX_pc_plus4_out), .data2_in(ALUMuxIn[0]), .rd_in(IDEX_rd_out), .alu_in(ALUOut), .MemWrite_in(IDEX_MemWrite), .MemToReg_in(IDEX_MemToReg), .RegWrite_in(IDEX_RegWrite), .reset, .clk, .enable(1'b1));
	MEM_WR_reg MEMWR (.pc_plus4_out(MEMWR_pc_plus4_out), .data_out(MEMWR_data_out), .MEMWR_RegisterRd(MEMWR_rd_out), .RegWrite_out(MEMWR_RegWrite), .pc_plus4_in(EXMEM_pc_plus4_out), .data_in(memToRegOut), .EXMEM_RegisterRd(EXMEM_rd_out), .RegWrite_in(EXMEM_RegWrite), .reset, .clk, .enable(1'b1));

	// Storing flags to DFFs if SetFlag is enabled for the instruction.
	DFF1_enable negative_reg (.q(negativeFlag), .d(negativeFlag_temp), .reset, .clk, .enable(IDEX_SetFlag));
	DFF1_enable overflow_reg (.q(overflowFlag), .d(overflowFlag_temp), .reset, .clk, .enable(IDEX_SetFlag));
	DFF1_enable zero_reg (.q(zeroFlag), .d(zeroFlag_temp), .reset, .clk, .enable(IDEX_SetFlag));
	DFF1_enable carryOut_reg (.q(carryOutFlag), .d(carryOutFlag_temp), .reset, .clk, .enable(IDEX_SetFlag));


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
			for (i = 0; i < 700; i++)
				@(posedge clk);
		$stop(); // end the simulation
	end

endmodule

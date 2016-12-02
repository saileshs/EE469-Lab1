`timescale 1ns/10ps

module IF_ID_reg (pc_out, pc_plus4_out, instr_out, pc_in, pc_plus4_in, instr_in, reset, clk, enable);
	output logic [63:0] pc_out, pc_plus4_out;
	output logic [31:0] instr_out;
	input logic [63:0] pc_in, pc_plus4_in;
	input logic [31:0] instr_in;
	input logic clk, reset, enable;

	DFF64 dff1 (.q(pc_out),  .d(pc_in),  .reset, .clk, .enable);
	DFF64 dff2 (.q(pc_plus4_out),  .d(pc_plus4_in),  .reset, .clk, .enable);
	DFF32 dff3 (.q(instr_out), .d(instr_in), .reset, .clk, .enable);
endmodule

module ID_EX_reg (pc_out, rn_out, rm_out, rd_out, se_imm12_out, se_imm9_out, se_branch_out, read_data1_out, read_data2_out, ALUSrc_out, ALUOp_out, MemWrite_out, MemToReg_out, RegWrite_out, SetFlags_out, pc_in, rn_in, rm_in, rd_in, se_imm12_in, se_imm9_in, se_branch_in, read_data1_in, read_data2_in, ALUSrc_in, ALUOp_in, MemWrite_in, MemToReg_in, RegWrite_in, SetFlags_in, reset, clk, enable);
	
	// Datapath Logic

	output logic [63:0] pc_out, se_imm12_out, se_imm9_out, se_branch_out, read_data1_out, read_data2_out; 
	output logic [4:0] rn_out, rm_out, rd_out;
	input logic [63:0] pc_in, se_imm12_in, se_imm9_in, se_branch_in, read_data1_in, read_data2_in;
	input logic [4:0] rn_in, rm_in, rd_in;
	input logic clk, reset, enable;

	DFF64 dff1 (.q(pc_out),  .d(pc_in),  .reset, .clk, .enable);
	DFF64 dff2 (.q(se_imm12_out), .d(se_imm12_in), .reset, .clk, .enable);
	DFF64 dff3 (.q(se_imm9_out), .d(se_imm9_in), .reset, .clk, .enable);
	DFF64 dff4 (.q(se_branch_out), .d(se_branch_in), .reset, .clk, .enable);
	DFF64 dff5 (.q(read_data1_out), .d(read_data1_in), .reset, .clk, .enable);
	DFF64 dff6 (.q(read_data2_out), .d(read_data2_in), .reset, .clk, .enable);
	DFF5  dff7 (.q(rn_out), .d(rn_in), .reset, .clk, .enable);
	DFF5  dff8 (.q(rm_out), .d(rm_in), .reset, .clk, .enable);
	DFF5  dff9 (.q(rd_out), .d(rd_in), .reset, .clk, .enable);

	// Control Logic

	output logic [1:0] ALUSrc_out;
	output logic [2:0] ALUOp_out;
	output logic MemWrite_out, MemToReg_out, RegWrite_out, SetFlags_out;

	input logic [1:0] ALUSrc_in;
	input logic [2:0] ALUOp_in;
	input logic MemWrite_in, MemToReg_in, RegWrite_in, SetFlags_in;

	DFF2 ALUSrc_reg (.q(ALUSrc_out), .d(ALUSrc_in), .reset, .clk, .enable);
	DFF3 ALUOp_reg (.q(ALUOp_out), .d(ALUOp_in), .reset, .clk, .enable);
	DFF1_enable MemWrite_reg (.q(MemWrite_out), .d(MemWrite_in), .reset, .clk, .enable);
	DFF1_enable MemToReg_reg (.q(MemToReg_out), .d(MemToReg_in), .reset, .clk, .enable);
	DFF1_enable RegWrite_reg (.q(RegWrite_out), .d(RegWrite_in), .reset, .clk, .enable);
	DFF1_enable SetFlags_reg (.q(SetFlags_out), .d(SetFlags_in), .reset, .clk, .enable);
endmodule

module EX_MEM_reg (branch_out, data2_out, alu_out, ExMem_RegisterRd, MemWrite_out, MemToReg_out, RegWrite_out, branch_in, data2_in, rd_in, alu_in, MemWrite_in, MemToReg_in, RegWrite_in, reset, clk, enable);
	
	// Datapath logic

	output logic [63:0] branch_out, data2_out, alu_out;
	output logic [4:0] ExMem_RegisterRd;
	input logic [63:0] branch_in, data2_in, alu_in;
	input logic [4:0] rd_in;
	input logic clk, reset, enable;


	DFF64 dff1 (.q(branch_out),  .d(branch_in),  .reset, .clk, .enable);
	DFF64 dff2 (.q(data2_out), .d(data2_in), .reset, .clk, .enable);
	DFF64 dff3 (.q(alu_out), .d(alu_in), .reset, .clk, .enable);
	DFF5  dff4 (.q(ExMem_RegisterRd), .d(rd_in), .reset, .clk, .enable);

	// Control Logic

	output logic MemWrite_out, MemToReg_out, RegWrite_out;
	input logic MemWrite_in, MemToReg_in, RegWrite_in;

	DFF1_enable MemWrite_reg (.q(MemWrite_out), .d(MemWrite_in), .reset, .clk, .enable);
	DFF1_enable MemToReg_reg (.q(MemToReg_out), .d(MemToReg_in), .reset, .clk, .enable);
	DFF1_enable RegWrite_reg (.q(RegWrite_out), .d(RegWrite_in), .reset, .clk, .enable);
endmodule

module MEM_WR_reg (alu_out, data_mem_out, MemWr_RegisterRd, MemToReg_out, RegWrite_out, alu_in, data_mem_in, ExMem_RegisterRd, MemToReg_in, RegWrite_in, reset, clk, enable);
	
	// Datapath Logic

	output logic [63:0] alu_out, data_mem_out;
	output logic [4:0] MemWr_RegisterRd;
	input logic [63:0] alu_in, data_mem_in;
	input logic [4:0] ExMem_RegisterRd;
	input logic clk, reset, enable;
	
	DFF64 dff1 (.q(alu_out),  .d(alu_in),  .reset, .clk, .enable);
	DFF64 dff2 (.q(data_mem_out), .d(data_mem_in), .reset, .clk, .enable);
	DFF5  dff3 (.q(MemWr_RegisterRd), .d(ExMem_RegisterRd), .reset, .clk, .enable);

	// Control Logic

	output logic MemToReg_out, RegWrite_out;
	input logic MemToReg_in, RegWrite_in;

	DFF1_enable MemToReg_reg (.q(MemToReg_out), .d(MemToReg_in), .reset, .clk, .enable);
	DFF1_enable RegWrite_reg (.q(RegWrite_out), .d(RegWrite_in), .reset, .clk, .enable);
endmodule

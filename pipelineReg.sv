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

module ID_EX_reg (rd_out, se_imm12_out, se_imm9_out, read_data1_out, read_data2_out, ALUSrc_out, ALUOp_out, MemWrite_out, MemToReg_out, RegWrite_out, BLCtrl_out, X30Write_out, rd_in, se_imm12_in, se_imm9_in, read_data1_in, read_data2_in, ALUSrc_in, ALUOp_in, MemWrite_in, MemToReg_in, RegWrite_in, BLCtrl_in, X30Write_in,reset, clk, enable);
	
	// Datapath Logic

	output logic [63:0] se_imm12_out, se_imm9_out, read_data1_out, read_data2_out; 
	output logic [4:0] rd_out;
	input logic [63:0] se_imm12_in, se_imm9_in, read_data1_in, read_data2_in;
	input logic [4:0] rd_in;
	input logic clk, reset, enable;

	DFF64 dff2 (.q(se_imm12_out), .d(se_imm12_in), .reset, .clk, .enable);
	DFF64 dff3 (.q(se_imm9_out), .d(se_imm9_in), .reset, .clk, .enable);
	DFF64 dff5 (.q(read_data1_out), .d(read_data1_in), .reset, .clk, .enable);
	DFF64 dff6 (.q(read_data2_out), .d(read_data2_in), .reset, .clk, .enable);
	DFF5  dff7 (.q(rd_out), .d(rd_in), .reset, .clk, .enable);

	// Control Logic

	output logic [1:0] ALUSrc_out;
	output logic [2:0] ALUOp_out;
	output logic MemWrite_out, MemToReg_out, RegWrite_out, BLCtrl_out, X30Write_out;

	input logic [1:0] ALUSrc_in;
	input logic [2:0] ALUOp_in;
	input logic MemWrite_in, MemToReg_in, RegWrite_in, BLCtrl_in, X30Write_in;

	DFF_2 ALUSrc_reg (.q(ALUSrc_out), .d(ALUSrc_in), .reset, .clk, .enable);
	DFF3 ALUOp_reg (.q(ALUOp_out), .d(ALUOp_in), .reset, .clk, .enable);
	DFF1_enable MemWrite_reg (.q(MemWrite_out), .d(MemWrite_in), .reset, .clk, .enable);
	DFF1_enable MemToReg_reg (.q(MemToReg_out), .d(MemToReg_in), .reset, .clk, .enable);
	DFF1_enable RegWrite_reg (.q(RegWrite_out), .d(RegWrite_in), .reset, .clk, .enable);
	DFF1_enable BLCtrl_reg (.q(BLCtrl_out), .d(BLCtrl_in), .reset, .clk, .enable);
	DFF1_enable X30Write_reg (.q(X30Write_out), .d(X30Write_in), .reset, .clk, .enable);
endmodule

module EX_MEM_reg (data2_out, alu_out, EXMEM_RegisterRd, MemWrite_out, MemToReg_out, RegWrite_out, BLCtrl_out, X30Write_out, data2_in, rd_in, alu_in, MemWrite_in, MemToReg_in, RegWrite_in, BLCtrl_in, X30Write_in, reset, clk, enable);
	
	// Datapath logic

	output logic [63:0] data2_out, alu_out;
	output logic [4:0] EXMEM_RegisterRd;
	input logic [63:0] data2_in, alu_in;
	input logic [4:0] rd_in;
	input logic clk, reset, enable;

	DFF64 dff2 (.q(data2_out), .d(data2_in), .reset, .clk, .enable);
	DFF64 dff3 (.q(alu_out), .d(alu_in), .reset, .clk, .enable);
	DFF5  dff4 (.q(EXMEM_RegisterRd), .d(rd_in), .reset, .clk, .enable);

	// Control Logic

	output logic MemWrite_out, MemToReg_out, RegWrite_out, BLCtrl_out, X30Write_out;
	input logic MemWrite_in, MemToReg_in, RegWrite_in, BLCtrl_in, X30Write_in;

	DFF1_enable MemWrite_reg (.q(MemWrite_out), .d(MemWrite_in), .reset, .clk, .enable);
	DFF1_enable MemToReg_reg (.q(MemToReg_out), .d(MemToReg_in), .reset, .clk, .enable);
	DFF1_enable RegWrite_reg (.q(RegWrite_out), .d(RegWrite_in), .reset, .clk, .enable);
	DFF1_enable BLCtrl_reg (.q(BLCtrl_out), .d(BLCtrl_in), .reset, .clk, .enable);
	DFF1_enable X30Write_reg (.q(X30Write_out), .d(X30Write_in), .reset, .clk, .enable);
endmodule

module MEM_WR_reg (data_out, MEMWR_RegisterRd, RegWrite_out, BLCtrl_out, X30Write_out, data_in, EXMEM_RegisterRd, RegWrite_in, BLCtrl_in, X30Write_in, reset, clk, enable);
	
	// Datapath Logic

	output logic [63:0] data_out;
	output logic [4:0] MEMWR_RegisterRd;
	input logic [63:0] data_in;
	input logic [4:0] EXMEM_RegisterRd;
	input logic clk, reset, enable;
	
	DFF64 dff1 (.q(data_out), .d(data_in), .reset, .clk, .enable);
	DFF5  dff2 (.q(MEMWR_RegisterRd), .d(EXMEM_RegisterRd), .reset, .clk, .enable);

	// Control Logic

	output logic RegWrite_out, BLCtrl_out, X30Write_out;
	input logic RegWrite_in, BLCtrl_in, X30Write_in;

	DFF1_enable RegWrite_reg (.q(RegWrite_out), .d(RegWrite_in), .reset, .clk, .enable);
	DFF1_enable BLCtrl_reg (.q(BLCtrl_out), .d(BLCtrl_in), .reset, .clk, .enable);
	DFF1_enable X30Write_reg (.q(X30Write_out), .d(X30Write_in), .reset, .clk, .enable);
endmodule

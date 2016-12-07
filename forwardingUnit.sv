`timescale 1ns/10ps

// Forwarding Unit Control logic to decide which register values should be passed to the Exec stage. 
// This unit detects hazards if we using a register that is still being written to by a previous instruction.
// The result of the register being written to is taken from the MEM stage or the EXEC stage and ported back to the 
// Reg/Dec stage for the instruction that needs to read the updated value of the respective register.

module FORWARDING_UNIT (forward_A, forward_B, rn_in, rm_in, IDEX_RegisterRd, EXMEM_RegisterRd, IDEX_RegWrite, EXMEM_RegWrite);
	output logic [1:0] forward_A, forward_B;
	input logic IDEX_RegWrite, EXMEM_RegWrite;
	input logic [4:0] rn_in, rm_in, IDEX_RegisterRd, EXMEM_RegisterRd;

	always_comb begin

		if ((EXMEM_RegWrite) && (EXMEM_RegisterRd != 5'b11111) && IDEX_RegisterRd != rn_in && EXMEM_RegisterRd == rn_in)
			forward_A = 2'b10;
			
		else if ((IDEX_RegWrite) && (IDEX_RegisterRd != 5'b11111) && (IDEX_RegisterRd == rn_in))
			forward_A = 2'b01;
		
		else
			forward_A = 2'b00;

		if ((EXMEM_RegWrite) && (EXMEM_RegisterRd != 5'b11111) && IDEX_RegisterRd != rm_in && EXMEM_RegisterRd == rm_in)
			forward_B = 2'b10;
		
		else if ((IDEX_RegWrite) && (IDEX_RegisterRd != 5'b11111) && (IDEX_RegisterRd == rm_in))
			forward_B = 2'b01;
		
		else 
			forward_B = 2'b00;
	
	end
endmodule

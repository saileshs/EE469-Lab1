`timescale 1ns/10ps

// I will comment this module once we know for sure that this is correct

module FORWARDING_UNIT (forward_A, forward_B, rn_in, rm_in, EXMEM_RegisterRd, MEMWB_RegisterRd, ExMem_RegWrite, MemWr_RegWrite);
	output logic [1:0] forward_A, forward_B;
	input logic ExMem_RegWrite, MemWr_RegWrite;
	input logic [4:0] rn_in, rm_in, EXMEM_RegisterRd, MEMWB_RegisterRd;

	always_comb begin
			
		if (ExMem_RegWrite && (EXMEM_RegisterRd != 5'b11111) && (EXMEM_RegisterRd == rn_in))
			forward_A = 2'b10;
			
		else if (MemWr_RegWrite && (MEMWB_RegisterRd != 5'b11111) && ~(ExMem_RegWrite && (EXMEM_RegisterRd != 5'b11111)
					&& (EXMEM_RegisterRd != rn_in) && MEMWB_RegisterRd == rn_in))
			forward_A = 2'b01;
		
		else
			forward_A = 2'b00;
		
		if (ExMem_RegWrite && (EXMEM_RegisterRd != 5'b11111) && (EXMEM_RegisterRd == rm_in))
			forward_A = 2'b10;
		
		else if (MemWr_RegWrite && (MEMWB_RegisterRd != 5'b11111) && ~(ExMem_RegWrite && (EXMEM_RegisterRd != 5'b11111)
					&& (EXMEM_RegisterRd != rm_in) && MEMWB_RegisterRd == rm_in))
			forward_B = 2'b01;
		else 
			forward_B = 2'b00;
	
	end
endmodule

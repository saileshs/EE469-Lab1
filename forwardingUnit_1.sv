module FORWARDING_UNIT_MEM_HAZARD (forward_A, forward_B, rn_in, rm_in, EXMEM_RegisterRd, MEMWR_RegisterRd, EXMEM_RegWrite, MEMWR_RegWrite);
	output logic [1:0] forward_A, forward_B;
	input logic EXMEM_RegWrite, MEMWR_RegWrite;
	input logic [4:0] rn_in, rm_in, EXMEM_RegisterRd, MEMWR_RegisterRd;

	always_comb begin
			
		if (MEMWR_RegWrite && (MEMWR_RegisterRd != 5'b11111) && ~(EXMEM_RegWrite && (EXMEM_RegisterRd != 5'b11111)
		&& (EXMEM_RegisterRd != rn_in) && MEMWR_RegisterRd == rn_in))
			forward_A = 2'b01;
		else
			forward_A = 2'b00;
			
		if (MEMWR_RegWrite && (MEMWR_RegisterRd != 5'b11111) && ~(EXMEM_RegWrite && (EXMEM_RegisterRd != 5'b11111)
		&& (EXMEM_RegisterRd != rm_in) && MEMWR_RegisterRd == rm_in))
			forward_B = 2'b01;
		else 
			forward_B = 2'b00;
	
	end
endmodule

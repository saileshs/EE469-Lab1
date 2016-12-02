`timescale 1ns/10ps

module HAZARD_DETECTION_UNIT (PCWrite, IFIDWrite, muxControl, IDEX_MemRead, IDEX_Register_Rd, IFID_Register_Rn, IFID_Register_Rm);
	
	output logic PCWrite, IFIDWrite, muxControl;
	input logic [4:0] IDEX_Register_Rd, IFID_Register_Rn, IFID_Register_Rm;
	input logic IDEX_MemRead;
	
	always_comb begin
	
		if (IDEX_MemRead && ((IDEX_Register_Rd == IFID_Register_Rn) || (IDEX_Register_Rd == IFID_Register_Rm)))
			begin
				PCWrite = 1'b0;
				IFIDWrite = 1'b0;
				muxControl = 1'b0;
			end
		else 
			begin
				PCWrite = 1'b1;
				IFIDWrite = 1'b1;
				muxControl = 1'b1;
			end
	end
	
endmodule

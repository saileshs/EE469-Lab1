`timescale 1ns/10ps

// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

module alustim();

	parameter delay = 100000;

	logic		[63:0]	A, B;
	logic		[2:0]		cntrl;
	logic		[63:0]	result;
	logic					negative, zero, overflow, carry_out ;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	

	alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic [63:0] test_val;
	initial begin
	
		$display("%t testing PASS_A operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<10; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end
		
		$display("%t testing addition", $time);
		cntrl = ALU_ADD;
		
		// Carryout, No Overflow
		A = 64'b1101100100000000000000000000000000000000000000000000000000000000; 
		B = 64'b0101110000000000000000000000000000000000000000000000000000000000;
		#(delay);
		//assert(result == 64'h000018AB && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);
		
		// Overflow and Carryout
		A = 64'b1001100100000000000000000000000000000000000000000000000000000000; 
		B = 64'b1011101100000000000000000000000000000000000000000000000000000000;
		#(delay);
		//assert(result == 64'h00001339 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);
		
		// Overflow, no carryout, negative
		A = 64'b0111111111111111111111111111111111111111111111111111111111111111; 
		B = 64'd1;
		#(delay);
		//assert(result == 64'h80000000 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);
		
		// Zero flag
		A = 64'b0;
		B = 64'b0;
		#(delay);
		
		$display("%t testing subtraction", $time);
		cntrl = ALU_SUBTRACT;
		
		// Output 0x0000033300000000
		A = 64'h00000DEF00000000; B = 64'h00000ABC00000000;
		#(delay);
		
		// Output 0x7FFFFFFF0000000 with overflow on
		A = 64'h8000000000000000; B = 64'h0000000100000000;
		#(delay);
		
		A = 64'd130; B = 64'd30;
		#(delay);
		
		// Zero flag
		A = 64'h110; B = A;
		#(delay);
		
		$display("%t testing anding", $time);
		cntrl = ALU_AND;
		A = 64'b0; B = 64'b0;
		#(delay);
		A = 64'b1111111111111111111111111111111111111111111111111111111111111111; B = A;
		#(delay);
		A = 64'b1010101010101010101010101010101010101010101010101010101010101010; 
		B = 64'b0101010101010101010101010101010101010101010101010101010101010101;
		#(delay);
		
		$display("%t testing oring", $time);
		cntrl = ALU_OR;
		A = 64'b0; B = 64'b0;
		#(delay);
		A = 64'b1111111111111111111111111111111111111111111111111111111111111111; B = A;
		#(delay);
		A = 64'b1010101010101010101010101010101010101010101010101010101010101010; 
		B = 64'b0101010101010101010101010101010101010101010101010101010101010101;
		#(delay);
		
		$display("%t testing xoring", $time);
		cntrl = ALU_XOR;
		A = 64'b0; B = 64'b0;
		#(delay);
		A = 64'b1111111111111111111111111111111111111111111111111111111111111111; B = A;
		#(delay);
		A = 64'b1010101010101010101010101010101010101010101010101010101010101010; 
		B = 64'b0101010101010101010101010101010101010101010101010101010101010101;
		#(delay);
		A = 64'b1111111111111111111111111111111010101010101010101010101010101010;
		B = 64'b0101010101010101010101010101010101010101010101010101010101010101;
		#(delay);
	end
endmodule

module adder64 (carryOut, sum, a, b, carryIn);
	output logic [63:0] sum;
	output logic carryOut;
	input logic [63:0] a, b;
	input logic carryIn;
	
	wire tempCarryOut;

	adder add0 (.carryOut(tempCarryOut), .sum(sum[0]), .a(a[0]), .b(b[0]), .carryIn);
	
	genvar i;
	generate
		for(i = 1; i < 64; i++) begin : eachAdder
			adder add1 (.carryOut(tempCarryOut), .sum(sum[i]), .a(a[i]), .b(b[i]), .carryIn(tempCarryOut));
		end
	endgenerate
	assign carryOut = tempCarryOut;
	//adder add2 (.carryOut, .sum(sum[63]), .a(a[63]), .b(b[63]), .carryIn(tempCarryOut));
endmodule
module adder (carryOut, sum, a, b, carryIn);
	output logic carryOut, sum;
	input logic a, b, carryIn;
	
	//--- CarryOut computation ---
	logic carryCase1, carryCase2, carryCase3;
	
	and #50 a0 (carryCase1, b, carryIn);
	and #50 a1 (carryCase2, a, carryIn);
	and #50 a2 (carryCase3, a, b);
	or #50 or0 (carryOut, carryCase1, carryCase2, carryCase3);
	
	//--- Sum computation ---
	logic sumCase1, sumCase2, sumCase3, sumCase4;
	logic notA, notB, notCI;
	
	not #50 (notA, a);
	not #50 (notB, b);
	not #50 (notCI, carryIn);
	
	and #50 a3 (sumCase1, a, notB, notCI);
	and #50 a4 (sumCase2, notA, b, notCI);
	and #50 a5 (sumCase3, notA, notB, carryIn);
	and #50 a6 (sumCase4, a, b, carryIn);
	or #50 or1 (sum, sumCase1, sumCase2, sumCase3, sumCase4);

endmodule

module adder_testbench();
	logic [63:0] a, b, sum;
	logic cO;
	
	adder64 dut (cO, sum, a, b, 1'b0);
	
	integer i;
	initial begin
		#800;
		for (i = 0; i < 31; i++) begin
			a = i; b = i; #800;
		end
	end
endmodule
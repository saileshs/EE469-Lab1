//module adder64 (carryOut, sum, a, b);
//	output logic [63:0] sum;
//	output logic carryOut;
//	input logic [63:0] a, b;
//	
//	addSub64 add (.carryOut, .sum, .a, .b, .carryIn(1'b0));
//	
//endmodule
//
//module subtractor64 (carryOut, diff, a, b);
//	output logic [63:0] diff;
//	output logic carryOut;
//	input logic [63:0] a, b;
//	
//	logic [63:0] notB;
//	
//	not64	 invert (.out(notB), .in(b));
//	
//	addSub64 subtract (.carryOut, .sum(diff), .a, .b(notB), .carryIn(1'b1));
//	
//endmodule

module addSub64 (carryOut, result, overflow, a, b, carryIn);
	output logic [63:0] result;
	output logic carryOut, overflow;
	input logic [63:0] a, b;
	input logic carryIn;
	
	wire [63:0] tempCarryOut;
	
	logic [63:0] secondOp;
	logic [63:0] notB;
	
	not64	 invert (.out(notB), .in(b));
	mux_2to1 m0 (.out(secondOp), .control(carryIn), .in({notB, b}));

	addSub add0 (.carryOut(tempCarryOut[0]), .sum(result[0]), .a(a[0]), .b(secondOp[0]), .carryIn);

		
	genvar i;
	generate
		for(i = 1; i < 64; i++) begin : eachAdder
			adder addSub (.carryOut(tempCarryOut[i]), .sum(result[i]), .a(a[i]), .b(secondOp[i]), .carryIn(tempCarryOut[i - 1]));
		end
	endgenerate
	assign carryOut = tempCarryOut[63];

endmodule

module addSub (carryOut, sum, a, b, carryIn);
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
	logic [63:0] a, b, sum, difference;
	logic cO, cO2;
	
	adder64 dut (cO, sum, a, b);
	subtractor64 dut2 (cO2, difference, a, b);
	
	integer i;
	initial begin
		#800;
		for (i = 0; i < 32; i++) begin
			a = i+i; b = i; #800; 
		end
	end
endmodule
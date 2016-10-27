`timescale 1ns/10ps

module addSub64 (carryOut, result, overflow, a, b, carryIn);
	output logic [63:0] result;
	output logic carryOut, overflow;
	input logic [63:0] a, b;
	input logic carryIn;
	
	wire [63:0] tempCarryOut;
	
	logic [63:0] secondOp;
	logic [63:0] notB;
	
	logic [63:0] bandNotB [1:0];
	assign bandNotB[0] = b;
	assign bandNotB[1] = notB;
	
	not64	 invert (.out(notB), .in(b));
	mux_2to1 m0 (.out(secondOp), .control(carryIn), .in(bandNotB));

	addSub add0 (.carryOut(tempCarryOut[0]), .sum(result[0]), .a(a[0]), .b(secondOp[0]), .carryIn);
		
	genvar i;
	generate
		for(i = 1; i < 64; i++) begin : eachAdder
			addSub add1 (.carryOut(tempCarryOut[i]), .sum(result[i]), .a(a[i]), .b(secondOp[i]), .carryIn(tempCarryOut[i - 1]));
		end
	endgenerate
	assign carryOut = tempCarryOut[63];
	xor #50 overflowDetector (overflow, tempCarryOut[63], tempCarryOut[62]);

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
	logic [63:0] result, a, b;
	logic carryOut, overflow;
	
	//addSub64 add(carryOut, result, overflow, a, b, 1'b0);
	addSub64 sub(carryOut, result, overflow, a, b, 1'b1);
	
	integer i;
	initial begin
		#800;
		a = 64'd500;
		b = a;
		#800;
		b = 64'd150;
		#8000;
		
	end
endmodule
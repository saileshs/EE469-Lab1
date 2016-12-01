`timescale 1ns/10ps

// 64-bit bitwise AND
module and64 (out, a, b);
	output logic [63:0] out;
	input logic [63:0] a, b;
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin: eachAnd
			and #50 a (out[i], a[i], b[i]);
		end
	endgenerate

endmodule	

// 64-bit bitwise OR
module or64 (out, a, b);
	output logic [63:0] out;
	input logic [63:0] a, b;
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin: eachOr
			or #50 o (out[i], a[i], b[i]);
		end
	endgenerate
	
endmodule

// 64-bit bitwise XOR
module xor64 (out, a, b);
	output logic [63:0] out;
	input logic [63:0] a, b;
	
	genvar i;
	generate 
		for (i = 0; i < 64; i++) begin: eachXOR
			xor #50 xo (out[i], a[i], b[i]);
		end
	endgenerate
endmodule

// 64-bit bitwise inverter
module not64 (out, in);
	output logic [63:0] out;
	input logic [63:0] in;
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin: eachNot
			not #50 n (out[i], in[i]);
		end
	endgenerate
	
endmodule

// 64-bit bitwise NOR
module nor64 (out, in);
	output logic out;
	input logic [63:0] in;
	
	logic [15:0] or_out16;
	logic [3:0] or_out4;
	
	logic or_out;
	
	or_multi #(.WIDTH(64)) or0 (.out(or_out16), .in);
	or_multi #(.WIDTH(16)) or1 (.out(or_out4), .in(or_out16));
	or_multi #(.WIDTH(4)) or2 (.out(or_out), .in(or_out4));
	
	not #50 invert (out, or_out);

endmodule

// custom width bitwise OR
module or_multi #(parameter WIDTH=64)(out, in);
	output logic [(WIDTH / 4) - 1: 0] out;
	input logic [WIDTH - 1: 0] in;
	
	genvar i;
	generate
		for (i = 0; i < WIDTH; i += 4) begin: eachOr
			or #50 or0 (out[i / 4], in[i], in[i + 1], in[i + 2], in[i + 3]);
		end
	endgenerate
endmodule

module nor_testbench();
	logic [63:0] in;
	logic out;
	
	nor64 no (.out, .in);
	
	integer i;
	initial begin
		#800;
		in = 64'b0; #800;
		in = 64'b1; #800;
		in = 64'h5; #800;
		in = 64'b0; #800;
	end
	
endmodule
		
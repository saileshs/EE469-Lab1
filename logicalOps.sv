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

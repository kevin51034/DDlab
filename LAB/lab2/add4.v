module add4(a, b, c, d, sum, ov, ov2);

	input [3:0] a, b, c, d;
	output [3:0] sum;
	output ov, ov2;
	
	assign sum = a + b + c + d;
	assign ov = 1'b0;
	assign ov2 = 1'b0;

		
endmodule


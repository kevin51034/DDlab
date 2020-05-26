`timescale 1ns/1ps
module CLA_64bit(a,b,cin,sum,cout);
    input [63:0] a,b;
    input cin;
    output [63:0] sum;
    output cout;
    
    wire [63:0] p,g;
	wire [64:0] c;
	wire [15:0] P_4bits,G_4bits;
	
	pg_gen pg(a[63:0],b[63:0],p[63:0],g[63:0]);
	
	//generate 4 bits PG 
	PG_gen PG_4bits0(p[3:0],g[3:0],P_4bits[0],G_4bits[0]);
	PG_gen PG_4bits1(p[7:4],g[7:4],P_4bits[1],G_4bits[1]);
	PG_gen PG_4bits2(p[11:8],g[11:8],P_4bits[2],G_4bits[2]);
	PG_gen PG_4bits3(p[15:12],g[15:12],P_4bits[3],G_4bits[3]);
	PG_gen PG_4bits4(p[19:16],g[19:16],P_4bits[4],G_4bits[4]);
	PG_gen PG_4bits5(p[23:20],g[23:20],P_4bits[5],G_4bits[5]);
	PG_gen PG_4bits6(p[27:24],g[27:24],P_4bits[6],G_4bits[6]);
	PG_gen PG_4bits7(p[31:28],g[31:28],P_4bits[7],G_4bits[7]);
	PG_gen PG_4bits8(p[35:32],g[35:32],P_4bits[8],G_4bits[8]);
	PG_gen PG_4bits9(p[39:36],g[39:36],P_4bits[9],G_4bits[9]);
	PG_gen PG_4bits10(p[43:40],g[43:40],P_4bits[10],G_4bits[10]);
	PG_gen PG_4bits11(p[47:44],g[47:44],P_4bits[11],G_4bits[11]);
	PG_gen PG_4bits12(p[51:48],g[51:48],P_4bits[12],G_4bits[12]);
	PG_gen PG_4bits13(p[55:52],g[55:52],P_4bits[13],G_4bits[13]);
	PG_gen PG_4bits14(p[59:56],g[59:56],P_4bits[14],G_4bits[14]);
	PG_gen PG_4bits15(p[63:60],g[63:60],P_4bits[15],G_4bits[15]);
	
	//generate c4n
	carry_gennerator c4n0(P_4bits[3:0],G_4bits[3:0],cin,{c[12],c[8],c[4]});
	carry_gennerator c4n1(P_4bits[6:3],G_4bits[6:3],c[12],{c[24],c[20],c[16]});
	carry_gennerator c4n2(P_4bits[9:6],G_4bits[9:6],c[24],{c[36],c[32],c[28]});
	carry_gennerator c4n3(P_4bits[12:9],G_4bits[12:9],c[36],{c[48],c[44],c[40]});
	carry_gennerator c4n4(P_4bits[15:12],G_4bits[15:12],c[48],{c[60],c[56],c[52]});
	
	//generate c
	carry_gennerator c0(p[3:0],g[3:0],cin,c[3:1]);
	carry_gennerator c1(p[7:4],g[7:4],c[4],c[7:5]);
	carry_gennerator c2(p[11:8],g[11:8],c[8],c[11:9]);
	carry_gennerator c3(p[15:12],g[15:12],c[12],c[15:13]);
	carry_gennerator c4(p[19:16],g[19:16],c[16],c[19:17]);
	carry_gennerator c5(p[23:20],g[23:20],c[20],c[23:21]);
	carry_gennerator c6(p[27:24],g[27:24],c[24],c[27:25]);
	carry_gennerator c7(p[31:28],g[31:28],c[28],c[31:29]);
	carry_gennerator c8(p[35:32],g[35:32],c[32],c[35:33]);
	carry_gennerator c9(p[39:36],g[39:36],c[36],c[39:37]);
	carry_gennerator c10(p[43:40],g[43:40],c[40],c[43:41]);
	carry_gennerator c11(p[47:44],g[47:44],c[44],c[47:45]);
	carry_gennerator c12(p[51:48],g[51:48],c[48],c[51:49]);
	carry_gennerator c13(p[55:52],g[55:52],c[52],c[55:53]);
	carry_gennerator c14(p[59:56],g[59:56],c[56],c[59:57]);
	carry_gennerator c15(p[63:60],g[63:60],c[60],c[63:61]);
	
	cout_gen c16(P_4bits[15:12],G_4bits[15:12],c[48],{cout,c[60],c[56],c[52]});
	//generate sum
	sum_generator sum1( a[63:0], b[63:0], cin, c[63:1], sum[63:0]);
	

endmodule
	
	
module PG_gen(p,g,P,G);
	
		input [3:0] p,g;
		output P,G;
		
		assign P=p[0] & p[1] & p[2] & p[3];
		assign G=(g[0] & p[1] & p[2] & p[3])|(g[1]&p[2]&p[3])|(g[2]&p[3])|g[3];
		
endmodule
	
module carry_gennerator(p,g,cin,cout);
	
	    input [3:0] p,g;
		input cin;
		output [3:1] cout;
		
		assign cout[1] = g[0]|(p[0] & cin);
	    assign cout[2] = g[1]|(p[1] & g[0])|(p[1] & p[0] & cin);
	    assign cout[3] = g[2]|(p[2] & g[1])|(p[2] & p[1] & g[0])|(p[2] & p[1] & p[0] & cin);
		
		
endmodule

module cout_gen(P,G,cin,cout);
       input [3:0] P,G;
	   input cin;
	   output [3:0] cout;
	   
	   assign cout[0] = G[0]|(P[0] & cin);
	   assign cout[1] = G[1]|(P[1] & G[0])|(P[1] & P[0] & cin);
	   assign cout[2] = G[2]|(P[2] & G[1])|(P[2] & P[1] & G[0])|(P[2] & P[1] & P[0] & cin);
	   assign cout[3] = G[3]|(P[3] & G[2])|(P[3] & P[2] & G[1])|(P[3] & P[2] & P[1] & G[0])|(P[3] & P[2] & P[1] & P[0] & cin);
endmodule
	
module sum_generator(a,b,cin,c,sum);

     input [63:0] a,b;
	 input cin;
	 input [63:1] c;
	 output	[63:0] sum;

		
	 assign sum = a^ b^{c,cin};
		
endmodule
	
module pg_gen(a,b,p,g);
	
	    input [63:0] a,b;
		output [63:0] p,g;
		
		assign p=a|b;
		assign g=a&b;
		
endmodule



`timescale 1ns/1ps

module lab(
	CLK, 
	RST,
	en,
	in_a, 
	in_b, 
	Product
);
// in_a * in_b = Product
// in_a is Multiplicand , in_b is Multiplier
					

input 			CLK, RST;
input			en;
input  	[7:0]	in_a;			// Multiplicand
input  	[7:0]	in_b;			// Multiplier
output	[15:0]  	Product;

reg  [24:0] Mplicand;		
reg signed [24:0]	Product_booth;
reg 		  [2:0]  Counter;
//reg [15:0] Product;
assign Product = Product_booth[16:1];
reg mpy_done;

always @(posedge CLK or posedge RST) begin
	if(RST)
		mpy_done <= 1'b1;
	else if(en)
		mpy_done <= 1'b0;
	else if(Counter==3'd6)
		mpy_done <= 1'b1;
	else
		mpy_done <= mpy_done;
end
//Counter
always @(posedge CLK or posedge RST)
begin
	if (RST)
		Counter <= 3'b0;
	else if (~mpy_done)
		Counter <= Counter + 1'b1;
	else
		Counter <= Counter;
end

//Product
always @(posedge CLK or posedge RST)
begin
	if (RST) begin
		Product_booth  <= 25'b0;
		Mplicand <= 25'b0;
	end

	else if (Counter == 3'd1) begin
	    if(in_a[7]==0)
		   Mplicand <= {8'b0,in_a, 9'b0};
		else
		   Mplicand<= {8'b11111111,in_a,9'b0};
		Product_booth <= {16'b0, in_b, 1'b0};	
	end
	
	else if (Counter <= 3'd5)begin
	
	  	  
	  if (Product_booth[2]==0 && Product_booth[1]==0 && Product_booth[0]==1)begin
	       Product_booth=Product_booth + Mplicand;
	  end
	  
	  else if (Product_booth[2]==0 && Product_booth[1]==1 && Product_booth[0]==0)begin
	       Product_booth=Product_booth + Mplicand;
	  end
	  
	  else if (Product_booth[2]==0 && Product_booth[1]==1 && Product_booth[0]==1)begin
	       Product_booth=Product_booth + Mplicand*2;
	  end
	  
	  else if (Product_booth[2]==1 && Product_booth[1]==0 && Product_booth[0]==0)begin
	       Product_booth=Product_booth - Mplicand*2;
	  end
	  
	  else if (Product_booth[2]==1 && Product_booth[1]==0 && Product_booth[0]==1)begin
	       Product_booth=Product_booth - Mplicand;
	  end
	  
	  else if (Product_booth[2]==1 && Product_booth[1]==1 && Product_booth[0]==0)begin
	       Product_booth=Product_booth - Mplicand;
	  end
	  
	  
	  Product_booth = Product_booth >> 2'd2;
	
	end
	else begin
		Product_booth <= Product_booth;
		Mplicand <= Mplicand;
	end
end



endmodule

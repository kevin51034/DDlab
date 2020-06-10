//以前者(1ns)為單位，以後者(1ps)的時間，查看一次電路的行為
`timescale 1ns/1ps

//宣告module名稱,輸出入名稱
module lab9_hw(
	CLK, 
	RST, 
	in_a, 
	in_b, 
	Product, 
	Product_Valid
);
// in_a * in_b = Product
// in_a is Multiplicand , in_b is Multiplier
					
//定義port, 包含input, output
input 			CLK, RST;
input 	[7:0]	in_a;			// Multiplicand
input 	[7:0]	in_b;			// Multiplier
output 	[15:0]  Product;
output  		Product_Valid;

reg 	[7:0]	Mplicand;		//被乘數
reg 	[15:0]	Product;
reg 			Product_Valid;
reg 	[5:0]	Counter ;

//Counter
always @(posedge CLK or posedge RST)
begin
	if (RST)
		Counter <= 6'b0;
	else
		Counter <= Counter + 6'b1;
end

//Product
always @(posedge CLK or posedge RST)
begin
	//初始化數值
	if (RST) begin
		Product  <= 16'b0;
		Mplicand <= 8'b0;
	end

	//輸入結果與被乘數
	else if (Counter == 6'd0) begin
			//write your code here

	end
	
	//乘法與數值移位
	else if (Counter < 6'd8)begin
		if (Product[0] == 1'b1)
			//write your code here

	end
	
	//給定結果正負號
	//當計算到最後一次的時候
	else if (Counter == 6'd8)begin
		if (Product[0] == 1'b1)
			//write your code here

	end
	
	else begin
		Product 	<= Product;
		Mplicand	<= Mplicand;
	end
end

//Product_Valid
always @(posedge CLK or posedge RST)
begin
	if (RST)
		Product_Valid <=1'b0;
	else if (Counter==6'd9)
		Product_Valid <=1'b1;
	else
		Product_Valid <=1'b0;
end

endmodule

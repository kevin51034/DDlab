`timescale 1ns / 1ps
module top(
    input CLK100MHZ,//clk
    input [15:0]SW,
    input BTNC,
    output reg [5:0]LED
    );
        //reg LED

    /*****your design******/
     always@(posedge CLK100MHZ)
	 begin
		if(BTNC == 1'b1)
		//always@(BTNC)
		begin
			//wire [3:0] a, b, c, d;
			//wire [5:0] sum;
			//assign a = SW[3:0];
			//assign b = SW[7:4];
			//assign c = SW[11:8];
			//assign d = SW[15:12];
		     LED <= SW[3:0] + SW[7:4] + SW[11:8] + SW[15:12];
			//assign LED = sum;
		end
		else
		begin
		     LED <= LED;
		end
	end
    /**********************/
endmodule

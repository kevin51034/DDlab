module lab5_birth(	
		input [2:0] cnt,
		output reg[3:0] birth_num,
		output reg [6:0] seg_data
	);

//**CODE_CONVERTER**//

	
always@(*) begin
	case(cnt)
       3'b000:birth_num = 4'd1;
	   3'b001:birth_num = 4'd9;
	   3'b010:birth_num = 4'd9;
	   3'b011:birth_num = 4'd8;
	   3'b100:birth_num = 4'd0;
	   3'b101:birth_num = 4'd1;
	   3'b110:birth_num = 4'd0;
	   3'b111:birth_num = 4'd3;
	  endcase
end
/////////////////////


//**BCD_to_7SEG**//
always@(*) begin
case(birth_num)
	4'd0:seg_data <= 7'b100_0000;
	4'd1:seg_data <= 7'b111_1001;
	4'd2:seg_data <= 7'b010_0100;
	4'd3:seg_data <= 7'b011_0000;
	4'd4:seg_data <= 7'b001_1001;
	4'd5:seg_data <= 7'b001_0010;
	4'd6:seg_data <= 7'b000_0010;
	4'd7:seg_data <= 7'b101_1000;
	4'd8:seg_data <= 7'b000_0000;
	4'd9:seg_data <= 7'b001_0000;
	default: birth_num <= birth_num;
 endcase
 end
///////////////////
	
endmodule
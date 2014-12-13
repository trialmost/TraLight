module TubeDecoder(
    DecimalValue,
	 TubeValue
);
    input [3:0] DecimalValue;
	 output [7:0] TubeValue;
	 reg [7:0] TubeValue;
	 always @(DecimalValue)
	     begin
		      case(DecimalValue)
				    0:TubeValue<=8'b00111111;
					 1:TubeValue<=8'b00000110;
					 2:TubeValue<=8'b01011011;
					 3:TubeValue<=8'b01001111;
					 4:TubeValue<=8'b01100110;
					 5:TubeValue<=8'b01101101;
					 6:TubeValue<=8'b01111101;
					 7:TubeValue<=8'b00000111;
					 8:TubeValue<=8'b01111111;
					 9:TubeValue<=8'b01101111;
					 default:TubeValue<=8'b00000000;
				 endcase
		  end
endmodule
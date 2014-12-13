module TubeControl(
	clk,
	rst,
	//计数器值输入
	count,
	//数码管输出,高三位选择数码管,10 9 8 7 6 5 4 3 2 1 0
	tube_11bit
);
	input clk,rst;
	input [5:0] count;
	output [10:0] tube_11bit;
	reg [10:0] tube_11bit;
	wire [7:0] count_bcd;
	wire [7:0] tube_high;
	wire [7:0] tube_low;
	Bin2Bcd btb(
		.data_in(count),
		.data_out(count_bcd));
	TubeDecoder td1(
		.DecimalValue(count_bcd[7:4]),
		.TubeValue(tube_high)
		);
	TubeDecoder td2(
		.DecimalValue(count_bcd[3:0]),
		.TubeValue(tube_low)
	);
	
	always @(posedge clk)
		begin
			if(tube_11bit[10:8]<2)
				tube_11bit[10:8]<=tube_11bit[10:8]+1;
			else
				tube_11bit[10:8]<=0;
		end
	always @(tube_11bit[10:8])
		case(tube_11bit[10:8])
			0:tube_11bit[7:0]<=tube_high;
			1:tube_11bit[7:0]<=tube_low;
			default:tube_11bit[7:0]<=8'b00000000;
		endcase
endmodule
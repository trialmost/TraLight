module Counter(
	clk,
	rst,
	current_state,
	
	//乡道传感器状态
	c_sensor_state,
	
	//计数器当前值
	count,
	
	//计时完成进位
	carry_flag
	
);
	input clk,rst,c_sensor_state;
	input [1:0] current_state;
	output [5:0] count;
	reg [5:0] count;
	output carry_flag;
	reg carry_flag;
	wire div_clk;
	
	parameter mgcr=0,
			 mycr=1,
			 mrcg=2,
			 mrcy=3;
	//实例化分频
	DivFreq fdiv(
		.clk(clk),
		.clk_out(div_clk)
	);
	
	always @(posedge div_clk or negedge rst)
		if(!rst)
			begin
				count<=60;
				carry_flag<=0;
			end
		else
			begin
				case(current_state)
					mgcr:
						begin
							if(count!=1)
								begin
									count<=count-1;
									carry_flag<=0;
								end
							else
								begin
									carry_flag<=1;
									if(c_sensor_state==1)
										count<=4;
									else
										count<=60;
								end
						end
						
					mycr:
						begin
							if(count!=1)
								begin
									count<=count-1;
									carry_flag<=0;
								end
							else
								begin
									carry_flag<=1;
									if(c_sensor_state==1)
										count<=20;
									else
										count<=4;
								end
						end
					
					mrcg:
						begin
							if(c_sensor_state==0)
								begin
									carry_flag<=1;
									count<=4;
								end
							else if(c_sensor_state && count!=1)
								begin
									count<=count-1;
									carry_flag<=0;
								end
							else
								begin
									carry_flag<=1;
									count<=4;
								end
						end
					
					mrcy:
						begin
							if(count!=1)
								begin
									count<=count-1;
									carry_flag<=0;
								end
							else
								begin
									carry_flag<=1;
									count<=60;
								end
						end
				endcase	
			end
			
	
endmodule
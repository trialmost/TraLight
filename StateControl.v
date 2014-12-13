module StateControl(
	clk,
	rst,
	
	//乡道传感器状态
	c_sensor_state,
	
	//计数器进位状态
	counter_carry_flag,
	
	//当前状态
	current_state
);
input clk,rst,c_sensor_state,counter_carry_flag;
output [1:0] current_state;
reg [1:0] current_state;
parameter mgcr=0,
			 mycr=1,
			 mrcg=2,
			 mrcy=3;
wire div_clk;
	//实例化分频
DivFreq fdiv(
	.clk(clk),
	.clk_out(div_clk)
);

always @(posedge div_clk or negedge rst)
	begin
		if(!rst)
			current_state<=mgcr;
		else
			case(current_state)
				mgcr:
					begin
						if(c_sensor_state==1 && counter_carry_flag==1)
							current_state<=mycr;
						else
							current_state<=mgcr;
					end
					
				mycr:
					begin
						if(counter_carry_flag==1)
							current_state<=mrcg;
						else
							current_state<=mycr;
					end
				
				mrcg:
					begin
						if(c_sensor_state==0 && counter_carry_flag==1)
							current_state<=mrcy;
						else if(c_sensor_state==1 && counter_carry_flag==1)
							current_state<=mrcy;
						else
							current_state<=mrcg;
//						if(counter_carry_flag==1)
//							current_state<=mrcy;
//						else
//							current_state<=mrcg;
					end
				
				mrcy:
					begin
						if(counter_carry_flag==1)
							current_state<=mgcr;
						else
							current_state<=mrcy;
					end
			endcase		
	end
endmodule
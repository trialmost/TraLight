module TraLight(
	clk,
	rst,
	
	//乡道传感器状态
	c_sensor_state,
	
	//主道交通灯输出RYG
	m_light_3bit,
	
	//乡道交通灯输出RYG
	c_light_3bit,
	
	//数码管输出,高三位选择数码管
	tube_11bit
);
	input clk,rst,c_sensor_state;
	output [2:0] m_light_3bit;
	output [2:0] c_light_3bit;
	output [10:0] tube_11bit;
	wire [1:0] current_state;
	wire carry_flag;
	wire [5:0] count;
	
	Counter cnt(
		.clk(clk),
		.rst(rst),
		.current_state(current_state),
		.c_sensor_state(c_sensor_state),
		.carry_flag(carry_flag),
		.count(count)
	);
	
	StateControl statectl(
		.clk(clk),
		.rst(rst),
		.c_sensor_state(c_sensor_state),
		.counter_carry_flag(carry_flag),
		.current_state(current_state)
	);
	
	LightControl lightctl(
		.clk(clk),
		.current_state(current_state),
		.m_light_3bit(m_light_3bit),
		.c_light_3bit(c_light_3bit)
	);
	
	TubeControl tubectl(
		.clk(clk),
		.rst(rst),
		.count(count),
		.tube_11bit(tube_11bit)
	);

endmodule
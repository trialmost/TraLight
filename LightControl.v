module LightControl(
	clk,
	
	//交通灯状态输入
	current_state,
	
	//主道交通灯输出RYG
	m_light_3bit,
	
	//乡道交通灯输出RYG
	c_light_3bit
);
	input clk;
	input [1:0] current_state;
	output [2:0] m_light_3bit;
	reg [2:0] m_light_3bit;
	output [2:0] c_light_3bit;
	reg [2:0] c_light_3bit;
	wire div_clk;
	//实例化分频
	DivFreq fdiv(
		.clk(clk),
		.clk_out(div_clk)
	);
	
	always @(posedge div_clk)
		begin
			case(current_state)
				0:begin m_light_3bit=3'b001;c_light_3bit=3'b100; end
				1:begin m_light_3bit=3'b010;c_light_3bit=3'b100; end
				2:begin m_light_3bit=3'b100;c_light_3bit=3'b001; end
				3:begin m_light_3bit=3'b100;c_light_3bit=3'b010; end
				default:begin m_light_3bit=3'b001;c_light_3bit=3'b100; end
			endcase
		end
endmodule
module DivFreq(clk,clk_out);
	input            clk ;
	wire            clk ;
	output clk_out;
	reg        [9:0]    count ;
	reg clk_out ;
	always @ ( posedge clk)
    	begin
			count=count+1;
         if ( count == 9 )
				begin
            	clk_out <= 1;
					count=0;
            end
         else 
				clk_out<=0;
    	end
endmodule
//-----------------------------------------------------------------------------------
// DESCRIPTION   :  Bin to Bcd converter
//                  Input (data_in) width : 4
//                  Output (data_out) width : 8
//                  Enable (EN) active : high
//
//-----------------------------------------------------------------------------------

module Bin2Bcd (data_in,data_out );
	input [5:0] data_in ;
	output [7:0] data_out ;
	assign data_out[7:4]=data_in/10;
	assign data_out[3:0]=data_in%10;
endmodule
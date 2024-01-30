`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/21 12:00:52
// Design Name: 
// Module Name: tb_delay
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_Interpolation

(

    );
	
		reg clk;
		reg rst_n;


wire 			[17:0]			data_Interp			;//数据总线			      						        


                 
			
	initial 
	begin

		clk = 1'b1;
		rst_n= 1'b0;

		#20 rst_n= 1'b1; //复位
	
	end	 
	always #1 clk = ~clk;
Interpolation_top  Interpolation_top_inst
(
            .clk                (clk     )     ,
            .rst_n              (rst_n   )     ,	

            .data_Interp  (data_Interp) // 插值后     	
);  
	

endmodule





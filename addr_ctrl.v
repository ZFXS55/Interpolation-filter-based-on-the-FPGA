`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/04 18:51:05
// Design Name: 
// Module Name: addr_ctrl
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


module addr_ctrl(
    input clk,
    input rst_n,
    output [7:0] addr_data,
    output [7:0] addr_factor
       
    );
    reg [7 :0]cnt;  //计数器，通常计25个数输出一个数据地址
    reg [7 :0]addr_data_pre  ;
assign addr_data = addr_data_pre;
assign addr_factor = cnt;
    always@(posedge clk or negedge rst_n)
    begin
         if(rst_n == 0)
         begin
             cnt <= 0;
         end
         else if(cnt ==8'd24 )
             cnt <= 0;
         else
             cnt <= cnt + 1; 
    end
        
    always@(posedge clk or negedge rst_n)
    begin
         if(rst_n == 0)
         begin
         addr_data_pre <= 0;
         end
         else if(cnt ==8'd24 )
         addr_data_pre <= addr_data_pre + 1;
         else
         addr_data_pre <= addr_data_pre; 
    end

endmodule

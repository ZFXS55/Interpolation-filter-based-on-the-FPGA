`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:34:59 12/4/2023 
// Design Name: 
// Module Name:    现在结构对了，就剩下滤波器系数了，100个无符号数应该是，并且是8位的，存到coe文件里就OK了
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Interpolation_top

(
input                                        clk          ,
input                                        rst_n          ,
output                 [17 :0]                data_Interp // 插值后     	
);  

wire   [7:0] addr_data;  //数据地址
wire   [7:0] addr_factor;//系数地址
wire   [7:0] data_source;//波形数据插值前

 //地址控制       
addr_ctrl  addr_ctrl_inst(
    .clk     (clk  ),
    .rst_n   (rst_n),
    .addr_data (addr_data),
    .addr_factor (addr_factor)      
    );   
        
   //正弦波rom,内部是256x8bit的波形
dist_mem_sin_256x8bit dist_mem_sin_256x8bit_inst (
  .a(addr_data),      // input wire [7 : 0] a
  .spo(data_source)  // output wire [7 : 0] spo
);     
    //运算单元    
 con_process con_process_inst(
    .clk     (clk),
    .rst_n    (rst_n),
    .addr_data (addr_data),
    .addr_factor (addr_factor),
    .data_source (data_source),
    .dataout (data_Interp)
    );        
           
endmodule









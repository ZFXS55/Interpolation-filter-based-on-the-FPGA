`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:34:59 12/4/2023 
// Design Name: 
// Module Name:    ���ڽṹ���ˣ���ʣ���˲���ϵ���ˣ�100���޷�����Ӧ���ǣ�������8λ�ģ��浽coe�ļ����OK��
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
output                 [17 :0]                data_Interp // ��ֵ��     	
);  

wire   [7:0] addr_data;  //���ݵ�ַ
wire   [7:0] addr_factor;//ϵ����ַ
wire   [7:0] data_source;//�������ݲ�ֵǰ

 //��ַ����       
addr_ctrl  addr_ctrl_inst(
    .clk     (clk  ),
    .rst_n   (rst_n),
    .addr_data (addr_data),
    .addr_factor (addr_factor)      
    );   
        
   //���Ҳ�rom,�ڲ���256x8bit�Ĳ���
dist_mem_sin_256x8bit dist_mem_sin_256x8bit_inst (
  .a(addr_data),      // input wire [7 : 0] a
  .spo(data_source)  // output wire [7 : 0] spo
);     
    //���㵥Ԫ    
 con_process con_process_inst(
    .clk     (clk),
    .rst_n    (rst_n),
    .addr_data (addr_data),
    .addr_factor (addr_factor),
    .data_source (data_source),
    .dataout (data_Interp)
    );        
           
endmodule









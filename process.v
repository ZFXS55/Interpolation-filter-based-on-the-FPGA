`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/04 19:53:37
// Design Name: 
// Module Name: process
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


module con_process(
    input clk,
    input rst_n,
    input [7:0] addr_data,
    input [7:0] addr_factor,
    input [7:0] data_source,
    output[17 : 0] dataout
    );
    reg [7:0]data_source_pre0;
    reg [7:0]data_source_pre1;
    reg [7:0]data_source_pre2;
    reg [7:0]data_source_pre3;
//打拍后的数据，送入乘法器
    wire [7:0]data_source_pre0_a;
    wire [7:0]data_source_pre1_a;
    wire [7:0]data_source_pre2_a;
    wire [7:0]data_source_pre3_a;    
    assign     data_source_pre0_a = data_source_pre0;
    assign     data_source_pre1_a = data_source_pre1;
    assign     data_source_pre2_a = data_source_pre2;
    assign     data_source_pre3_a = data_source_pre3;    
  //乘法器输入    
    wire [7 : 0] B0;
    wire [7 : 0] B1;
    wire [7 : 0] B2;
    wire [7 : 0] B3;
 //乘法器结果   
    wire [15 : 0] P0;
    wire [15 : 0] P1;
    wire [15 : 0] P2;
    wire [15 : 0] P3;
    always@(posedge clk or negedge rst_n)
    begin
    if(rst_n == 0)
    begin
    data_source_pre0 <= 0;
    data_source_pre1 <= 0;
    data_source_pre2 <= 0;
    data_source_pre3 <= 0;
    end
    else if(addr_factor == 8'd24)
    begin
    data_source_pre0 <= data_source;
    data_source_pre1 <= data_source_pre0;
    data_source_pre2 <= data_source_pre1;
    data_source_pre3 <= data_source_pre2;
    end
    else
    begin
    data_source_pre0 <= data_source_pre0;
    data_source_pre1 <= data_source_pre1;
    data_source_pre2 <= data_source_pre2;
    data_source_pre3 <= data_source_pre3;
    end
    end
 
 //----------- 第0组滤波器系数 ------------// 
dist_mem_filter_factor_check dist_mem_filter_factor_check_inst_0 (
  .a(addr_factor[6:0]),      // input wire [6 : 0] a
  .spo(B0)  // output wire [7 : 0] spo
);
 //----------- 第1组滤波器系数 -----------// 
dist_mem_filter_factor_check dist_mem_filter_factor_check_inst_1 (
  .a(addr_factor[6:0]+7'd25),      // input wire [6 : 0] a
  .spo(B1)  // output wire [7 : 0] spo
);
 //----------- 第2组滤波器系数 -----------// 
dist_mem_filter_factor_check dist_mem_filter_factor_check_inst_2 (
  .a(addr_factor[6:0]+7'd50),      // input wire [6 : 0] a
  .spo(B2)  // output wire [7 : 0] spo
);
 //----------- 第3组滤波器系数 -----------// 
dist_mem_filter_factor_check dist_mem_filter_factor_check_inst_3 (
  .a(addr_factor[6:0]+7'd75),      // input wire [6 : 0] a
  .spo(B3)  // output wire [7 : 0] spo
);
 
   //----------- 第0组乘法器 -----------// 
mult_gen_0 mult_gen_0_inst (
  .CLK(clk),  // input wire CLK
  .A(data_source_pre0_a),      // input wire [7 : 0] A
  .B(B0),      // input wire [7 : 0] B
  .P(P0)      // output wire [15 : 0] P
); 
   //----------- 第1组乘法器 -----------// 
mult_gen_0 mult_gen_1_inst (
  .CLK(clk),  // input wire CLK
  .A(data_source_pre1_a),      // input wire [7 : 0] A
  .B(B1),      // input wire [7 : 0] B
  .P(P1)      // output wire [15 : 0] P
); 
   //----------- 第2组乘法器 -----------// 
mult_gen_0 mult_gen_2_inst (
  .CLK(clk),  // input wire CLK
  .A(data_source_pre2_a),      // input wire [7 : 0] A
  .B(B2),      // input wire [7 : 0] B
  .P(P2)      // output wire [15 : 0] P
); 
   //----------- 第3组乘法器 -----------// 
mult_gen_0 mult_gen_3_inst (
  .CLK(clk),  // input wire CLK
  .A(data_source_pre3_a),      // input wire [7 : 0] A
  .B(B3),      // input wire [7 : 0] B
  .P(P3)      // output wire [15 : 0] P
); 
  
 assign  dataout =P0 + P1 + P2 + P3;  //求和
endmodule

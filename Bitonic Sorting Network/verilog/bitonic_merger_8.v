`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/08 14:20:41
// Design Name: 
// Module Name: bitonic_merger_8
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


module bitonic_merger_8(
    input wire [7:0] in_0,
    input wire [7:0] in_1,
    input wire [7:0] in_2,
    input wire [7:0] in_3,
    input wire [7:0] in_4,
    input wire [7:0] in_5,
    input wire [7:0] in_6,
    input wire [7:0] in_7,
    input wire clk,
    input wire rst_n,
    input wire enable,
    output wire [7:0] out_0,
    output wire [7:0] out_1,
    output wire [7:0] out_2,
    output wire [7:0] out_3,
    output wire [7:0] out_4,
    output wire [7:0] out_5,
    output wire [7:0] out_6,
    output wire [7:0] out_7
    );
    
    wire [7:0] net_0 [0:7];
    wire [7:0] net_1 [0:7];
    
    compare_swap_unit_8bits c0(.A(in_0), .B(in_7), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[0]), .max(net_0[7]));
    compare_swap_unit_8bits c1(.A(in_1), .B(in_6), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[1]), .max(net_0[6]) );
    compare_swap_unit_8bits c2(.A(in_2), .B(in_5), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[2]), .max(net_0[5]));
    compare_swap_unit_8bits c3(.A(in_3), .B(in_4), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[3]), .max(net_0[4]));
    
    compare_swap_unit_8bits c4(.A(net_0[0]), .B(net_0[2]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_1[0]), .max(net_1[2]));
    compare_swap_unit_8bits c5(.A(net_0[1]), .B(net_0[3]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_1[1]), .max(net_1[3]));
    compare_swap_unit_8bits c6(.A(net_0[4]), .B(net_0[6]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_1[4]), .max(net_1[6]));  
    compare_swap_unit_8bits c7(.A(net_0[5]), .B(net_0[7]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_1[5]), .max(net_1[7]));
    
    compare_swap_unit_8bits c8 (.A(net_1[0]), .B(net_1[1]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(out_0), .max(out_1));
    compare_swap_unit_8bits c9 (.A(net_1[2]), .B(net_1[3]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(out_2), .max(out_3));
    compare_swap_unit_8bits c10(.A(net_1[4]), .B(net_1[5]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(out_4), .max(out_5));
    compare_swap_unit_8bits c11(.A(net_1[6]), .B(net_1[7]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(out_6), .max(out_7));
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/08 14:42:34
// Design Name: 
// Module Name: bitonic_merger_16
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


module bitonic_merger_16(
    input wire [7:0] in_0,
    input wire [7:0] in_1,
    input wire [7:0] in_2,
    input wire [7:0] in_3,
    input wire [7:0] in_4,
    input wire [7:0] in_5,
    input wire [7:0] in_6,
    input wire [7:0] in_7,
    input wire [7:0] in_8,
    input wire [7:0] in_9,
    input wire [7:0] in_10,
    input wire [7:0] in_11,
    input wire [7:0] in_12,
    input wire [7:0] in_13,
    input wire [7:0] in_14,
    input wire [7:0] in_15,
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
    output wire [7:0] out_7,
    output wire [7:0] out_8,
    output wire [7:0] out_9,
    output wire [7:0] out_10,
    output wire [7:0] out_11,
    output wire [7:0] out_12,
    output wire [7:0] out_13,
    output wire [7:0] out_14,
    output wire [7:0] out_15
    );
    
    wire [7:0] net_0 [0:15];
    wire [7:0] net_1 [0:15];
    wire [7:0] net_2 [0:15];
    
    compare_swap_unit_8bits c0(.A(in_0), .B(in_15), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[0]), .max(net_0[15]));
    compare_swap_unit_8bits c1(.A(in_1), .B(in_14), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[1]), .max(net_0[14]));
    compare_swap_unit_8bits c2(.A(in_2), .B(in_13), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[2]), .max(net_0[13]));
    compare_swap_unit_8bits c3(.A(in_3), .B(in_12), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[3]), .max(net_0[12]));
    compare_swap_unit_8bits c4(.A(in_4), .B(in_11), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[4]), .max(net_0[11]));
    compare_swap_unit_8bits c5(.A(in_5), .B(in_10), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[5]), .max(net_0[10]));
    compare_swap_unit_8bits c6(.A(in_6), .B(in_9 ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[6]), .max(net_0[9] ));
    compare_swap_unit_8bits c7(.A(in_7), .B(in_8 ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[7]), .max(net_0[8] ));
    
    compare_swap_unit_8bits c8 (.A(net_0[0] ), .B(net_0[4] ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_1[0] ), .max(net_1[4] ));
    compare_swap_unit_8bits c9 (.A(net_0[1] ), .B(net_0[5] ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_1[1] ), .max(net_1[5] ));
    compare_swap_unit_8bits c10(.A(net_0[2] ), .B(net_0[6] ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_1[2] ), .max(net_1[6] ));
    compare_swap_unit_8bits c11(.A(net_0[3] ), .B(net_0[7] ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_1[3] ), .max(net_1[7] ));
    compare_swap_unit_8bits c12(.A(net_0[8] ), .B(net_0[12]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_1[8] ), .max(net_1[12]));
    compare_swap_unit_8bits c13(.A(net_0[9] ), .B(net_0[13]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_1[9] ), .max(net_1[13]));
    compare_swap_unit_8bits c14(.A(net_0[10]), .B(net_0[14]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_1[10]), .max(net_1[14]));
    compare_swap_unit_8bits c15(.A(net_0[11]), .B(net_0[15]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_1[11]), .max(net_1[15]));
    
    compare_swap_unit_8bits c16(.A(net_1[0] ), .B(net_1[2] ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_2[0] ), .max(net_2[2] ));
    compare_swap_unit_8bits c17(.A(net_1[1] ), .B(net_1[3] ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_2[1] ), .max(net_2[3] ));
    compare_swap_unit_8bits c18(.A(net_1[4] ), .B(net_1[6] ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_2[4] ), .max(net_2[6] ));
    compare_swap_unit_8bits c19(.A(net_1[5] ), .B(net_1[7] ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_2[5] ), .max(net_2[7] ));
    compare_swap_unit_8bits c20(.A(net_1[8] ), .B(net_1[10]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_2[8] ), .max(net_2[10]));
    compare_swap_unit_8bits c21(.A(net_1[9] ), .B(net_1[11]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_2[9] ), .max(net_2[11]));
    compare_swap_unit_8bits c22(.A(net_1[12]), .B(net_1[14]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_2[12]), .max(net_2[14]));
    compare_swap_unit_8bits c23(.A(net_1[13]), .B(net_1[15]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_2[13]), .max(net_2[15]));
    
    compare_swap_unit_8bits c24(.A(net_2[0] ), .B(net_2[1] ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(out_0 ), .max(out_1 ));
    compare_swap_unit_8bits c25(.A(net_2[2] ), .B(net_2[3] ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(out_2 ), .max(out_3 ));
    compare_swap_unit_8bits c26(.A(net_2[4] ), .B(net_2[5] ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(out_4 ), .max(out_5 ));
    compare_swap_unit_8bits c27(.A(net_2[6] ), .B(net_2[7] ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(out_6 ), .max(out_7 ));
    compare_swap_unit_8bits c28(.A(net_2[8] ), .B(net_2[9] ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(out_8 ), .max(out_9 ));
    compare_swap_unit_8bits c29(.A(net_2[10]), .B(net_2[11]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(out_10), .max(out_11));
    compare_swap_unit_8bits c30(.A(net_2[12]), .B(net_2[13]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(out_12), .max(out_13));
    compare_swap_unit_8bits c31(.A(net_2[14]), .B(net_2[15]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(out_14), .max(out_15));
endmodule

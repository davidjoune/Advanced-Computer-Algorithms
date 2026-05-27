`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/08 15:24:30
// Design Name: 
// Module Name: bitonic_sorter_16
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


module bitonic_sorter_16(
    input wire [127:0] in,
    input wire clk,
    input wire rst_n,
    input wire enable,
    output wire [127:0] out
    );
    
    wire [7:0] net_0 [0:15];
    wire [7:0] net_1 [0:15];
    wire [7:0] net_2 [0:15];
    
    //stage1
    compare_swap_unit_8bits c0(.A(in[7:0]    ), .B(in[15:8]   ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[0] ), .max(net_0[1] ));
    compare_swap_unit_8bits c1(.A(in[23:16]  ), .B(in[31:24]  ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[2] ), .max(net_0[3] ));
    compare_swap_unit_8bits c2(.A(in[39:32]  ), .B(in[47:40]  ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[4] ), .max(net_0[5] ));
    compare_swap_unit_8bits c3(.A(in[55:48]  ), .B(in[63:56]  ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[6] ), .max(net_0[7] ));
    compare_swap_unit_8bits c4(.A(in[71:64]  ), .B(in[79:72]  ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[8] ), .max(net_0[9] ));
    compare_swap_unit_8bits c5(.A(in[87:80]  ), .B(in[95:88]  ), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[10]), .max(net_0[11]));
    compare_swap_unit_8bits c6(.A(in[103:96] ), .B(in[111:104]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[12]), .max(net_0[13]));
    compare_swap_unit_8bits c7(.A(in[119:112]), .B(in[127:120]), .clk(clk), .rst_n(rst_n), .enable(enable), .min(net_0[14]), .max(net_0[15]));
    
    //stage2~3
    bitonic_merger_4 b4_0(.in_0(net_0[0]),
                          .in_1(net_0[1]),
                          .in_2(net_0[2]),
                          .in_3(net_0[3]),
                          .clk(clk),
                          .rst_n(rst_n),
                          .enable(enable),
                          .out_0(net_1[0]),
                          .out_1(net_1[1]),
                          .out_2(net_1[2]),
                          .out_3(net_1[3]));
    bitonic_merger_4 b4_1(.in_0(net_0[4]),
                          .in_1(net_0[5]),
                          .in_2(net_0[6]),
                          .in_3(net_0[7]),
                          .clk(clk),
                          .rst_n(rst_n),
                          .enable(enable),
                          .out_0(net_1[4]),
                          .out_1(net_1[5]),
                          .out_2(net_1[6]),
                          .out_3(net_1[7]));
    bitonic_merger_4 b4_2(.in_0(net_0[8]),
                          .in_1(net_0[9]),
                          .in_2(net_0[10]),
                          .in_3(net_0[11]),
                          .clk(clk),
                          .rst_n(rst_n),
                          .enable(enable),
                          .out_0(net_1[8]),
                          .out_1(net_1[9]),
                          .out_2(net_1[10]),
                          .out_3(net_1[11]));
    bitonic_merger_4 b4_3(.in_0(net_0[12]),
                          .in_1(net_0[13]),
                          .in_2(net_0[14]),
                          .in_3(net_0[15]),
                          .clk(clk),
                          .rst_n(rst_n),
                          .enable(enable),
                          .out_0(net_1[12]),
                          .out_1(net_1[13]),
                          .out_2(net_1[14]),
                          .out_3(net_1[15]));
    
    //stage4~6
    bitonic_merger_8 b8_0(.in_0(net_1[0]),
                          .in_1(net_1[1]),
                          .in_2(net_1[2]),
                          .in_3(net_1[3]),
                          .in_4(net_1[4]),
                          .in_5(net_1[5]),
                          .in_6(net_1[6]),
                          .in_7(net_1[7]),
                          .clk(clk),
                          .rst_n(rst_n),
                          .enable(enable),
                          .out_0(net_2[0]),
                          .out_1(net_2[1]),
                          .out_2(net_2[2]),
                          .out_3(net_2[3]),
                          .out_4(net_2[4]),
                          .out_5(net_2[5]),
                          .out_6(net_2[6]),
                          .out_7(net_2[7]));
    bitonic_merger_8 b8_1(.in_0(net_1[8] ),
                          .in_1(net_1[9] ),
                          .in_2(net_1[10]),
                          .in_3(net_1[11]),
                          .in_4(net_1[12]),
                          .in_5(net_1[13]),
                          .in_6(net_1[14]),
                          .in_7(net_1[15]),
                          .clk(clk),
                          .rst_n(rst_n),
                          .enable(enable),
                          .out_0(net_2[8] ),
                          .out_1(net_2[9] ),
                          .out_2(net_2[10]),
                          .out_3(net_2[11]),
                          .out_4(net_2[12]),
                          .out_5(net_2[13]),
                          .out_6(net_2[14]),
                          .out_7(net_2[15]));
    
    //stage7~10
    bitonic_merger_16 b16_0(.in_0(net_2[0]),
                            .in_1(net_2[1]),
                            .in_2(net_2[2]),
                            .in_3(net_2[3]),
                            .in_4(net_2[4]),
                            .in_5(net_2[5]),
                            .in_6(net_2[6]),
                            .in_7(net_2[7]),
                            .in_8(net_2[8]),
                            .in_9(net_2[9]),
                            .in_10(net_2[10]),
                            .in_11(net_2[11]),
                            .in_12(net_2[12]),
                            .in_13(net_2[13]),
                            .in_14(net_2[14]),
                            .in_15(net_2[15]),
                            .clk(clk),
                            .rst_n(rst_n),
                            .enable(enable),
                            .out_0(out[7:0]),
                            .out_1(out[15:8]),
                            .out_2(out[23:16]),
                            .out_3(out[31:24]),
                            .out_4(out[39:32]),
                            .out_5(out[47:40]),
                            .out_6(out[55:48]),
                            .out_7(out[63:56]),
                            .out_8(out[71:64]),
                            .out_9(out[79:72]),
                            .out_10(out[87:80]),
                            .out_11(out[95:88]),
                            .out_12(out[103:96]),
                            .out_13(out[111:104]),
                            .out_14(out[119:112]),
                            .out_15(out[127:120]));

endmodule

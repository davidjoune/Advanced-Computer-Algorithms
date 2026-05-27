`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/08 13:15:08
// Design Name: 
// Module Name: bitonic_merger_4
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


module bitonic_merger_4(
    input wire [7:0] in_0,
    input wire [7:0] in_1,
    input wire [7:0] in_2,
    input wire [7:0] in_3,
    input wire clk,
    input wire rst_n,
    input wire enable,
    output wire [7:0] out_0,
    output wire [7:0] out_1,
    output wire [7:0] out_2,
    output wire [7:0] out_3
    );
    
    wire [7:0] net [0:3];
    
    compare_swap_unit_8bits c0(.A(in_0),
                               .B(in_3),
							   .clk(clk),
							   .rst_n(rst_n),
							   .enable(enable),
							   .min(net[0]),
							   .max(net[3])
							   );
							   
    compare_swap_unit_8bits c1(.A(in_1),
	                           .B(in_2),
							   .clk(clk),
							   .rst_n(rst_n),
							   .enable(enable),
							   .min(net[1]),
							   .max(net[2])
							   );

    compare_swap_unit_8bits c2(.A(net[0]),
                        	   .B(net[1]),
							   .clk(clk),
							   .rst_n(rst_n),
							   .enable(enable),
							   .min(out_0),
							   .max(out_1)
							   );
							   
    compare_swap_unit_8bits c3(.A(net[2]),
                               .B(net[3]),
							   .clk(clk),
							   .rst_n(rst_n),
							   .enable(enable),
							   .min(out_2),
							   .max(out_3)
							   );
	
endmodule

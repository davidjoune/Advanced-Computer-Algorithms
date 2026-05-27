`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/07 15:12:46
// Design Name: 
// Module Name: compare_swap_unit_8bits
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


module compare_swap_unit_8bits(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire clk,
    input wire rst_n,
    input wire enable,
    output reg [7:0] min,
    output reg [7:0] max
    );
    
    always @(posedge clk or negedge rst_n)begin
        if (!rst_n)begin
            min <= 8'b0;
            max <= 8'b0;
        end
        else if (enable)begin
            if (A>=B)begin
                min <= B;
                max <= A;
            end
            else begin
                min <= A;
                max <= B;
            end
        end
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/09 15:01:59
// Design Name: 
// Module Name: controller
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


module controller(
    input wire clk,
    input wire rst_n,
    input wire start,
    output reg load_in,
    output reg enable_bs,
    output reg load_out
    );
    
    reg [5:0] count;
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            load_in   <= 0;
            enable_bs <= 0;
            load_out  <= 0;
            count     <= 6'b0;
        end
        else if (start | count != 6'b0)begin
            if (count >= 0 & count < 16)begin
                load_in   <= 1'b1;
                enable_bs <= 1'b0;
                load_out  <= 1'b0;
                count     <= count +1;
            end
            else if (count >= 16 & count < 26)begin
                load_in   <= 1'b0;
                enable_bs <= 1'b1;
                load_out  <= 1'b0;
                count     <= count +1;
            end
            else if (count >= 26 & count < 42)begin
                load_in   <= 1'b0;
                enable_bs <= 1'b0;
                load_out  <= 1'b1;
                count     <= count +1;
            end
            else begin
                load_in   <= 1'b0;
                enable_bs <= 1'b0;
                load_out  <= 1'b0;
                count     <= 6'b0;
            end
        end
    end
endmodule

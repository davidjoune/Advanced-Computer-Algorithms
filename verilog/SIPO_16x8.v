`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/07 14:01:34
// Design Name: 
// Module Name: SIPO_16x8
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


module SIPO_16x8(
    input wire clk,
    input wire rst_n,
    input wire load,
    input wire [7:0] din,
    output reg [127:0] dout,
    output reg done
    );
    
    
    reg [3:0] count;
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            dout  <= 128'b0;
            count <= 4'b0;
            done  <= 1'b0;
        end
        else begin
            done  <= 1'b0;
            if (load)begin
                dout  <= {dout[119:0], din};
                count <= count + 1'b1;
                if(count==4'd15)begin
                    done <= 1'b1;
                end
            end
        end
    end
endmodule

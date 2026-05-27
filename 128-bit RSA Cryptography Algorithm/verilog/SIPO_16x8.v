`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/13 15:56:40
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

    input wire in_valid,
    input wire [7:0] din,

    output reg [127:0] dout,
    output reg done
);

    reg [3:0] byte_count;

    always @(posedge clk or negedge rst_n) begin

        if(!rst_n) begin

            dout <= 128'd0;
            byte_count <= 4'd0;
            done <= 1'b0;
        end
        else begin

            done <= 1'b0;

            if(in_valid) begin

                dout <= {dout[119:0], din};

                if(byte_count == 4'd15) begin

                    byte_count <= 4'd0;
                    done <= 1'b1;
                end
                else begin

                    byte_count <= byte_count + 1'b1;
                end
            end
        end
    end
endmodule
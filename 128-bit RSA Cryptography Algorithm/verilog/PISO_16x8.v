`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/13 16:41:12
// Design Name: 
// Module Name: PISO_16x8
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


module PISO_16x8(

    input wire clk,
    input wire rst_n,

    input wire start,

    input wire [127:0] din,

    output reg [7:0] dout,
    output reg done
);

    reg [127:0] shift_reg;
    reg [3:0] byte_count;
    reg active;

    always @(posedge clk or negedge rst_n) begin

        if(!rst_n) begin

            shift_reg <= 128'd0;
            byte_count <= 4'd0;
            dout <= 8'd0;
            done <= 1'b0;
            active <= 1'b0;
        end
        else begin

            done <= 1'b0;

            //================================================
            // Start Serialization
            //================================================

            if(start && !active) begin

                shift_reg <= din;
                byte_count <= 4'd0;
                active <= 1'b1;
            end

            //================================================
            // Output Bytes
            //================================================

            else if(active) begin

                dout <= shift_reg[127:120];
                shift_reg <= {shift_reg[119:0], 8'd0};

                if(byte_count == 4'd15) begin

                    byte_count <= 4'd0;
                    active <= 1'b0;
                    done <= 1'b1;
                end
                else begin

                    byte_count <= byte_count + 1'b1;
                end
            end
        end
    end
endmodule

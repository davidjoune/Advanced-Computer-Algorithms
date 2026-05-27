`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/18 18:39:35
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

    input wire sipo_done,
    input wire enc_done,
    input wire dec_done,
    input wire piso_done,

    output reg sipo_valid,
    output reg enc_start,
    output reg dec_start,
    output reg piso_start,

    output reg done
);

    parameter IDLE        = 4'd0;
    parameter LOAD_INPUT  = 4'd1;
    parameter START_ENC   = 4'd2;
    parameter WAIT_ENC    = 4'd3;
    parameter START_DEC   = 4'd4;
    parameter WAIT_DEC    = 4'd5;
    parameter START_PISO  = 4'd6;
    parameter WAIT_PISO   = 4'd7;
    parameter FINISH      = 4'd8;

    reg [3:0] state;

    always @(posedge clk or negedge rst_n) begin

        if(!rst_n) begin

            state <= IDLE;
            sipo_valid <= 0;
            enc_start <= 0;
            dec_start <= 0;
            piso_start <= 0;
            done <= 0;
        end
        else begin

            // default pulse signals
            enc_start <= 0;
            dec_start <= 0;
            piso_start <= 0;
            done <= 0;

            case(state)

            //================================================
            // IDLE
            //================================================

            IDLE: begin

                sipo_valid <= 0;

                if(start) begin

                    state <= LOAD_INPUT;
                end
            end

            //================================================
            // Receive 16 Bytes
            //================================================

            LOAD_INPUT: begin

                sipo_valid <= 1;

                if(sipo_done) begin

                    sipo_valid <= 0;

                    state <= START_ENC;
                end
            end

            //================================================
            // Start Encrypt
            //================================================

            START_ENC: begin

                enc_start <= 1'b1;

                state <= WAIT_ENC;
            end

            //================================================
            // Wait Encrypt
            //================================================

            WAIT_ENC: begin

                if(enc_done) begin

                    state <= START_DEC;
                end
            end

            //================================================
            // Start Decrypt
            //================================================

            START_DEC: begin

                dec_start <= 1'b1;

                state <= WAIT_DEC;
            end

            //================================================
            // Wait Decrypt
            //================================================

            WAIT_DEC: begin

                if(dec_done) begin

                    state <= START_PISO;
                end
            end

            //================================================
            // Start Output
            //================================================

            START_PISO: begin

                piso_start <= 1'b1;
                
                state <= WAIT_PISO;
            end

            //================================================
            // Wait Output
            //================================================

            WAIT_PISO: begin

                if(piso_done) begin

                    state <= FINISH;
                end
            end
            
            //================================================
            // FINISH
            //================================================

            FINISH: begin

                done <= 1'b1;
                
                state <= IDLE;
            end

            default: begin

                state <= IDLE;
            end
            endcase
        end
    end
endmodule

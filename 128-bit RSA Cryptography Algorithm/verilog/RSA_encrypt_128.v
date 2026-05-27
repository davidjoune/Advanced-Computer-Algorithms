`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/17 21:38:08
// Design Name: 
// Module Name: RSA_encrypt_128
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


module RSA_encrypt_128(

    input wire clk,
    input wire rst_n,
    input wire start,

    input wire [127:0] plaintext,

    output reg [127:0] ciphertext,
    output reg done

);

    //====================================================
    // Fixed RSA Public Key
    //====================================================

    parameter [127:0] N_CONST =
        128'hd9195a8ae3168963d09492e2d9420b23;

    parameter [16:0] E_CONST =
        17'd65537;

    //====================================================
    // FSM
    //====================================================

    parameter IDLE      = 2'd0;
    parameter START_EXP = 2'd1;
    parameter WAIT_EXP  = 2'd2;
    parameter FINISH    = 2'd3;

    reg [1:0] state;

    //====================================================
    // mod_exp interface
    //====================================================

    reg exp_start;

    wire [127:0] exp_result;
    wire exp_done;

    //====================================================
    // Modular Exponentiation
    //====================================================

    mod_exp_128 U_EXP (

        .clk(clk),
        .rst_n(rst_n),
        .start(exp_start),

        .a(plaintext),
        .b(E_CONST),
        .n(N_CONST),

        .result(exp_result),
        .done(exp_done)

    );

    //====================================================
    // FSM
    //====================================================

    always @(posedge clk or negedge rst_n) begin

        if(!rst_n) begin

            state <= IDLE;

            ciphertext <= 0;
            done <= 0;

            exp_start <= 0;
        end
        else begin

            case(state)

            //================================================
            // IDLE
            //================================================

            IDLE: begin

                done <= 0;
                exp_start <= 0;

                if(start) begin

                    state <= START_EXP;
                end
            end

            //================================================
            // START modular exponentiation
            //================================================

            START_EXP: begin

                exp_start <= 1'b1;

                state <= WAIT_EXP;
            end

            //================================================
            // WAIT
            //================================================

            WAIT_EXP: begin

                exp_start <= 1'b0;

                if(exp_done) begin

                    ciphertext <= exp_result;

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

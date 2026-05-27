`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/15 00:17:28
// Design Name: 
// Module Name: mod_exp
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


module mod_exp_128( // a^b mod n
    input wire clk,
    input wire rst_n,
    input wire start,

    input wire [127:0] a,
    input wire [127:0] b,
    input wire [127:0] n,

    output reg [127:0] result,
    output reg done
);

    //====================================================
    // FSM state
    //====================================================

    parameter IDLE         = 4'd0;
    parameter INIT         = 4'd1;
    parameter START_x_d    = 4'd2;
    parameter WAIT_x_d     = 4'd3;
    parameter CHECK_BIT    = 4'd4;
    parameter START_x_a    = 4'd5;
    parameter WAIT_x_a     = 4'd6;
    parameter NEXT_BIT     = 4'd7;
    parameter FINISH       = 4'd8;

    reg [3:0] state;

    //====================================================
    // Registers
    //====================================================

    reg [127:0] base;
    reg [127:0] exponent;

    reg [7:0] bit_index;

    reg mult_start;

    reg [127:0] mult_a;
    reg [127:0] mult_b;

    wire [127:0] mult_res;
    wire mult_done;

    //====================================================
    // Modular Multiplier Instance
    //====================================================

    mod_mult_128 U_MULT (
        .clk(clk),
        .rst_n(rst_n),
        .start(mult_start),
        .a(mult_a),
        .b(mult_b),
        .n(n),
        .res(mult_res),
        .done(mult_done)
    );

    //====================================================
    // FSM
    //====================================================

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            state <= IDLE;
            result <= 0;
            done <= 0;
            base <= 0;
            exponent <= 0;
            bit_index <= 0;
            mult_start <= 0;
            mult_a <= 0;
            mult_b <= 0;
        end
        else begin
            case(state)
            
            //================================================
            // IDLE
            //================================================
            IDLE: begin

                done <= 0;
                mult_start <= 0;

                if(start) begin
                    base <= a;
                    exponent <= b;
                    
                    state <= INIT;
                end
            end
            
            //================================================
            // INIT
            //================================================
            INIT: begin
            
                result <= 128'd1;
                bit_index <= 8'd127;
                
                state <= START_x_d;
            end

            //================================================
            // START_x_d
            // result = result * result mod n
            //================================================
            START_x_d: begin

                mult_a <= result;
                mult_b <= result;
                mult_start <= 1'b1;

                state <= WAIT_x_d;
            end

            //================================================
            // WAIT_x_d
            //================================================
            WAIT_x_d: begin

                mult_start <= 1'b0;

                if(mult_done) begin
                    result <= mult_res;
                    
                    state <= CHECK_BIT;
                end
            end

            //================================================
            // CHECK_BIT
            //================================================
            CHECK_BIT: begin

                if(exponent[bit_index]) begin // exponent[127] ~ exponent[0]
                    state <= START_x_a;
                end
                else begin
                    state <= NEXT_BIT;
                end
            end

            //================================================
            // START_x_a
            // result = result * base mod n
            //================================================
            START_x_a: begin
            
                mult_a <= result;
                mult_b <= base;
                mult_start <= 1'b1;
                
                state <= WAIT_x_a;

            end

            //================================================
            // WAIT_x_a
            //================================================
            WAIT_x_a: begin

                mult_start <= 1'b0;

                if(mult_done) begin
                    result <= mult_res;

                    state <= NEXT_BIT;
                end
            end

            //================================================
            // NEXT_BIT
            //================================================
            NEXT_BIT: begin

                if(bit_index == 0) begin
                    state <= FINISH;
                end
                else begin
                    bit_index <= bit_index - 1;

                    state <= START_x_d;
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

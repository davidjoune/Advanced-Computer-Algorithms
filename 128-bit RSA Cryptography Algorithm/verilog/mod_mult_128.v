`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/13 20:25:16
// Design Name: 
// Module Name: mod_mult_128
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


module mod_mult_128(
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [127:0] a,    // 被乘數
    input wire [127:0] b,    // 乘數
    input wire [127:0] n,    // 模數
    output reg [127:0] res,  // 結果
    output reg done
);

    // 狀態定義
    parameter IDLE     = 3'd0;
    parameter REDUCE_A = 3'd1;
    parameter REDUCE_B = 3'd2;
    parameter CALC     = 3'd3;
    parameter DONE     = 3'd4;

    reg [2:0] state;
    reg [127:0] a_copy;
    reg [127:0] b_copy;
    reg [7:0] count;
    
    // 中間運算暫存，多出一位（129 bits）用來判斷加法後的溢位與比較
    reg [128:0] next_res;
    reg [128:0] next_a;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state  <= IDLE;
            res    <= 128'b0;
            done   <= 1'b0;
            count  <= 8'b0;
            a_copy <= 128'b0;
            b_copy <= 128'b0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (start) begin
                        a_copy <= a;
                        b_copy <= b;
                        res    <= 128'b0;
                        count  <= 8'd128; // 數 128 輪
                        state  <= REDUCE_A;
                    end
                end
                
                REDUCE_A: begin  // 確保 a < n
                    if(a_copy >= n)
                        a_copy <= a_copy - n;
                    else
                        state <= REDUCE_B;
                end

                REDUCE_B: begin  // 確保 b < n
                    if(b_copy >= n)
                        b_copy <= b_copy - n;
                    else
                        state <= CALC;
                end

                CALC: begin
                    if (count == 8'd0) begin
                        state <= DONE;
                    end else begin
                        // --- 第一個 Adder: 處理累積和 (Result) ---
                        if (b_copy[0]) begin
                            next_res = res + a_copy;
                            // 若結果 >= n，則減去 n (維持在模數範圍內)
                            if (next_res >= n)
                                res <= next_res - n;
                            else
                                res <= next_res[127:0];
                        end

                        // --- 第二個 Adder: 處理 a 的冪次方 mod n
                        next_a = a_copy << 1;
                        if (next_a >= n)
                            a_copy <= next_a - n;
                        else
                            a_copy <= next_a[127:0];

                        // 位移 b，準備下一輪
                        b_copy <= b_copy >> 1;
                        count  <= count - 8'd1;
                    end
                end

                DONE: begin
                    done  <= 1'b1;
                    state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule

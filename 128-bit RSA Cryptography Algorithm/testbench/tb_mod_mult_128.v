`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/14 16:06:03
// Design Name: 
// Module Name: tb_mod_mult_128
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


module tb_mod_mult_128;

    // Inputs
    reg clk;
    reg rst_n;
    reg start;
    reg [127:0] a;
    reg [127:0] b;
    reg [127:0] n;

    // Outputs
    wire [127:0] res;
    wire done;

    // 實例化被測模組 (Unit Under Test)
    mod_mult_128 uut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .a(a),
        .b(b),
        .n(n),
        .res(res),
        .done(done)
    );

    // 時脈產生 (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 測試流程
    initial begin
        // 1. 系統初始化
        rst_n = 0;
        start = 0;
        a = 0;
        b = 0;
        n = 0;
        
        #20;
        rst_n = 1;
        #20;

        // 第一組測試
        // 10 * 5 mod 7 = 1
        a = 128'd10;
        b = 128'd5;
        n = 128'd7;
        start = 1;
        #10;
        start = 0;

        // 等待運算完成
        wait(done);
        #50;

        // 第二組測試
        // 11 * 3 mod 7 = 5
        a = 128'd11;
        b = 128'd3;
        n = 128'd7;
        start = 1;
        #10;
        start = 0;

        wait(done);
        #50;

        // 第三組測試
        // 50 * 100 mod 88 = 72
        a = 128'd50;
        b = 128'd100;
        n = 128'd88;
        start = 1;
        #10;
        start = 0;

        wait(done);
        #100;
        
        $finish;
    end
endmodule

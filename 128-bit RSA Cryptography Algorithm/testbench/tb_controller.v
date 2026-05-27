`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/18 18:47:36
// Design Name: 
// Module Name: tb_controller
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


module tb_controller;
    reg clk;
    reg rst_n;

    reg start;
    reg sipo_done;
    reg enc_done;
    reg dec_done;
    reg piso_done;

    wire sipo_valid;
    wire enc_start;
    wire dec_start;
    wire piso_start;
    wire done;

    controller DUT (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .sipo_done(sipo_done),
        .enc_done(enc_done),
        .dec_done(dec_done),
        .piso_done(piso_done),
        .sipo_valid(sipo_valid),
        .enc_start(enc_start),
        .dec_start(dec_start),
        .piso_start(piso_start),
        .done(done)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        start = 0;
        sipo_done = 0;
        enc_done  = 0;
        dec_done  = 0;
        piso_done = 0;

        #100;
        rst_n = 1;
        #20;

        //================================================
        // Start system
        //================================================
        
        @(negedge clk);
        start = 1;
        @(negedge clk);
        start = 0;

        //================================================
        // SIPO done
        //================================================
        
        // 模擬等待幾個 Clock 後 SIPO 完成
        repeat(10) @(negedge clk);
        sipo_done = 1;
        @(negedge clk);
        sipo_done = 0;

        //================================================
        // Encryption done
        //================================================
        
        // 模擬等待加密完成
        repeat(30) @(negedge clk);
        enc_done = 1;
        @(negedge clk);
        enc_done = 0;

        //================================================
        // Decryption done
        //================================================
        
        // 模擬等待解密完成
        repeat(30) @(negedge clk);
        dec_done = 1;
        @(negedge clk);
        dec_done = 0;

        //================================================
        // PISO done
        //================================================
        
        // 模擬等待 PISO 輸出完成
        repeat(16) @(negedge clk);
        piso_done = 1;
        @(negedge clk);
        piso_done = 0;

        repeat(20) @(negedge clk);
        $finish;
    end
endmodule
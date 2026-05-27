`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/17 23:48:41
// Design Name: 
// Module Name: tb_RSA_encrypt_128
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


module tb_RSA_encrypt_128;

    //====================================================
    // Signals
    //====================================================

    reg clk;
    reg rst_n;
    reg start;

    reg [127:0] plaintext;

    wire [127:0] ciphertext;
    wire done;

    //====================================================
    // DUT
    //====================================================

    RSA_encrypt_128 DUT (

        .clk(clk),
        .rst_n(rst_n),
        .start(start),

        .plaintext(plaintext),

        .ciphertext(ciphertext),
        .done(done)

    );

    //====================================================
    // Clock
    //====================================================

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //====================================================
    // Test
    //====================================================

    initial begin

        rst_n = 0;
        start = 0;

        plaintext = 0;

        // reset
        #20;
        rst_n = 1;

        #20;

        plaintext =
        128'h48454C4C4F2046504741212121212121;

        // start pulse
        start = 1;
        #10;
        start = 0;

        wait(done);

        #200;

        $finish;
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/16 16:11:30
// Design Name: 
// Module Name: tb_mod_exp_128
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


module tb_mod_exp_128;

    //====================================================
    // DUT signals
    //====================================================
    
    reg clk;
    reg rst_n;
    reg start;

    reg [127:0] a;
    reg [127:0] b;
    reg [127:0] n;

    wire [127:0] result;
    wire done;
    
    //====================================================
    // DUT
    //====================================================

    mod_exp_128 DUT (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),

        .a(a),
        .b(b),
        .n(n),

        .result(result),
        .done(done)
    );

    //====================================================
    // Clock generation
    //====================================================

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    //====================================================
    // Stimulus
    //====================================================

    initial begin

        // init
        rst_n = 0;
        start = 0;

        a = 0;
        b = 0;
        n = 0;

        // reset
        #20;
        rst_n = 1;

        //================================================
        // Example:
        // 11^23 mod 187 = 88
        //================================================

        #20;
        a = 128'd11;
        b = 128'd23;
        n = 128'd187;

        // start pulse
        start = 1;
        #10;
        start = 0;

        // wait until done
        wait(done);

        // observe waveform a little longer
        #100;
        $finish;
    end
endmodule

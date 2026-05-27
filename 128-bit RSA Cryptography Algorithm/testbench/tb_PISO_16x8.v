`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/13 16:45:52
// Design Name: 
// Module Name: tb_PISO_16x8
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


module tb_PISO_16x8();

    // 宣告連接 DUT 的訊號
    reg clk;
    reg rst_n;
    reg start;
    reg [127:0] din;

    wire [7:0] dout;
    wire done;

    PISO_16x8 uut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .din(din),
        .dout(dout),
        .done(done)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
    
        rst_n = 0;
        start = 0;
        din = 128'd0;

        #100;
        rst_n = 1;
        #20;

        @(negedge clk);
        din = 128'h11_22_33_44_55_66_77_88_99_AA_BB_CC_DD_EE_FF_00;
        start = 1;
        
        @(negedge clk);
        start = 0;

        wait(done);
        @(negedge clk);

        #50;
        $finish;
    end
endmodule
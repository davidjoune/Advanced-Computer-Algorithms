`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/18 21:21:42
// Design Name: 
// Module Name: tb_RSA_complete_128
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


module tb_RSA_complete_128;

    reg clk;
    reg rst_n;

    reg start;
    reg [7:0] rx_data;

    wire [7:0] tx_data;
    wire done;

    RSA_complete_128 DUT(

        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .rx_data(rx_data),
        .tx_data(tx_data),
        .done(done)
    );

    //====================================================
    // Clock Generation
    //====================================================

    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end

    //====================================================
    // Test Data
    //====================================================

    reg [127:0] plaintext;

    integer i;

    //====================================================
    // Test
    //====================================================

    initial begin

        //================================================
        // Initial
        //================================================

        rst_n = 1'b0;
        start = 1'b0;
        rx_data = 8'd0;

        plaintext =
        128'h123456789abcdeffedcba98765432101;

        //================================================
        // Reset
        //================================================

        #100;
        rst_n = 1'b1;
        #40;

        //================================================
        // Start System
        //================================================

        @(posedge clk);
        start <= 1'b1;
        @(posedge clk);
        start <= 1'b0;

        //================================================
        // Wait Controller Enter LOAD_INPUT
        //================================================

        #40;

        //================================================
        // Send 16 Bytes
        // MSB First
        //================================================

        for(i = 0; i < 16; i = i + 1) begin

            @(posedge clk);
            rx_data <= plaintext[127 - i*8 -: 8];
        end

        //================================================
        // Stop Input
        //================================================

        @(posedge clk);
        rx_data <= 8'd0;

        //================================================
        // Wait Finish
        //================================================

        wait(done);

        #300;
        $finish;
    end
endmodule

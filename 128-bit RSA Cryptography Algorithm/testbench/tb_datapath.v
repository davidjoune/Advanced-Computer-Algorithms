`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/18 18:29:51
// Design Name: 
// Module Name: tb_datapath
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


module tb_datapath();

    reg clk;
    reg rst_n;

    reg sipo_valid;
    reg enc_start;
    reg dec_start;
    reg piso_start;

    reg [7:0] rx_data;

    wire sipo_done;
    wire enc_done;
    wire dec_done;
    wire piso_done;
    wire [7:0] tx_data;

    datapath DUT (
        .clk(clk),
        .rst_n(rst_n),
        .sipo_valid(sipo_valid),
        .enc_start(enc_start),
        .dec_start(dec_start),
        .piso_start(piso_start),
        .rx_data(rx_data),
        .sipo_done(sipo_done),
        .enc_done(enc_done),
        .dec_done(dec_done),
        .piso_done(piso_done),
        .tx_data(tx_data)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    reg [127:0] plaintext;
    integer i;

    //====================================================
    // Test Sequence
    //====================================================
    initial begin
        rst_n      = 0;
        sipo_valid = 0;
        enc_start  = 0;
        dec_start  = 0;
        piso_start = 0;
        rx_data    = 0;

        plaintext  = 128'h112233445566778899aabbccddeeff11;

        #100;
        rst_n = 1;
        #20;

        //================================================
        // 1. SIPO
        //================================================
        for(i = 16; i > 0; i = i - 1) begin
            @(negedge clk);
            sipo_valid = 1'b1;
            rx_data = plaintext[8*i-1 -: 8];
        end
        @(negedge clk);
        sipo_valid = 1'b0;

        // Wait SIPO done
        wait(sipo_done);
        @(negedge clk);

        //================================================
        // 2. Start Encryption
        //================================================
        enc_start = 1'b1;
        @(negedge clk);
        enc_start = 1'b0;

        // Wait Encryption
        wait(enc_done);
        @(negedge clk);

        //================================================
        // 3. Start Decryption
        //================================================
        dec_start = 1'b1;
        @(negedge clk);
        dec_start = 1'b0;

        // Wait Decryption
        wait(dec_done);
        @(negedge clk);

        //================================================
        // 4. PISO
        //================================================
        piso_start = 1'b1;
        @(negedge clk);
        piso_start = 1'b0;

        wait(piso_done);
        @(negedge clk);

        #200;
        $finish;
    end
endmodule

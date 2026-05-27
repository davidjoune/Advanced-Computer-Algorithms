`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/18 17:48:45
// Design Name: 
// Module Name: datapath
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


module datapath(

    input wire clk,
    input wire rst_n,

    input wire sipo_valid,
    input wire enc_start,
    input wire dec_start,
    input wire piso_start,

    input wire [7:0] rx_data,

    output wire sipo_done,
    output wire enc_done,
    output wire dec_done,
    output wire piso_done,

    output wire [7:0] tx_data
);


    wire [127:0] plaintext_wire;
    wire [127:0] ciphertext_wire;
    wire [127:0] decrypted_wire;

    SIPO_16x8 U_SIPO(
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(sipo_valid),
        .din(rx_data),
        .dout(plaintext_wire),
        .done(sipo_done)
    );

    RSA_encrypt_128 U_ENC(
        .clk(clk),
        .rst_n(rst_n),
        .start(enc_start),
        .plaintext(plaintext_wire),
        .ciphertext(ciphertext_wire),
        .done(enc_done)
    );

    RSA_decrypt_128 U_DEC(
        .clk(clk),
        .rst_n(rst_n),
        .start(dec_start),
        .ciphertext(ciphertext_wire),
        .plaintext(decrypted_wire),
        .done(dec_done)
    );

    PISO_16x8 U_PISO(
        .clk(clk),
        .rst_n(rst_n),
        .start(piso_start),
        .din(decrypted_wire),
        .dout(tx_data),
        .done(piso_done)
    );
endmodule

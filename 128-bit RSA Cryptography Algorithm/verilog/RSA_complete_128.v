`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/18 18:56:02
// Design Name: 
// Module Name: RSA_complete_128
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


module RSA_complete_128(

    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [7:0] rx_data,
    output wire [7:0] tx_data,
    output wire done

);

    wire sipo_valid;

    wire enc_start;
    wire dec_start;
    wire piso_start;

    wire sipo_done;
    wire enc_done;
    wire dec_done;
    wire piso_done;

    controller U_CONTROLLER(

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

    datapath U_DATAPATH(

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
endmodule

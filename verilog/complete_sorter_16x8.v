`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/09 15:31:42
// Design Name: 
// Module Name: complete_sorter_16x8
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


module complete_sorter_16x8(
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [7:0] din,
    output wire [7:0] dout,
    output wire done
    );
    
    wire load_in;
    wire load_out;
    wire enable_bs;
    wire clk_b;
    assign clk_b = ~clk;
    datapath d0(.clk(clk),
                .rst_n(rst_n),
                .load_in(load_in),
                .load_out(load_out),
                .enable_bs(enable_bs),
                .din(din),
                .dout(dout),
                .done(done)
    );
    controller c0(.clk(clk_b),
                  .rst_n(rst_n),
                  .start(start),
                  .load_in(load_in),
                  .load_out(load_out),
                  .enable_bs(enable_bs)
    );
endmodule

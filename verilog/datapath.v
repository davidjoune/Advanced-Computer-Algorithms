`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/08 17:38:23
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
    input wire load_in,
    input wire load_out,
    input wire enable_bs,
    input wire [7:0] din,
    output wire [7:0] dout,
    output wire done
    );
    wire [127:0] net0;
    wire [127:0] net1;
    SIPO_16x8 s0(.clk(clk),
                 .rst_n(rst_n),
                 .load(load_in),
                 .din(din),
                 .dout(net0),
                 .done()
                 );
    bitonic_sorter_16 b0(.clk(clk),
                         .rst_n(rst_n),
                         .enable(enable_bs),
                         .in(net0),
                         .out(net1)
                         );
    PISO_16x8 p0(.clk(clk),
                 .rst_n(rst_n),
                 .load(load_out),
                 .din(net1),
                 .dout(dout),
                 .done(done)
                 );
endmodule

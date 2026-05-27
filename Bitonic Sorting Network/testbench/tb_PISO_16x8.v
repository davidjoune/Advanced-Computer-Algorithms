`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/08 17:14:45
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


module tb_PISO_16x8;
    reg clk;
    reg rst_n;
    reg load;
    reg [127:0] din;
    wire [7:0] dout;
    wire done;

    PISO_16x8 uut (
        .clk(clk),
        .rst_n(rst_n),
        .load(load),
        .din(din),
        .dout(dout),
        .done(done)
    );

    always #10 clk = ~clk;
    initial begin
        clk = 0;
        rst_n = 0;
        load = 0;
        din  = 128'd0;

        #100;
        rst_n = 1;
        din  = 128'h0123456789abcdeffedcba9876543210;
        
        repeat (16) begin
            @(negedge clk);
            load = 1;
        end
        
        @(negedge clk);
        load =0;

        #100;
        $finish;
    end
endmodule

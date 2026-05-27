`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/07 14:44:00
// Design Name: 
// Module Name: tb_SIPO_16x8
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


module tb_SIPO_16x8;
    reg clk;
    reg rst_n;
    reg load;
    reg [7:0] din;
    wire [127:0] dout;
    wire done;

    SIPO_16x8 uut (
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
        din  = 8'h00;

        #100;
        rst_n = 1;

        // 依序送 16 個 byte
        repeat (16) begin
            @(negedge clk);
            load = 1;
            din  = $random;  // 隨機送一個 byte
        end

        @(negedge clk);
        load = 0;

        #100;
        $finish;
    end
endmodule

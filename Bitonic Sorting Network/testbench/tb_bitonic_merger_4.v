`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/08 13:53:22
// Design Name: 
// Module Name: tb_bitonic_merger_4
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


module tb_bitonic_merger_4;
  reg         clk;
  reg         rst_n;
  reg         enable;
  reg  [7:0]  in_0, in_1, in_2, in_3;
  wire [7:0]  out_0, out_1, out_2, out_3;

  bitonic_merger_4 dut (
      .in_0(in_0),
      .in_1(in_1),
      .in_2(in_2),
      .in_3(in_3),
      .clk(clk),
      .rst_n(rst_n),
      .enable(enable),
      .out_0(out_0),
      .out_1(out_1),
      .out_2(out_2),
      .out_3(out_3)
  );

  always #5 clk = ~clk;
  initial begin
    clk = 0;
    rst_n  = 0;
    enable = 0;
    in_0   = 0;
    in_1   = 0;
    in_2   = 0;
    in_3   = 0;

    #100;
    rst_n = 1;
    @(negedge clk);

    // 測試1
    enable = 1'b1;
    in_0 = 8'h10;
    in_1 = 8'h40;
    in_2 = 8'h20;
    in_3 = 8'h30;

    // 等兩個週期經過 CS
    repeat(2) @(negedge clk);
    
    //測試2
    enable = 1'b0;
    in_0 = 8'hbb;
    in_1 = 8'hff;
    in_2 = 8'haa;
    in_3 = 8'hcc;
    
    @(negedge clk);
    enable = 1'b1;
    
    // 等兩個週期經過 CS
    repeat(2) @(negedge clk);
    enable = 1'b0;


    #20;
    $finish;
  end
endmodule

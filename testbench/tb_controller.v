`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/09 15:18:22
// Design Name: 
// Module Name: tb_controller
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


module tb_controller;
  reg         clk;
  reg         rst_n;
  reg         start;
  wire        load_in;
  wire        load_out;
  wire        enable_bs;

  
  controller dut (
      .clk(clk),
      .rst_n(rst_n),
      .start(start),
      .load_in(load_in),
      .load_out(load_out),
      .enable_bs(enable_bs)
  );

  always #10 clk = ~clk;
  initial begin
    clk = 0;
    rst_n = 0;
    start = 0;
  
    #100;
    rst_n = 1;
    start = 1;
    
    #20;
    start = 0;
    
    repeat (42) @(negedge clk); // 等 42 個週期觀察結果 (16+10+16)
  
    #100
    $finish;
   end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/07 15:41:50
// Design Name: 
// Module Name: tb_compare_swap_unit_8bits
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


module tb_compare_swap_unit_8bits;
  reg        clk;
  reg        rst_n;
  reg        enable;
  reg  [7:0]  A, B;
  wire [7:0] min, max;

  compare_swap_unit_8bits dut (
    .A(A),
    .B(B),
    .clk(clk),
    .rst_n(rst_n),
    .enable(enable),
    .min(min),
    .max(max)
  );

  always #5 clk = ~clk;
  initial begin
    clk = 0;
    rst_n = 0;
    A = 0;
    B = 0;
    enable = 0;

    #100 rst_n = 1; enable = 0;

    // === 測試 1: A > B ===
    @(negedge clk);
    A = 8'hf0; B = 8'he8;
    #20

    // === 測試 2: A < B ===
    @(negedge clk);
    A = 8'h59;  B = 8'h83;
    #20

    // === 測試 3: A == B ===
    @(negedge clk);
    A = 8'haa; B = 8'haa;
    #20
    
    // === 測試 enable
    enable = 1;

    @(negedge clk);
    A = 8'hf0; B = 8'he8;
    #20

    @(negedge clk);
    A = 8'h59;  B = 8'h83;
    #20

    @(negedge clk);
    A = 8'haa; B = 8'haa;
    

    #30;
    $finish;
  end
endmodule

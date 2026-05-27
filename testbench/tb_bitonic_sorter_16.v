`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/08 15:57:33
// Design Name: 
// Module Name: tb_bitonic_sorter_16
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


module tb_bitonic_sorter_16;
  reg         clk;
  reg         rst_n;
  reg         enable;
  reg  [127:0]  in;
  wire [127:0]  out;

  bitonic_sorter_16 dut (
      .in(in),
      .clk(clk),
      .rst_n(rst_n),
      .enable(enable),
      .out(out)
  );
  
  always #5 clk = ~clk;
  initial begin
    clk = 0;
    rst_n  = 0;
    enable = 0;
    in     = 0;

    #100;
    rst_n = 1;
    @(negedge clk);

    // 測試1
    enable = 1'b1;
    in = 128'hcc_de_87_3b_1f_50_b6_7a_61_a4_98_01_45_ec_23_ff;

    // 等十個週期經過 CS
    repeat(10) @(negedge clk);
    
    //測試2
    enable = 1'b0;
    in = 128'h02_f0_99_5f_ee_17_b9_a0_6c_d1_78_24_c6_8e_4a_3c;
    
    @(negedge clk);
    enable = 1'b1;
    
    // 等十個週期經過 CS
    repeat(10) @(negedge clk);
    enable = 1'b0;

    #100;
    $finish;
  end
endmodule

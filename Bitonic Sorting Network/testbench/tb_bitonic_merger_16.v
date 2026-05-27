`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/08 14:58:20
// Design Name: 
// Module Name: tb_bitonic_merger_16
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


module tb_bitonic_merger_16;
  reg         clk;
  reg         rst_n;
  reg         enable;
  reg  [7:0]  in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7, in_8, in_9, in_10, in_11, in_12, in_13, in_14, in_15;
  wire [7:0]  out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7, out_8, out_9, out_10, out_11, out_12, out_13, out_14, out_15;

  bitonic_merger_16 dut (
      .in_0(in_0),
      .in_1(in_1),
      .in_2(in_2),
      .in_3(in_3),
      .in_4(in_4),
      .in_5(in_5),
      .in_6(in_6),
      .in_7(in_7),
      .in_8(in_8),
      .in_9(in_9),
      .in_10(in_10),
      .in_11(in_11),
      .in_12(in_12),
      .in_13(in_13),
      .in_14(in_14),
      .in_15(in_15),
      .clk(clk),
      .rst_n(rst_n),
      .enable(enable),
      .out_0(out_0),
      .out_1(out_1),
      .out_2(out_2),
      .out_3(out_3),
      .out_4(out_4),
      .out_5(out_5),
      .out_6(out_6),
      .out_7(out_7),
      .out_8(out_8),
      .out_9(out_9),
      .out_10(out_10),
      .out_11(out_11),
      .out_12(out_12),
      .out_13(out_13),
      .out_14(out_14),
      .out_15(out_15)
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
    in_4   = 0;
    in_5   = 0;
    in_6   = 0;
    in_7   = 0;
    in_8   = 0;
    in_9   = 0;
    in_10  = 0;
    in_11  = 0;
    in_12  = 0;
    in_13  = 0;
    in_14  = 0;
    in_15  = 0;

    #100;
    rst_n = 1;
    @(negedge clk);

    // 測試1
    enable = 1'b1;
    in_0  = 8'h02;
    in_1  = 8'h24;
    in_2  = 8'h57;
    in_3  = 8'h98;
    in_4  = 8'ha7;
    in_5  = 8'hc5;
    in_6  = 8'hea;
    in_7  = 8'hf9;
    in_8  = 8'h34;
    in_9  = 8'h46;
    in_10 = 8'h78;
    in_11 = 8'h94;
    in_12 = 8'hb1;
    in_13 = 8'hc9;
    in_14 = 8'hda;
    in_15 = 8'he9;

    // 等四個週期經過 CS
    repeat(4) @(negedge clk);
    
    //測試2
    enable = 1'b0;
    in_0  = 8'h08;
    in_1  = 8'h29;
    in_2  = 8'h58;
    in_3  = 8'h66;
    in_4  = 8'h7e;
    in_5  = 8'h9a;
    in_6  = 8'ha7;
    in_7  = 8'hc1;
    in_8  = 8'h07;
    in_9  = 8'h19;
    in_10 = 8'h38;
    in_11 = 8'h77;
    in_12 = 8'h99;
    in_13 = 8'ha6;
    in_14 = 8'hb7;
    in_15 = 8'he5;
    
    @(negedge clk);
    enable = 1'b1;
    
    // 等四個週期經過 CS
    repeat(4) @(negedge clk);
    enable = 1'b0;

    #20;
    $finish;
  end
endmodule

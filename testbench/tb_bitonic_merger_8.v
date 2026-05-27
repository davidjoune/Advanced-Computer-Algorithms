`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/08 14:32:31
// Design Name: 
// Module Name: tb_bitonic_merger_8
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


module tb_bitonic_merger_8;
  reg         clk;
  reg         rst_n;
  reg         enable;
  reg  [7:0]  in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7;
  wire [7:0]  out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7;

  bitonic_merger_8 dut (
      .in_0(in_0),
      .in_1(in_1),
      .in_2(in_2),
      .in_3(in_3),
      .in_4(in_4),
      .in_5(in_5),
      .in_6(in_6),
      .in_7(in_7),
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
      .out_7(out_7)
  );
  
  always #5 clk = ~clk;
  initial begin
    clk    = 0;
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

    #100;
    rst_n = 1;
    @(negedge clk);

    // 測試1
    enable = 1'b1;
    in_0 = 8'h12;
    in_1 = 8'h34;
    in_2 = 8'h67;
    in_3 = 8'h88;
    in_4 = 8'h09;
    in_5 = 8'h45;
    in_6 = 8'h57;
    in_7 = 8'hab;

    // 等三個週期經過 CS
    repeat(3) @(negedge clk);
    
    //測試2
    enable = 1'b0;
    in_0 = 8'h11;
    in_1 = 8'h44;
    in_2 = 8'h88;
    in_3 = 8'hcc;
    in_4 = 8'h33;
    in_5 = 8'h66;
    in_6 = 8'h99;
    in_7 = 8'hff;
    
    @(negedge clk);
    enable = 1'b1;
    
    // 等三個週期經過 CS
    repeat(3) @(negedge clk);
    enable = 1'b0;
    #20;
    $finish;
  end
endmodule

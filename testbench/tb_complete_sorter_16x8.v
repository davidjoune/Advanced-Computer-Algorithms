`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/09 15:37:14
// Design Name: 
// Module Name: tb_complete_sorter_16x8
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


module tb_complete_sorter_16x8;
  reg         clk;
  reg         rst_n;
  reg         start;
  reg  [7:0]  din;
  wire [7:0]  dout;
  wire        done;
  
  complete_sorter_16x8 dut (
      .clk(clk),
      .rst_n(rst_n),
      .start(start),
      .din(din),
      .dout(dout),
      .done(done)
  );
  
  always #10 clk = ~clk;
  initial begin
    clk = 0;
    rst_n = 0;
    start = 0;
    din   = 0;
  
    #100;
    rst_n = 1;
    @(posedge clk);
    start = 1;
    @(negedge clk);
    din   = $random;
    @(posedge clk);
    start = 0;
   
    repeat (15) begin
        @(negedge clk);
        din     = $random;
    end
    repeat (26) @(negedge clk); // 等 26 個週期觀察結果 (10+16)
  
    #100
    $finish;
   end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/09 14:11:44
// Design Name: 
// Module Name: tb_datapath
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


module tb_datapath;
  reg         clk;
  reg         rst_n;
  reg         load_in;
  reg         load_out;
  reg         enable_bs;
  reg  [7:0]  din;
  wire [7:0]  dout;
  wire        done;
  
  datapath dut (
      .clk(clk),
      .rst_n(rst_n),
      .load_in(load_in),
      .load_out(load_out),
      .enable_bs(enable_bs),
      .din(din),
      .dout(dout),
      .done(done)
  );
  
  always #10 clk = ~clk;
  initial begin
    clk = 0;
    rst_n     = 0;
    enable_bs = 0;
    load_in   = 0;
    load_out  = 0;
    din       = 8'h00;

    #100;
    rst_n = 1;
    
    repeat (16) begin
        @(negedge clk);
        load_in = 1;
        din     = $random;
    end
    
    @(negedge clk);
    load_in   = 0;
    enable_bs = 1;
    
    // 等十個週期經過 CS
    repeat(10) @(negedge clk);
    enable_bs = 0;
    
    load_out = 1;
    // 依序送出 16 個 byte
    repeat (15) begin
        @(negedge clk);
        load_out = 1;
    end
    
    @(negedge clk);
    load_out = 0;

    #100;
    $finish;
  end
endmodule

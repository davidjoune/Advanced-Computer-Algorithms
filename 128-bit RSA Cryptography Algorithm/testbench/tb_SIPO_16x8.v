`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/13 16:36:00
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

    reg in_valid;
    reg [7:0] din;

    wire [127:0] dout;
    wire done;

    //====================================================
    // DUT
    //====================================================

    SIPO_16x8 DUT (

        .clk(clk),
        .rst_n(rst_n),

        .in_valid(in_valid),
        .din(din),

        .dout(dout),
        .done(done)
    );

    //====================================================
    // Clock Generation
    //====================================================

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    integer i;

    reg [127:0] test_data;

    //====================================================
    // Test
    //====================================================

    initial begin

        //================================================
        // Initial
        //================================================

        rst_n = 0;
        in_valid = 0;
        din = 8'h00;

        test_data =
        128'h123456789abcdeffedcba98765432101;


        //================================================
        // Reset
        //================================================

        #100;
        rst_n = 1;
        #20;

        //================================================
        // Send 16 Bytes
        //================================================

        for(i = 0; i < 16; i = i + 1) begin

            @(posedge clk);

            in_valid <= 1'b1;

            din <= test_data[127 - i*8 -: 8];
        end

        //================================================
        // Stop Input
        //================================================

        @(posedge clk);

        in_valid <= 1'b0;
        din <= 8'h00;


        #100;
        $finish;
    end
endmodule

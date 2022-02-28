`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2021 07:41:40 PM
// Design Name: 
// Module Name: Program_Counter
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


module Program_Counter(branch, uncond_branch, z_flag, br_address, clk, pc);

    input branch, uncond_branch, z_flag, clk;
    input [63:0] br_address;
    output reg [63:0] pc;

    wire select;

    initial pc = 0;
    assign select = uncond_branch | ((~z_flag) && branch);  // AND and OR gates. z flag needs to non-zero, as the condition is CBNZ

    always@(posedge clk)

    pc <= select ? (br_address + pc):(pc + 1);   // select between branch and regular increment

endmodule

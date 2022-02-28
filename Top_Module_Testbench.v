`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2021 03:02:39 PM
// Design Name: 
// Module Name: Top_Module_Testbench
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


module Top_Module_Testbench();
    reg clk, rst;


    initial clk = 0;
    initial rst = 0;
    always #1 clk = ~clk;
    
endmodule

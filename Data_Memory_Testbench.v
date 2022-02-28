`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2021 01:01:36 PM
// Design Name: 
// Module Name: Data_Memory_Testbench
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


module Data_Memory_Testbench();

    // Inputs 
    reg clk, rst;
    reg [63:0] MemWriteData, MemAddress;
    reg MemWriteEnable, MemReadEnable;

    // Outputs 
    wire [63:0] MemReadData;

    // Entire data memory
    //reg [63:0] data_mem [63:0];

    Data_Memory D1(MemAddress, MemWriteData, MemWriteEnable, MemReadEnable, MemReadData, clk, rst);

    initial clk = 0;
    initial rst = 1;
    always #1 clk = ~clk;

    initial
    begin
        MemAddress = 64'b0000000000000000000000000000000000000000000000000000000000000001;
        MemReadEnable = 0;
        MemWriteEnable = 0;

        #20
        rst = 0;
        MemReadEnable = 1; 
        
        #20 
        MemReadEnable = 0; 

        #50
        MemWriteEnable = 1;
        MemWriteData = 64'b0000000000000000000000000000000000000000000000000000000000001000;
        
        #10 
        MemReadEnable = 1;
        
        #10
        MemWriteEnable = 0;
        
        #50 
        MemReadEnable = 0;
        MemWriteEnable = 1;
        MemWriteData = 64'b0000000000000000000000000000000000000000000000000000000000000010;
        
        #10 
        MemWriteEnable = 0; 
        
        #10 
        rst = 1;          
    end
endmodule

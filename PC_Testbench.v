`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2021 02:06:57 PM
// Design Name: 
// Module Name: PC_Testbench
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


module PC_Testbench();
    //Inputs 
    reg branch, uncond_branch, z_flag, clk;
    reg [63:0] br_address;

    //Outputs 
    wire [63:0] pc;

    Program_Counter PC (branch, uncond_branch, z_flag, br_address, clk, pc);
    
    initial clk = 0;
    always #5 clk = ~clk;

    initial
    begin
        branch = 0;
        uncond_branch = 0;
        z_flag = 0;
        br_address = 64'b0000000000000000000000000000000000000000000000000000000000000010;


        #50
        branch = 1;
        uncond_branch = 0;
        z_flag = 0;
        br_address = 64'b0000000000000000000000000000000000000000000000000000000000000010;

        #50
        branch = 0;
        uncond_branch = 1;
        z_flag = 0;
        br_address = 64'b0000000000000000000000000000000000000000000000000000000000000010;


        #50
        branch = 0;
        uncond_branch = 0;
        z_flag = 1;
        br_address = 64'b0000000000000000000000000000000000000000000000000000000000000010;
    end

endmodule

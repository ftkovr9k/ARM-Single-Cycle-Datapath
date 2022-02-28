`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2021 07:09:23 PM
// Design Name: 
// Module Name: ALU_Testbench
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


module ALU_Testbench();

    // Inputs
    reg [63:0] A, B;
    reg [3:0] Op_Code;

    // Outputs
    wire[63:0] ALU_out;
    wire z_flag;

    integer i;

    ALU test (A, B, Op_Code, ALU_out, z_flag);

    initial begin
        A = 64'b0000000000000000000000000000000000000000000000000000000000000010;
        B = 64'b0000000000000000000000000000000000000000000000000000000000000001;
        Op_Code = 4'b0000;

        for (i=1; i < 8; i = i+1)
            begin
                Op_Code = Op_Code + 4'b0001;
                #10;
            end
        
        #20   
        A = 64'b0000000000000000000000000000000000000000000010101111001111001000;
        B = 64'b0000000000000000000000000000000000000000000000000100010001000100;
        Op_Code = 4'b1000; 
        #50 
        Op_Code = 4'b1111; 

    end

endmodule

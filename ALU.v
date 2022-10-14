`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2021 06:27:00 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [63:0] A,B, // ALU 64-bit inputs  
    input [3:0] Op_Code, // ALU 4-bit opcode 
    output reg [63:0] ALU_out, // ALU 64 bit output 
    output z_flag // zero flag 
);

    reg [64:0] sum; //to store the result of addition
    reg [63:0] movk_val;

    always @(*)
    begin
        case(Op_Code)
            4'b0001: // AND
            ALU_out <= A & B ;
            4'b0010: // OR
            ALU_out <= A | B;
            4'b0011: // Not
            ALU_out <= ~A;
            4'b0100: // MOVA: Out <= A
            ALU_out <= A;
            4'b0101: // MOVB: Out <= B
            ALU_out <= B;
            4'b0110: // Add
            begin
                sum = A + B ;
                ALU_out <= sum[63:0];
            end
            4'b0111: // Subtract 
            ALU_out <= A - B;
            4'b1000: //MOVK  
            begin
                //A[15:0] <= B[15:0]; 
                movk_val = A[63:16] << 16;
                movk_val = movk_val | B[15:0];
                ALU_out <= movk_val;
            end
            default:
            ALU_out <= 64'hFFFFFFFFFFFFFFFF;
        endcase
    end

    assign z_flag = (ALU_out == 0) ? 1: 0;

endmodule

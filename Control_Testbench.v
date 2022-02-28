`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2021 08:18:30 PM
// Design Name: 
// Module Name: Control_Testbench
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


module Control_Testbench();

    // Inputs
    reg [31:0] instruction;

    // Outputs
    wire regwrite, cond_br, jp, memwrite, memread, mem2reg;
    wire [3:0] alu_op;
    //wire [1:0] alusrc_mux;
    wire alusrc_mux; 
    wire [4:0] ReadSelect1, ReadSelect2, WriteSelect;
    wire [63:0] Extended; 
   

    Control C (instruction, regwrite, cond_br, jp, memwrite, memread, mem2reg, alu_op, alusrc_mux, ReadSelect1, ReadSelect2, WriteSelect, Extended);

    initial
    begin

        //Wrong OPCODE
        //    instruction = 32'h000000A0;  // Branch
        //    #20 
        //    instruction = 32'h00000450;  // And 
        //    #20 
        //    instruction = 32'h00000458;  // Add 
        //    #20 
        //    instruction = 32'h00000550;  // Or 
        //    #20 
        //    instruction = 32'h000005A0;  // CBNZ
        //    #20 
        //    instruction = 32'h00000658;  // SUB
        //    #20 
        //    instruction = 32'h00000794;  // MOVK 
        //    #20 
        //    instruction = 32'h000007C0;  // STUR
        //    #20 
        //    instruction = 32'h000007C2;  // LDUR 

        instruction = 32'b00010100000_000000000000000000001; // Branch
        #20
        instruction = 32'b10001010000_00010_000000_00100_00001; // And 
        #20
        instruction = 32'b10001011000_00001_000000_00001_00000; // Add    
        #20
        instruction = 32'b10101010000_00010_000000_00001_00000; // Or  
        #20
        instruction = 32'b10110100000_0000000000000011_00001; // CBNZ
        #20
        instruction = 32'b11001011000_00000_000000_00010_00010; // SUB
        #20
        instruction = 32'b11110010100_0000000000001111_00001; // MOVK     
        #20
        instruction = 32'b11111000000_00000000011_00001_00010; // STUR
        #20
        instruction = 32'b11111000010_00000000100_00010_00001; // LDUR  
        

    end
endmodule

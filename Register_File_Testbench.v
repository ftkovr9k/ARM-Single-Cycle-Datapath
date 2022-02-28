`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2021 07:07:55 PM
// Design Name: 
// Module Name: Register_File_Testbench
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


module Register_File_Testbench();

    // Inputs
    reg clk, rst;
    reg [4:0] ReadSelect1, ReadSelect2, WriteSelect;
    reg [63:0] WriteData;
    reg WriteEnable;

    // Outputs
    wire [63:0] ReadData1, ReadData2;

 //   reg [63:0] reg_file [31:0];   // Entire list of registers


    Register_File R1 (ReadSelect1, ReadSelect2, WriteSelect, WriteData, WriteEnable, ReadData1, ReadData2, clk, rst);

    initial clk = 0;
    initial rst = 1;
    always #1 clk = ~clk;

    initial
    begin
        ReadSelect1 = 5'b00000;
        ReadSelect2 = 5'b11111;
        //WriteEnable = 0; 
        //WriteSelect = 0; 

         #10 
         rst = 0; 

         #30
         WriteEnable = 1; 

         #10 
         WriteEnable = 0;

         #20
         //WriteSelect = 5'b00000; 
         WriteData = 64'b0000000000000000000000000000000000000000000000000000000000000001;

         #10 
         WriteEnable = 1; 

         #10 
         WriteSelect = 5'b00000; 

         #50
         rst = 1;

    end

endmodule


//module Register_File_Testbench ();

//    // Inputs 
//    reg clk, rst;
//    reg [31:0] instruction; // 32-bit instruction 
//    reg [63:0] WriteData; // 64-bit data to write in the register  
//    reg reg2loc, regwrite, clk, rst;

//    // Outputs 
//    wire [63:0] ReadData1, ReadData2, Extended; // 64-bit output of the read registers 

//    Register_File R1 (instruction, reg2loc, regwrite, clk, rst, WriteData, ReadData1, ReadData2, Extended);

//    initial clk = 0;
//    initial rst = 1;
//    always #1 clk = ~clk;

//    initial
//    begin
//        #5
//        rst = 0;
//        reg2loc = 0;
//        regwrite = 0;
//        #20
//        instruction = 32'b00010100000_000000000000000000001; // Branch
//        #20
//        regwrite = 1;
//        WriteData = 64'b0000000000000000000000000000000000000000000000000000000000000100;
//        instruction = 32'b10001010000_00010_000000_00100_00001; // And 
//        #20
//        regwrite = 0;
//        instruction = 32'b10001011000_00001_000000_00001_00000; // Add    
//        #20
//        instruction = 32'b10101010000_00010_000000_00001_00000; // Or 
//        #20
//        reg2loc = 1;
//        instruction = 32'b10110100000_0000000000000011_00001; // CBNZ
//        #20
//        reg2loc = 0;
//        regwrite = 1;
//        WriteData = 64'b0000000000000000000000000000000000000000000000000000000000000111;
//        instruction = 32'b11001011000_00000_000000_00010_00010; // SUB
//        #20
//        regwrite = 0;
//        instruction = 32'b11110010100_0000000000001111_00001; // MOVK    
//        #20
//        reg2loc = 1;
//        instruction = 32'b11111000000_00000000011_00001_00010; // STUR
//        #20
//        reg2loc = 0;
//        instruction = 32'b11111000010_00000000100_00010_00001; // LDUR 
//    end
//endmodule 
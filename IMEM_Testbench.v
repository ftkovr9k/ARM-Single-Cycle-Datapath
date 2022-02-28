`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2021 02:09:37 PM
// Design Name: 
// Module Name: IMEM_Testbench
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


module IMEM_Testbench();

// Input 
reg[63:0] Address; 

// Output 
wire [31:0] ReadData1; 

reg [31:0] memory_file [0:63];

Instruction_Memory I1 (Address, ReadData1);

	integer i;
	//MY method of filling the memory instead of through a test bench
	initial
		begin
			i = 0;
			memory_file[i] = 32'b11110010100_0000000000000001_00000; //MOVK
			i = i+1;
			memory_file[i] = 32'b11110010100_0000000000000001_00001; //MOVK
			i = i+1;
			memory_file[i] = 32'b10001011000_00001_000000_00000_00010; //ADD
			i = i+1;
		end


endmodule



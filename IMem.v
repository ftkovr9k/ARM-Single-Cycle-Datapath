`timescale 1ns / 1ns
module Instruction_Memory(Address, ReadData1);

	parameter BITSIZE = 32;
	parameter REGSIZE = 64;
	input [REGSIZE-1:0] Address;
	output reg [BITSIZE-1:0] ReadData1;

	reg [BITSIZE-1:0] memory_file [0:REGSIZE-1];	// Entire list of memory

	// Asyncronous read of memory. Was not specified.
	always @(Address, memory_file[Address])
		begin
			ReadData1 = memory_file[Address];
		end

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

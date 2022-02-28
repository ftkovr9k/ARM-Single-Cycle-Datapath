`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2021 02:26:55 PM
// Design Name: 
// Module Name: Top_Module
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


module Top_Module(clk, rst);
input clk, rst;

Datapath DP (.clk(clk), .rst(rst), .ins_Addr(Address), .ins(ReadData1), .memAddr(MemAddress),.memWriteData(MemWriteData),.memReadData(MemReadData),.MemWrite(MemWriteEnable),.MemRead(MemReadEnable), .rReadSelect1(ReadSelect1),.rReadSelect2(ReadSelect2),.rWriteSelect(WriteSelect),.rWriteData(WriteData),.rWriteEnable(WriteEnable),.rReadData1(ReadData1),.rReadData2(ReadData2)); 

Data_Memory DM (.MemAddress(memAddr), .MemWriteData(memWriteData), .MemWriteEnable(MemWrite), .MemReadEnable(MemRead), .MemReadData(memReadData), .clk(clk), .rst(rst));

Instruction_Memory IM (.Address(ins_Addr), .ReadData1(ins)); 

Register_File RF (.ReadSelect1(rReadSelect1), .ReadSelect2(rReadSelect2), .WriteSelect(rWriteSelect), .WriteData(rWriteData), .WriteEnable(rWriteEnable), .ReadData1(rReadData1), .ReadData2(rReadData2), .clk(clk), .rst(rst));  


endmodule
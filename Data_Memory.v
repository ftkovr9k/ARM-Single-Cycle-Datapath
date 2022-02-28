`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2021 10:09:32 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(MemAddress, MemWriteData, MemWriteEnable, MemReadEnable, MemReadData, clk, rst); 

    parameter ADDRSIZE = 64;                    // Each address in ARM is 64 bits 
    parameter MEMSIZE = 64;                     // Total size of memory 
    input [ADDRSIZE-1 : 0] MemWriteData;           // Data to be written to the memory is 64 bits  
    input [ADDRSIZE-1 : 0] MemAddress;          // Address to read data from or write data to is 64 bits 
    input MemWriteEnable, MemReadEnable;        // Enable bits  
    input clk, rst;

    output reg [ADDRSIZE-1:0] MemReadData;         // Data read from the memory is 64 bits 

    reg [ADDRSIZE-1:0] data_mem [MEMSIZE-1:0];  // Memory array 

    integer i;                                  // Used below to rst all memory address 

    // Write to data memory on clk edge 
    always @(posedge clk)

    begin
        // Keep the reset
        if (rst)
        begin
            for (i=0; i<MEMSIZE; i=i+1) data_mem[i] <= 'b0; // rst all ADDRSIZE 
            MemReadData <= 'b0;
        end 
        else
            begin
                if (MemWriteEnable == 1)
                    data_mem[MemAddress] <= MemWriteData; //If MemWrite is enabled 
            end

        if (MemReadEnable == 1) 
        begin
         MemReadData = data_mem[MemAddress];
         end 
    end

endmodule


//module Data_Memory(MemAddress, MemWriteData, MemWriteEnable, MemReadEnable, MemReadData, mem_to_reg, clk, rst);

//    parameter ADDRSIZE = 64; // Each address in ARM is 64 bits 
//    parameter MEMSIZE = 64; // Total size of memory 
//    input [ADDRSIZE-1 : 0] MemWriteData; // Data to be written to the memory is 64 bits  
//    input [ADDRSIZE-1 : 0] MemAddress; // Address to read data from or write data to is 64 bits 
//    input MemWriteEnable, MemReadEnable; // Enable bits  
//    input mem_to_reg, clk, rst;

//    output reg [ADDRSIZE-1:0] MemReadData; // Data read from the memory is 64 bits 

//    reg [ADDRSIZE-1:0] data_mem [MEMSIZE-1:0]; // Memory array 

//    integer i; // Used below to rst all memory address 

//    // Write to data memory on clk edge 
//    always @(posedge clk)

//    begin
//        // Keep the reset
//        if (rst)
//            begin
//                for (i=0; i<MEMSIZE; i=i+1) data_mem[i] <= 'b0; // rst all ADDRSIZE 
//                MemReadData <= 'b0;
//            end
//        else
//            begin
//                if (MemWriteEnable == 1)
//                    data_mem[MemAddress] <= MemWriteData; //If MemWrite is enabled 
//            end

//        if (MemReadEnable == 1)
//        begin
//            if(mem_to_reg == 1)
//                MemReadData = data_mem[MemAddress];

//            else if (mem_to_reg == 0)
//                MemReadData = MemAddress;
//        end
//    end

//endmodule
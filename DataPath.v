module Datapath(

    clk,rst,

    ins_Addr,
    ins,

    memAddr,memWriteData,memReadData,MemWrite,MemRead,

    rReadSelect1,rReadSelect2,rWriteSelect,rWriteData,rWriteEnable,rReadData1,rReadData2

);

    input clk,rst;

    //ports for IMEM
    input  [31:0] ins; //instruction
    output [63:0] ins_Addr; //Instructions Address


    //ports for Data Memory
    input [63:0] memReadData; //Read data from memory
    output [63:0] memAddr; // Data memory Address 
    //output [63:0] memWriteData; // Data wrote to data memory
    output reg [63:0] memWriteData; // Data wrote to data memory
    output  MemWrite; // control signal
    output  MemRead; // control signal


    //ports for Register file
    input [63:0] rReadData1, rReadData2;
    output [4:0] rReadSelect1, rReadSelect2, rWriteSelect; // Control singal for Reginster file
    //output [63:0] rWriteData; // Data wrote to Register file
    output reg [63:0] rWriteData; // Data wrote to Register file
    output rWriteEnable; // Control singal for Reginster file

    wire cond_br, jp, mem2reg, alu_op, alusrc_mux;
    wire z_flag;
    wire [63:0] Extended;
    reg [63:0] AluIn2;
    reg [63:0] temp; 
    

    ALU alu (rReadData1, AluIn2, alu_op, memAddr, z_flag);

    Control control (ins, rWriteEnable, cond_br, jp, MemWrite, MemRead, mem2reg, alu_op, alusrc_mux, rReadSelect1, rReadSelect2, rWriteSelect, Extended);

    Program_Counter PC (cond_br, jp, z_flag, Extended, clk, ins_Addr);

    always@(*) 
    begin 
    temp = rReadData2; 
    memWriteData = temp; 
    end 

    // Choose MUX input for AluIn2 
    always@(rReadData2, Extended, alusrc_mux)
    begin
        case(alusrc_mux)
            1'b0:
            AluIn2 = rReadData2;
            1'b1:
            AluIn2 = Extended;
        endcase
    end

    // Choose MUX input for Data to be written in the Regfile 
    always@(memAddr, memReadData, mem2reg)
    begin
        case(mem2reg)
            1'b0:
            rWriteData = memAddr;
            1'b1:
            rWriteData = memReadData;
        endcase
    end

endmodule

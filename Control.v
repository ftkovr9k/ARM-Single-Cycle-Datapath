`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2021 05:29:54 PM
// Design Name: 
// Module Name: Control
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


module Control(
    input [31:0] instruction, // instruction 
    //output reg reg2loc, mem2reg, regwrite, memread, memwrite, cond_br, jp, // control bits
    output reg regwrite, cond_br, jp, memwrite, memread, mem2reg,
    output reg [3:0] alu_op,
    //output reg [1:0] alusrc_mux,
    output reg alusrc_mux, 
    output reg [4:0] ReadSelect1, ReadSelect2, WriteSelect,
    output reg [63:0] Extended
);

    reg [63:0] z_extend, cbnz_extend, dt_extend, br_extend;
    
    always @(*)
    begin
        case(instruction[31:21])
            11'b00010100000: // BRANCH 
            begin
                //reg2loc = 0; // dont care 
                //alusrc_mux = 2'b00; // dont care 
                alusrc_mux= 1'b0;
                mem2reg = 0; // dont care 
                regwrite = 0;
                memread = 0;
                memwrite = 0;
                cond_br = 0;
                alu_op = 4'b0001; // random alu_opcode as ALU_not used for branch 
                jp = 1;
                
                br_extend = 64'hFFFFFFFFFFE00000; //64'b1111111111111111111111111111111111111111111000000000000000000000;
                br_extend = br_extend | instruction[20:0];
                Extended =  br_extend;
                
                ReadSelect2 = instruction[20:16];
                ReadSelect1 = instruction[9:5]; 
                WriteSelect = instruction[4:0]; 
            end
            11'b10001010000: // AND 
            begin
                //reg2loc = 0;
                //alusrc_mux = 2'b00;
                alusrc_mux= 1'b0;
                mem2reg = 0;
                regwrite = 1;
                memread = 0;
                memwrite = 0;
                cond_br = 0;
                alu_op = 4'b0001;
                jp = 0;
                
                ReadSelect2 = instruction[20:16];
                ReadSelect1 = instruction[9:5]; 
                WriteSelect = instruction[4:0]; 
            end
            11'b10001011000: // ADD 
            begin
                //reg2loc = 0;
                //alusrc_mux = 2'b00;
                alusrc_mux= 1'b0;
                mem2reg = 0;
                regwrite = 1;
                memread = 0;
                memwrite = 0;
                cond_br = 0;
                alu_op = 4'b0110;
                jp = 0;
                
                ReadSelect2 = instruction[20:16];
                ReadSelect1 = instruction[9:5]; 
                WriteSelect = instruction[4:0]; 
            end
            11'b10101010000: // ORR 
            begin
                //reg2loc = 0;
                //alusrc_mux = 2'b00;
                alusrc_mux= 1'b0;
                mem2reg = 0;
                regwrite = 1;
                memread = 0;
                memwrite = 0;
                cond_br = 0;
                alu_op = 4'b0010;
                jp = 0;
                
                ReadSelect2 = instruction[20:16];
                ReadSelect1 = instruction[9:5]; 
                WriteSelect = instruction[4:0]; 
            end
            11'b10110100000: // CBNZ 
            begin
                //reg2loc = 1;
                //alusrc_mux = 2'b00;
                alusrc_mux= 1'b0;
                mem2reg = 0; // dont care 
                regwrite = 0;
                memread = 0;
                memwrite = 0;
                cond_br = 1;
                alu_op = 4'b0101;
                jp = 0;
                
                cbnz_extend = 64'hFFFFFFFFFFFF0000; //64'b1111111111111111111111111111111111111111111111110000000000000000;
                cbnz_extend = cbnz_extend | instruction[20:5];
                Extended = cbnz_extend;
                
                ReadSelect2 = instruction[4:0];
                ReadSelect1 = instruction[9:5];
                WriteSelect = instruction[4:0];  
            end
            11'b11001011000: // SUB 
            begin
                //reg2loc = 0;
                //alusrc_mux = 2'b00;
                alusrc_mux= 1'b0;
                mem2reg = 0;
                regwrite = 1;
                memread = 0;
                memwrite = 0;
                cond_br = 0;
                alu_op = 4'b0111;
                jp = 0;
                
                ReadSelect2 = instruction[20:16];
                ReadSelect1 = instruction[9:5]; 
                WriteSelect = instruction[4:0]; 
            end
            11'b11110010100: // MOVK 
            begin
                //reg2loc = 0;
                //alusrc_mux = 2'b01;
                alusrc_mux= 1'b1;
                mem2reg = 0;
                regwrite = 1;
                memread = 0;
                memwrite = 0;
                cond_br = 0;
                alu_op = 4'b1000;
                jp = 0;
                
                z_extend = 64'h0000000000000000; //64'b0000000000000000000000000000000000000000000000000000000000000000;
                z_extend = z_extend | instruction[20:5];
                Extended = z_extend;
                
                ReadSelect2 = instruction[20:16];
                ReadSelect1 = instruction[4:0];
                WriteSelect = instruction[4:0];
            end
            11'b11111000000: // STUR 
            begin
                //reg2loc = 1;
                //alusrc_mux = 2'b10;
                alusrc_mux= 1'b1;
                mem2reg = 0; // dont care 
                regwrite = 0;
                memread = 0;
                memwrite = 1;
                cond_br = 0;
                alu_op = 4'b0110;
                jp = 0;
                
                dt_extend = 64'hFFFFFFFFFFFFF800; //64'b1111111111111111111111111111111111111111111111111111100000000000;
                dt_extend = dt_extend | instruction[20:10];
                Extended = dt_extend;
                
                ReadSelect2 = instruction[4:0];
                ReadSelect1 = instruction[9:5];
                WriteSelect = instruction[4:0];
            end
            11'b11111000010: // LDUR 
            begin
                //reg2loc = 0; // dont care
                //alusrc_mux = 2'b10;
                alusrc_mux= 1'b1;
                mem2reg = 1;
                regwrite = 1;
                memread = 1;
                memwrite = 0;
                cond_br = 0;
                alu_op = 4'b0110;
                jp = 0;
                
                dt_extend = 64'hFFFFFFFFFFFFF800; //64'b1111111111111111111111111111111111111111111111111111100000000000;
                dt_extend = dt_extend | instruction[20:10];
                Extended = dt_extend;
                
                ReadSelect2 = instruction[20:16];
                ReadSelect1 = instruction[9:5];
                WriteSelect = instruction[4:0];
                
            end
            default:
            begin
                //reg2loc = 0; // dont care
                //alusrc_mux = 2'b00;
                alusrc_mux= 1'b0;
                mem2reg = 0;
                regwrite = 0;
                memread = 0;
                memwrite = 0;
                cond_br = 0;
                alu_op = 4'b0000;
                jp = 0;
                
                Extended = 64'h0;                
                ReadSelect2 = instruction[20:16];
                ReadSelect1 = instruction[9:5];
                WriteSelect = instruction[4:0];
            end
        endcase
    end
endmodule

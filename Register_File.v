module Register_File(ReadSelect1, ReadSelect2, WriteSelect, WriteData, WriteEnable, ReadData1, ReadData2, clk, rst);

    parameter BITSIZE = 64;                                                 // Each register is 64 bits 
    parameter REGSIZE = 32;                                                 // The register file has 32 registers 
    input [$clog2(REGSIZE)-1:0] ReadSelect1, ReadSelect2, WriteSelect;      // Select the register you want to read or write using 5 bits [log(32)]
    input [BITSIZE-1:0] WriteData;                                          // 64-bit data to write in the register 
    input WriteEnable;                                                      // One bit enable wrie enable input 
    output reg [BITSIZE-1:0] ReadData1, ReadData2;                          // 64-bit output of the read registers 
    input clk, rst;

    reg [BITSIZE-1:0] reg_file [REGSIZE-1:0];   // Entire list of registers. Array of size 32 containing 64 bit registers 

    integer i;                                  // Used below to rst all registers

    // Asyncronous read of register file.
    always @(ReadSelect1, reg_file[ReadSelect1])
        begin
            ReadData1 = reg_file[ReadSelect1];
        end

    // Asyncronous read of register file.
    always @(ReadSelect2, reg_file[ReadSelect2])
        begin
            ReadData2 = reg_file[ReadSelect2];
        end

    // Write back to register file on clk edge.
    always @(posedge clk)
        begin
            if (rst)
                for (i=0; i<REGSIZE; i=i+1) reg_file[i] <= 'b0; // rst all registers
            else
            begin
                if (WriteEnable && WriteSelect != 31)
                    reg_file[WriteSelect] <= WriteData; //If writeback is enabled and not 0 register.
            end
        end

endmodule



//module Register_File(instruction, reg2loc, regwrite, clk, rst, WriteData, ReadData1, ReadData2, Extended);

//    parameter BITSIZE = 64; // Each register is 64 bits 
//    parameter REGSIZE = 32; // The register file has 32 registers 
//    input [REGSIZE-1:0] instruction; // 32-bit instruction 
//    input [BITSIZE-1:0] WriteData; // 64-bit data to write in the register  
//    input reg2loc, regwrite, clk, rst;
//    output reg [BITSIZE-1:0] ReadData1, ReadData2, Extended; // 64-bit output of the read registers 

//    reg [BITSIZE-1:0] reg_file [REGSIZE-1:0]; // Entire list of registers. Array of size 32 containing 64 bit registers 
//    reg [$clog2(REGSIZE)-1:0] ReadSelect1, ReadSelect2, WriteSelect;
//    reg [BITSIZE-1:0] z_extend, cbnz_extend, dt_extend, br_extend;

//    integer i;

//    // Assign correct values for each new intruction 
//    always @(*)
//    begin
//        case(instruction[31:21])
//            11'b11111000000: // STUR - sign extend 
//            begin
//                dt_extend = 64'hFFFFFFFFFFFFF800; //64'b1111111111111111111111111111111111111111111111111111100000000000;
//                dt_extend = dt_extend | instruction[20:10];
//                Extended = dt_extend;
//            end
//            11'b11111000010: // LDUR - sign extend
//            begin
//                dt_extend = 64'hFFFFFFFFFFFFF800; //64'b1111111111111111111111111111111111111111111111111111100000000000;
//                dt_extend = dt_extend | instruction[20:10];
//                Extended = dt_extend;
//            end
//            11'b10110100000: // CBNZ - sign extend 
//            begin
//                cbnz_extend = 64'hFFFFFFFFFFFF0000; //64'b1111111111111111111111111111111111111111111111110000000000000000;
//                cbnz_extend = cbnz_extend | instruction[20:5];
//                Extended = cbnz_extend;
//            end
//            11'b00010100000: // BRANCH - sign extend 
//            begin
//                br_extend = 64'hFFFFFFFFFFE00000; //64'b1111111111111111111111111111111111111111111000000000000000000000;
//                br_extend = br_extend | instruction[20:0];
//                Extended =  br_extend;
//            end
//            11'b11110010100: // MOVK - zero extend 
//            begin
//                z_extend = 64'h0000000000000000; //64'b0000000000000000000000000000000000000000000000000000000000000000;
//                z_extend = z_extend | instruction[20:5];
//                Extended = z_extend;
//            end
//            default:
//            Extended = 64'b0;

//        endcase

//        ReadSelect1 = instruction[9:5]; // No condition for Read Register 1 
//        ReadData1 = reg_file[ReadSelect1];

//        if(reg2loc == 0) // Select Rm if reg2loc = 0 
//            begin
//                ReadSelect2 = instruction[20:16];
//                ReadData2 = reg_file[ReadSelect2];

//                if(instruction[31:21] == 11'b11110010100)
//                    begin
//                        ReadSelect1 = instruction[4:0]; // MOVK 
//                        ReadData1 = reg_file[ReadSelect1];
//                    end
//                else
//                    begin
//                        ReadSelect1 = instruction[9:5]; // Other instructions 
//                        ReadData1 = reg_file[ReadSelect1];
//                    end
//            end
//        else if (reg2loc == 1) // Select Rt if reg2loc = 1 
//        begin
//            ReadSelect2 = instruction[4:0];
//            ReadData2 = reg_file[ReadSelect2];

//            ReadSelect1 = instruction[9:5];
//            ReadData1 = reg_file[ReadSelect1];
//        end

//        WriteSelect = instruction[4:0]; // Write Register is always Rd 

//    end


//    // Write back to register file on clk edge.
//    always @(posedge clk)
//    begin
//        if (rst)
//            for (i=0; i<REGSIZE; i=i+1) reg_file[i] <= 'b0; // rst all registers
//        else
//            begin
//                if (regwrite && WriteSelect != 31)
//                    reg_file[WriteSelect] <= WriteData; //If writeback is enabled and not 0 register.
//            end
//    end

//endmodule
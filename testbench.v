`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2025 08:42:17 AM
// Design Name: 
// Module Name: testbench
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



//module testbench;
//    reg clk;
//    reg reset;

//    wire [31:0] PC_Out;
//    wire [31:0] Instr;
//    wire [31:0] RF_Data1;
//    wire [31:0] RF_Data2;
//    wire [31:0] ALU_Out;

//    SabSeUperWala uut (
//        .clk(clk),
//        .reset(reset)
//    );


//    assign PC_Out   = uut.UperWala_inst.pc_reg.pc_out;
//    assign Instr    = uut.UperWala_inst.imem.instruction;
//    assign RF_Data1 = uut.UperWala_inst.rf.readData1;
//    assign RF_Data2 = uut.UperWala_inst.rf.readData2;
//    assign ALU_Out  = uut.UperWala_inst.alu.result;

//    always #5 clk = ~clk;


//    initial begin
       
//        clk = 0;
//        reset = 1;
//        #10 reset = 0;
//    end

   
//    initial begin
//        // Test Instruction: doublei x6, x2, 0 (x6 = x2 * 2)
//        uut.UperWala_inst.imem.memory[0] = 32'b000000000000_00010_000_00110_0101011; // doublei x6, x2, 0
        
//        // Test Data: Setting x2 to 10
//        uut.UperWala_inst.rf.registers[2] = 32'd10; // x2 = 10

//        // Run simulation for 20nanoseconds to observe output
//        #20 $finish;
//    end

//endmodule




module testbench;

    
    reg clk;
    reg reset;

    
    wire [31:0] PC_Out;
    wire [31:0] Instr;
    wire [31:0] RF_Data1;
    wire [31:0] RF_Data2;
    wire [31:0] ALU_Out;


    wire [31:0] x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12;

    
    SabSeUperWala uut (
        .clk(clk),
        .reset(reset)
    );


    assign PC_Out   = uut.UperWala_inst.pc_reg.pc_out;
    assign Instr    = uut.UperWala_inst.imem.instruction;
    assign RF_Data1 = uut.UperWala_inst.rf.readData1;
    assign RF_Data2 = uut.UperWala_inst.rf.readData2;
    assign ALU_Out  = uut.UperWala_inst.alu_out;

    assign x1  = uut.UperWala_inst.rf.registers[1];
    assign x2  = uut.UperWala_inst.rf.registers[2];
    assign x3  = uut.UperWala_inst.rf.registers[3];
    assign x4  = uut.UperWala_inst.rf.registers[4];
    assign x5  = uut.UperWala_inst.rf.registers[5];
    assign x6  = uut.UperWala_inst.rf.registers[6];
    assign x7  = uut.UperWala_inst.rf.registers[7];
    assign x8  = uut.UperWala_inst.rf.registers[8];
    assign x9  = uut.UperWala_inst.rf.registers[9];
    assign x10 = uut.UperWala_inst.rf.registers[10];
    assign x11 = uut.UperWala_inst.rf.registers[11];
    assign x12 = uut.UperWala_inst.rf.registers[12];


    always #5 clk = ~clk;


    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;

      
      
    end

   
    initial begin
        
        uut.UperWala_inst.imem.memory[0] = 32'b0000000_00100_00011_000_00010_0110011; // add x2, x3, x4
        uut.UperWala_inst.imem.memory[1] = 32'b0100000_00001_00010_000_00101_0110011; // sub x5, x2, x1
        uut.UperWala_inst.imem.memory[2] = 32'b0000000_00101_00110_111_00111_0110011; // and x7, x5, x6
        uut.UperWala_inst.imem.memory[3] = 32'b0000000_00101_00110_110_01000_0110011; // or x8, x5, x6
        uut.UperWala_inst.imem.memory[4] = 32'b000000000000_00010_000_01001_0101011;  // doublei x9, x2
        uut.UperWala_inst.imem.memory[5] = 32'b0001010_00001_00101_010_01010_0100011; // sw x5, 10(x1)
        uut.UperWala_inst.imem.memory[6] = 32'b0001010_00001_01010_010_01011_0000011; // lw x11, 10(x1)
        uut.UperWala_inst.imem.memory[7] = 32'b0000000_00011_00101_010_01100_0110011; // slt x12, x5, x3


        uut.UperWala_inst.rf.registers[1] = 32'd20;
        uut.UperWala_inst.rf.registers[3] = 32'd5;
        uut.UperWala_inst.rf.registers[4] = 32'd10;
        uut.UperWala_inst.rf.registers[5] = 32'd8;
        uut.UperWala_inst.rf.registers[6] = 32'd3;

   
        #200 $finish;
    end

endmodule



`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2025 09:33:44 AM
// Design Name: 
// Module Name: SabSeUperWala
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


//module SabSeUperWala(input clk, reset);
//    wire RegWrite, ALUSrc, MemWrite, MemRead, MemtoReg, Branch;
//    wire [1:0] ALUOp;
//    wire zero;
//    wire [6:0] opcode;
//    wire [2:0] funct3;
//    wire funct7_5;
//    wire [31:0] alu_out;

//    // Instantiate the Datapath (with the correct instance name)
//    UperWala UperWala_inst (
//        .clk(clk), .reset(reset),
//        .RegWrite(RegWrite), .ALUSrc(ALUSrc), .MemWrite(MemWrite),
//        .MemRead(MemRead), .MemtoReg(MemtoReg), .Branch(Branch),
//        .ALUOp(ALUOp),
//        .zero(zero),
//        .opcode(opcode), .funct3(funct3), .funct7_5(funct7_5),
//        .alu_out(alu_out)
//    );

//    // Instantiate the Control Unit
//    ControlUnit cu(
//        .opcode(opcode),
//        .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg),
//        .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite)
//    );

//endmodule

//module SabSeUperWala(input clk, reset);
//    wire [31:0] pc, next_pc, instr;
//    wire [31:0] rd1, rd2, imm, alu_result, mem_data, wb_data;
//    wire [3:0] alu_ctrl;
//    wire [4:0] rs1, rs2, rd;
//    wire [6:0] opcode;
//    wire [2:0] funct3;
//    wire funct7_5;
//    wire RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc;
//    wire [1:0] ALUOp;

//    // Program Counter
//    PC pc_reg(clk, reset, next_pc, pc);

//    // Instruction Memory
//    InstructionMemory imem(pc, instr);

//    // IF/ID pipeline register
//    wire [31:0] IF_ID_pc, IF_ID_instr;
//    IF_ID if_id(clk, reset, pc, instr, IF_ID_pc, IF_ID_instr);

//    assign opcode = IF_ID_instr[6:0];
//    assign rs1 = IF_ID_instr[19:15];
//    assign rs2 = IF_ID_instr[24:20];
//    assign rd = IF_ID_instr[11:7];
//    assign funct3 = IF_ID_instr[14:12];
//    assign funct7_5 = IF_ID_instr[30];

//    // Control Unit
//    ControlUnit cu(opcode, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);

//    // Register File
//    RegisterFile rf(clk, RegWrite_WB, rs1, rs2, rd_WB, wb_data, rd1, rd2);

//    // Immediate Generator
//    ImmGen immgen(IF_ID_instr, imm);

//    // ID/EX pipeline register
//    wire [31:0] ID_EX_pc, ID_EX_rd1, ID_EX_rd2, ID_EX_imm;
//    wire [4:0] ID_EX_rs1, ID_EX_rs2, ID_EX_rd;
//    wire [2:0] ID_EX_funct3;
//    wire ID_EX_funct7_5;
//    wire ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_ALUSrc;
//    wire [1:0] ID_EX_ALUOp;
//    ID_EX id_ex(clk, reset, IF_ID_pc, rd1, rd2, imm,
//                rs1, rs2, rd, funct3, funct7_5,
//                RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc, ALUOp,
//                ID_EX_pc, ID_EX_rd1, ID_EX_rd2, ID_EX_imm,
//                ID_EX_rs1, ID_EX_rs2, ID_EX_rd,
//                ID_EX_funct3, ID_EX_funct7_5,
//                ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_ALUSrc, ID_EX_ALUOp);

//    // ALU Control
//    ALUControl alu_ctrl_unit(ID_EX_ALUOp, ID_EX_funct3, ID_EX_funct7_5, alu_ctrl);

//    // ALU input MUX
//    wire [31:0] alu_in2 = ID_EX_ALUSrc ? ID_EX_imm : ID_EX_rd2;

//    // ALU
//    ALU alu(ID_EX_rd1, alu_in2, alu_ctrl, alu_result);

//    // EX/MEM pipeline register
//    wire [31:0] EX_MEM_alu_result, EX_MEM_rd2;
//    wire [4:0] EX_MEM_rd;
//    wire EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_MemRead, EX_MEM_MemWrite;
//    EX_MEM ex_mem(clk, reset, alu_result, ID_EX_rd2, ID_EX_rd,
//                  ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_MemRead, ID_EX_MemWrite,
//                  EX_MEM_alu_result, EX_MEM_rd2, EX_MEM_rd,
//                  EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_MemRead, EX_MEM_MemWrite);

//    // Data Memory
//    DataMemory dmem(clk, EX_MEM_MemWrite, EX_MEM_MemRead, EX_MEM_alu_result, EX_MEM_rd2, mem_data);

//    // MEM/WB pipeline register
//    wire [31:0] MEM_WB_mem_data, MEM_WB_alu_result;
//    wire [4:0] rd_WB;
//    wire RegWrite_WB, MemtoReg_WB;
//    MEM_WB mem_wb(clk, reset, mem_data, EX_MEM_alu_result, EX_MEM_rd,
//                  EX_MEM_RegWrite, EX_MEM_MemtoReg,
//                  MEM_WB_mem_data, MEM_WB_alu_result, rd_WB,
//                  RegWrite_WB, MemtoReg_WB);

//    // Write Back MUX
//    assign wb_data = MemtoReg_WB ? MEM_WB_mem_data : MEM_WB_alu_result;

//    // PC increment (naive; add branch logic if needed)
//    assign next_pc = pc + 4;
//endmodule

//module SabSeUperWala(input clk, reset);
//    wire RegWrite, ALUSrc, MemWrite, MemRead, MemtoReg, Branch;
//    wire [1:0] ALUOp;
//    wire zero;
//    wire [6:0] opcode;
//    wire [2:0] funct3;
//    wire funct7_5;
//    wire [31:0] alu_out;

//    UperWala UperWala_inst (
//        .clk(clk), .reset(reset),
//        .RegWrite(RegWrite), .ALUSrc(ALUSrc), .MemWrite(MemWrite),
//        .MemRead(MemRead), .MemtoReg(MemtoReg), .Branch(Branch),
//        .ALUOp(ALUOp),
//        .zero(zero),
//        .opcode(opcode), .funct3(funct3), .funct7_5(funct7_5),
//        .alu_out(alu_out)
//    );

//    ControlUnit cu(
//        .opcode(opcode),
//        .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg),
//        .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite)
//    );
//endmodule


module SabSeUperWala(input clk, reset);
    wire RegWrite, ALUSrc, MemWrite, MemRead, MemtoReg;
    wire [1:0] ALUOp;
    wire zero;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire funct7_5;
    wire [31:0] alu_out;

    wire [31:0] instruction;
    wire [31:0] instr_pc;

    // Fetch instruction to pass opcode/funct3/funct7
    wire [31:0] dummy_pc, dummy_instr;
    PC dummy_pc_reg(clk, reset, 32'b0, dummy_pc);
    InstructionMemory dummy_imem(dummy_pc, dummy_instr);
    assign opcode = dummy_instr[6:0];
    assign funct3 = dummy_instr[14:12];
    assign funct7_5 = dummy_instr[30];

    UperWala UperWala_inst (
        .clk(clk), .reset(reset),
        .RegWrite(RegWrite), .ALUSrc(ALUSrc), .MemWrite(MemWrite),
        .MemRead(MemRead), .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .zero(zero),
        .opcode(opcode), .funct3(funct3), .funct7_5(funct7_5),
        .alu_out(alu_out)
    );

    ControlUnit cu(
        .opcode(opcode),
        .MemRead(MemRead), .MemtoReg(MemtoReg),
        .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite)
    );
endmodule
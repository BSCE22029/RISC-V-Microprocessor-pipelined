`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2025 07:53:18 AM
// Design Name: 
// Module Name: UperWala
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


//module UperWala(
//    input clk, reset,
//    input RegWrite, ALUSrc, MemWrite, MemRead, MemtoReg, Branch,
//    input [1:0] ALUOp,
//    output zero,
//    output [6:0] opcode,
//    output [2:0] funct3,
//    output funct7_5,
//    output [31:0] alu_out
//);
//    wire [31:0] pc, next_pc, instr, imm, shift_imm, rd1, rd2, alu_in2, dm_out, wb_data;
//    wire [3:0] alu_control;

//    assign opcode = instr[6:0];
//    assign funct3 = instr[14:12];
//    assign funct7_5 = instr[30];

//    PC pc_reg(clk, reset, next_pc, pc);
//    InstructionMemory imem(pc, instr);
//    RegisterFile rf(clk, RegWrite, instr[19:15], instr[24:20], instr[11:7], wb_data, rd1, rd2);
//    ImmGen immgen(instr, imm);
//    ShiftLeft32 shift(imm, shift_imm);
//    MUX32BIt mux_alu(rd2, imm, ALUSrc, alu_in2);
//    ALU alu(rd1, alu_in2, alu_control, alu_out, zero);
//    DM dmem(clk, MemWrite, MemRead, alu_out, rd2, dm_out);
//    MUX32BIt mux_mem(alu_out, dm_out, MemtoReg, wb_data);
//    Adder32 pc_plus4(pc, 32'd4, next_pc);
//    ALUControl alu_cu(ALUOp, funct3, funct7_5, alu_control);
//endmodule

module UperWala(
    input clk, reset,
    input RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc,
    input [1:0] ALUOp,
    input [6:0] opcode,
    input [2:0] funct3,
    input funct7_5,
    output zero,
    output [31:0] alu_out
);
    wire [31:0] pc, next_pc, instr;
    wire [31:0] rd1, rd2, imm, mem_data, wb_data;
    wire [3:0] alu_ctrl;
    wire [4:0] rs1, rs2, rd;

    // Forwarding signals
    wire [4:0] EX_MEM_rd, rd_WB;
    wire EX_MEM_RegWrite, RegWrite_WB;

    // Program Counter
    PC pc_reg(clk, reset, next_pc, pc);
    InstructionMemory imem(pc, instr);

    // IF/ID pipeline register
    wire [31:0] IF_ID_pc, IF_ID_instr;
    IF_ID if_id(clk, reset, pc, instr, IF_ID_pc, IF_ID_instr);

    assign rs1 = IF_ID_instr[19:15];
    assign rs2 = IF_ID_instr[24:20];
    assign rd  = IF_ID_instr[11:7];

    RegisterFile rf(clk, RegWrite, rs1, rs2, rd, wb_data, rd1, rd2);
    ImmGen immgen(IF_ID_instr, imm);

    wire [31:0] ID_EX_pc, ID_EX_rd1, ID_EX_rd2, ID_EX_imm;
    wire [4:0] ID_EX_rs1, ID_EX_rs2, ID_EX_rd;
    wire [2:0] ID_EX_funct3;
    wire ID_EX_funct7_5;
    wire ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_ALUSrc;
    wire [1:0] ID_EX_ALUOp;

    ID_EX id_ex(clk, reset, IF_ID_pc, rd1, rd2, imm,
                rs1, rs2, rd, funct3, funct7_5,
                RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc, ALUOp,
                ID_EX_pc, ID_EX_rd1, ID_EX_rd2, ID_EX_imm,
                ID_EX_rs1, ID_EX_rs2, ID_EX_rd,
                ID_EX_funct3, ID_EX_funct7_5,
                ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_ALUSrc, ID_EX_ALUOp);

    ALUControl alu_ctrl_unit(ID_EX_ALUOp, ID_EX_funct3, ID_EX_funct7_5, alu_ctrl);

    wire [1:0] forwardA, forwardB;
    wire [31:0] alu_src1, alu_src2;

    ForwardingUnit fw(
        .ID_EX_rs1(ID_EX_rs1), .ID_EX_rs2(ID_EX_rs2),
        .EX_MEM_rd(EX_MEM_rd), .MEM_WB_rd(rd_WB),
        .EX_MEM_RegWrite(EX_MEM_RegWrite), .MEM_WB_RegWrite(RegWrite_WB),
        .forwardA(forwardA), .forwardB(forwardB)
    );

    wire [31:0] reg_or_imm = ID_EX_ALUSrc ? ID_EX_imm : ID_EX_rd2;
    assign alu_src1 = (forwardA == 2'b10) ? EX_MEM_alu_result :
                      (forwardA == 2'b01) ? wb_data :
                      ID_EX_rd1;

    assign alu_src2 = (forwardB == 2'b10) ? EX_MEM_alu_result :
                      (forwardB == 2'b01) ? wb_data :
                      reg_or_imm;

    ALU alu(alu_src1, alu_src2, alu_ctrl, alu_out);

    wire [31:0] EX_MEM_alu_result, EX_MEM_rd2;
    EX_MEM ex_mem(clk, reset, alu_out, ID_EX_rd2, ID_EX_rd,
                  ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_MemRead, ID_EX_MemWrite,
                  EX_MEM_alu_result, EX_MEM_rd2, EX_MEM_rd,
                  EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_MemRead, EX_MEM_MemWrite);

    DM dmem(clk, EX_MEM_MemWrite, EX_MEM_MemRead, EX_MEM_alu_result, EX_MEM_rd2, mem_data);

    wire [31:0] MEM_WB_mem_data, MEM_WB_alu_result;
    MEM_WB mem_wb(clk, reset, mem_data, EX_MEM_alu_result, EX_MEM_rd,
                  EX_MEM_RegWrite, EX_MEM_MemtoReg,
                  MEM_WB_mem_data, MEM_WB_alu_result, rd_WB,
                  RegWrite_WB, MemtoReg_WB);

    assign wb_data = MemtoReg_WB ? MEM_WB_mem_data : MEM_WB_alu_result;
    assign zero = (alu_out == 0);
    assign next_pc = pc + 4;
endmodule


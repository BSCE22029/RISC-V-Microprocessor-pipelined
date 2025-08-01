`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2025 10:57:02 AM
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(input clk, reset,
    input [31:0] pc_in, rd1_in, rd2_in, imm_in,
    input [4:0] rs1_in, rs2_in, rd_in,
    input [2:0] funct3_in,
    input funct7_5_in,
    input RegWrite_in, MemtoReg_in, MemRead_in, MemWrite_in, ALUSrc_in,
    input [1:0] ALUOp_in,
    output reg [31:0] pc_out, rd1_out, rd2_out, imm_out,
    output reg [4:0] rs1_out, rs2_out, rd_out,
    output reg [2:0] funct3_out,
    output reg funct7_5_out,
    output reg RegWrite_out, MemtoReg_out, MemRead_out, MemWrite_out, ALUSrc_out,
    output reg [1:0] ALUOp_out);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= 0; rd1_out <= 0; rd2_out <= 0; imm_out <= 0;
            rs1_out <= 0; rs2_out <= 0; rd_out <= 0;
            funct3_out <= 0; funct7_5_out <= 0;
            RegWrite_out <= 0; MemtoReg_out <= 0; MemRead_out <= 0; MemWrite_out <= 0; ALUSrc_out <= 0;
            ALUOp_out <= 0;
        end else begin
            pc_out <= pc_in; rd1_out <= rd1_in; rd2_out <= rd2_in; imm_out <= imm_in;
            rs1_out <= rs1_in; rs2_out <= rs2_in; rd_out <= rd_in;
            funct3_out <= funct3_in; funct7_5_out <= funct7_5_in;
            RegWrite_out <= RegWrite_in; MemtoReg_out <= MemtoReg_in;
            MemRead_out <= MemRead_in; MemWrite_out <= MemWrite_in;
            ALUSrc_out <= ALUSrc_in; ALUOp_out <= ALUOp_in;
        end
    end
endmodule

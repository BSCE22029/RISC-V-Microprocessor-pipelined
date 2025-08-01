`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2025 11:00:42 AM
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(input clk, reset,
    input [31:0] alu_result_in, rd2_in,
    input [4:0] rd_in,
    input RegWrite_in, MemtoReg_in, MemRead_in, MemWrite_in,
    output reg [31:0] alu_result_out, rd2_out,
    output reg [4:0] rd_out,
    output reg RegWrite_out, MemtoReg_out, MemRead_out, MemWrite_out);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            alu_result_out <= 0; rd2_out <= 0; rd_out <= 0;
            RegWrite_out <= 0; MemtoReg_out <= 0; MemRead_out <= 0; MemWrite_out <= 0;
        end else begin
            alu_result_out <= alu_result_in; rd2_out <= rd2_in; rd_out <= rd_in;
            RegWrite_out <= RegWrite_in; MemtoReg_out <= MemtoReg_in;
            MemRead_out <= MemRead_in; MemWrite_out <= MemWrite_in;
        end
    end
endmodule

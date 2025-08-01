`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2025 08:36:24 PM
// Design Name: 
// Module Name: ImmGen
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


module ImmGen(input [31:0] instr, output reg [31:0] immOut);
    always @(*) begin
        case (instr[6:0])
            7'b0010011: immOut = {{20{instr[31]}}, instr[31:20]}; // I-type
            7'b0000011: immOut = {{20{instr[31]}}, instr[31:20]}; // Load immediate
            7'b0100011: immOut = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S-type
            default: immOut = 0;
        endcase
    end
endmodule

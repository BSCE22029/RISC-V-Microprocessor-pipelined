`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 10:58:11 PM
// Design Name: 
// Module Name: ALU
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



module ALU(input [31:0] a, b, input [3:0] aluControl, output reg [31:0] result ,output reg zero);
    always @(*) begin
        case (aluControl)
            4'b0000: result = a & b; 
            4'b0001: result = a | b; 
            4'b0010: result = a + b; 
            4'b0110: result = a - b; 
            4'b0111: result = (a < b) ? 1 : 0; 
            4'b0100: result = a << 1; 

            default: result = 0;
        endcase
    end
endmodule

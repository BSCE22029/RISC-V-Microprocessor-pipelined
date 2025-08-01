`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2025 08:29:10 PM
// Design Name: 
// Module Name: DM
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


module DM(
input clk, memWrite, memRead, input [31:0] addr, writeData, output reg [31:0] readData);
    reg [31:0] memory [0:255];
    always @(*) begin
        if (memRead) readData = memory[addr >> 2];
        else readData = 32'b0;
    end
    always @(posedge clk) begin
        if (memWrite) memory[addr >> 2] <= writeData;
    end
endmodule

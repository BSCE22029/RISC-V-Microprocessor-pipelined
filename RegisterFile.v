`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 10:51:52 PM
// Design Name: 
// Module Name: RegisterFile
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



module RegisterFile(input clk, input regWrite, input [4:0] readReg1, readReg2, writeReg,
 input [31:0] writeData, output [31:0] readData1, readData2);
    reg [31:0] registers [0:31];
    assign readData1 = registers[readReg1];
    assign readData2 = registers[readReg2];
    always @(posedge clk) begin
        if (regWrite) registers[writeReg] <= writeData;
    end
endmodule

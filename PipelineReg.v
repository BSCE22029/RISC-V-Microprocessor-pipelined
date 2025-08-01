`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2025 10:54:04 AM
// Design Name: 
// Module Name: PipelineReg
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


module PipelineReg #(parameter WIDTH = 32)(input clk, reset, input [WIDTH-1:0] din, output reg [WIDTH-1:0] dout);
    always @(posedge clk or posedge reset) begin
        if (reset)
            dout <= 0;
        else
            dout <= din;
    end
endmodule
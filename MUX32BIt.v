`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2025 09:18:33 AM
// Design Name: 
// Module Name: MUX32BIt
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


module MUX32BIt(input [31:0] in0, in1, input sel, output reg [31:0] out);
    always @(*) begin
        out = sel ? in1 : in0;
    end
endmodule


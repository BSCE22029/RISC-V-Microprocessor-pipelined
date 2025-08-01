`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2025 08:33:18 PM
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(
    input [4:0] ID_EX_rs1, ID_EX_rs2,
    input [4:0] EX_MEM_rd, MEM_WB_rd,
    input EX_MEM_RegWrite, MEM_WB_RegWrite,
    output reg [1:0] forwardA, forwardB
);
    always @(*) begin
        // Default: no forwarding
        forwardA = 2'b00;
        forwardB = 2'b00;

        // EX hazard
        if (EX_MEM_RegWrite && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_rs1))
            forwardA = 2'b10;
        if (EX_MEM_RegWrite && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_rs2))
            forwardB = 2'b10;

        // MEM hazard
        if (MEM_WB_RegWrite && (MEM_WB_rd != 0) && (MEM_WB_rd == ID_EX_rs1) && !(EX_MEM_RegWrite && (EX_MEM_rd == ID_EX_rs1)))
            forwardA = 2'b01;
        if (MEM_WB_RegWrite && (MEM_WB_rd != 0) && (MEM_WB_rd == ID_EX_rs2) && !(EX_MEM_RegWrite && (EX_MEM_rd == ID_EX_rs2)))
            forwardB = 2'b01;
    end
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2025 12:21:59 PM
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(
    input [1:0] ALUOp,        // Control signal from Control Unit
    input [2:0] funct3,       // Instruction field
    input funct7_5,           // MSB of funct7 (bit 30 from instruction)
    output reg [3:0] ALUControl // ALU operation control signal
);

    always @(*) begin
        case (ALUOp)
            // ALUOp = 00: ADD (lw, sw)
            2'b00: ALUControl = 4'b0010; // Add
            
            // ALUOp = 01: SUBTRACT (beq)
            2'b01: ALUControl = 4'b0110; // Subtract
            
            // ALUOp = 10: R-type operations
            2'b10: begin
                case (funct3)
                    3'b000: ALUControl = (funct7_5) ? 4'b0110 : 4'b0010; // SUB or ADD
                    3'b111: ALUControl = 4'b0000; // AND
                    3'b110: ALUControl = 4'b0001; // OR
                    default: ALUControl = 4'bxxxx; // Undefined
                endcase
            end

            // ALUOp = 11: Custom ALUOp for new instruction (doublei)
            2'b11: begin
                case (funct3)
                    3'b000: ALUControl = 4'b0100; // DOUBLE (shift left by 1)
                    default: ALUControl = 4'bxxxx; // Undefined
                endcase
            end

            // Default case if ALUOp doesn't match
            default: ALUControl = 4'b0000; // Safe default (AND)
        endcase
    end

endmodule


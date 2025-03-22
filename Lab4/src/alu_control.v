`timescale 1ns / 1ps
// <your student id> 111550088

/* Copy your ALU Control (if you have one) from Lab 2 */
module alu_control (
    input  [1:0] alu_op,    // ALUOp
    input  [5:0] funct,     // Funct field
    output [3:0] operation  // Operation
);
    /* implement "combinational" logic satisfying requirements in FIGURE 4.12 */
    assign operation[3] = 0;
    assign operation[2] = (funct[1] & alu_op[1]) | alu_op[0];
    assign operation[1] = ~alu_op[1] | ~funct[2];
    assign operation[0] = (funct[0] | funct[3]) & alu_op[1];

endmodule

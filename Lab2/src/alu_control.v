`timescale 1ns / 1ps
// <your student id> 111550088

/** [Reading] 4.4 p.316-318
 * "The ALU Control"
 */
/**
 * This module is the ALU control in FIGURE 4.17
 * You can implement it by any style you want.
 * There's a more hardware efficient design in Appendix D.
 */

/* checkout FIGURE 4.12/13 */
module alu_control (
    input  [1:0] alu_op,    // ALUOp
    input  [5:0] funct,     // Funct field
    output [3:0] operation  // Operation
);
    wire and1, and2, or1;
    wire inv1, aluop1_inv, f2_inv;
    /* implement "combinational" logic satisfying requirements in FIGURE 4.12 */
    AND
        m1(and1, alu_op[1], funct[1]),
        m2(operation[0], alu_op[1], or1),
        m3(operation[3], alu_op[0], inv1);
    OR
        o1(or1, funct[3], funct[0]),
        o2(operation[2], alu_op[0], and1),
        o3(operation[1], aluop1_inv, f2_inv);

    NOT
        n1(inv1, alu_op[0]),
        n2(f2_inv, funct[2]),
        n3(aluop1_inv, alu_op[1]);

endmodule

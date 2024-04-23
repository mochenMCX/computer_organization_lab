`timescale 1ns / 1ps
// <your student id> 111550088

/** [Reading] 4.4 p.318-321
 * "Designing the Main Control Unit"
 */
/** [Prerequisite] alu_control.v
 * This module is the Control unit in FIGURE 4.17
 * You can implement it by any style you want.
 */

/* checkout FIGURE 4.16/18 to understand each definition of control signals */
module control (
    input  [5:0] opcode,      // the opcode field of a instruction is [?:?]
    output       reg_dst,     // select register destination: rt(0), rd(1)
    output       alu_src,     // select 2nd operand of ALU: rt(0), sign-extended(1)
    output       mem_to_reg,  // select data write to register: ALU(0), memory(1)
    output       reg_write,   // enable write to register file
    output       mem_read,    // enable read form data memory
    output       mem_write,   // enable write to data memory
    output       branch,      // this is a branch instruction or not (work with alu.zero)
    output [1:0] alu_op       // ALUOp passed to ALU Control unit
);

    /* implement "combinational" logic satisfying requirements in FIGURE 4.18 */
    /* You can check the "Green Card" to get the opcode/funct for each instruction. */
    wire r_format, lw, sw, beq;
    assign r_format = &(~opcode);
    assign lw = opcode[5] & ~opcode[4] & ~opcode[3] & ~opcode[2] & opcode[1] & opcode[0];
    assign sw = opcode[5] & ~opcode[4] & opcode[3] & ~opcode[2] & opcode[1] & opcode[0];
    assign beq = ~opcode[5] & ~opcode[4] & ~opcode[3] & opcode[2] & ~opcode[1] & ~opcode[0];

    assign reg_dst = r_format;
    assign alu_src = lw | sw;
    assign mem_to_reg = lw;
    assign RegWrite = r_format | lw;
    assign mem_read = lw;
    assign mem_write = sw;
    assign branch = beq;
    assign alu_op = {r_format, beq};
endmodule

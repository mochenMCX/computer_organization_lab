`timescale 1ns / 1ps
// <your student id> 111550088

/* Copy your Control (and its components) from Lab 2 */
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

    wire lw;
    wire addi;
    assign addi = opcode == 6'b001000;
    assign lw = opcode==6'b100011;
    assign reg_dst = opcode== 6'b000000;
    assign alu_src = lw || opcode==6'b101011 || addi;
    assign mem_to_reg = lw;
    assign reg_write = opcode == 6'b000000 || lw || addi;
    assign mem_read = lw;
    assign mem_write = opcode==6'b101011;
    assign branch = opcode == 6'b000100;
    assign alu_op[1] = opcode== 6'b000000;
    assign alu_op[0] = opcode== 6'b000100;
    
endmodule

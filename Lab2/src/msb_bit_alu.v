`timescale 1ns / 1ps
// <your student id> 111550088

/* checkout FIGURE C.5.10 (Bottom) */
/* [Prerequisite] complete bit_alu.v */
module msb_bit_alu (
    input        a,          // 1 bit, a
    input        b,          // 1 bit, b
    input        less,       // 1 bit, Less
    input        a_invert,   // 1 bit, Ainvert
    input        b_invert,   // 1 bit, Binvert
    input        carry_in,   // 1 bit, CarryIn
    input  [1:0] operation,  // 2 bit, Operation
    output       result,     // 1 bit, Result (Must it be a reg?)
    output       set,        // 1 bit, Set
    output       overflow    // 1 bit, Overflow
);
    wire ai, bi, sum, over; // need to be change
    assign ai = (a_invert == 1)? ~a: a;
    assign bi = (b_invert == 1)? ~b : b;
    
    assign sum = ai ^ bi ^ carry_in;
    assign over = ~(ai ^ bi) & (bi ^ carry_in);
    assign overflow = (operation == 2'b10) & over;
    assign set = over ^ sum;
    assign result = ((operation == 2'b10) & sum) | ((operation == 2'b00) & (ai & bi)) | ((operation == 2'b01) & (ai | bi));
    /* Try to implement the most significant bit ALU by yourself! */

endmodule

`timescale 1ns / 1ps
// <your student id> 111550088

/* Copy your ALU (and its components) from Lab 1 */
module alu (
    input  [31:0] a,        // 32 bits, source 1 (A)
    input  [31:0] b,        // 32 bits, source 2 (B)
    input  [ 3:0] ALU_ctl,  // 4 bits, ALU control input
    output [31:0] result,   // 32 bits, result
    output        zero,     // 1 bit, set to 1 when the output is 0
    output        overflow  // 1 bit, overflow
);
    /* [step 1] instantiate multiple modules */
    /**
     * First, we need wires to expose the I/O of 32 1-bit ALUs.
     * You might wonder if we can declare `operation` by `wire [31:0][1:0]` for better readability.
     * No, that is a feature call "packed array" in "System Verilog" but we are using "Verilog" instead.
     * System Verilog and Verilog are similar to C++ and C by their relationship.
     */
    wire [31:0] less, a_invert, b_invert, carry_in;
    wire [31:0] carry_out;
    wire [63:0] operation;  // flatten vector
    wire        set;  // set of most significant bit
    /**
     * Second, we instantiate the less significant 31 1-bit ALUs
     * How are these modules wried?
     */
    bit_alu lsbs[30:0] (
        .a        (a[30:0]),
        .b        (b[30:0]),
        .less     (less[30:0]),
        .a_invert (a_invert[30:0]),
        .b_invert (b_invert[30:0]),
        .carry_in (carry_in[30:0]),
        .operation(operation[61:0]),
        .result   (result[30:0]),
        .carry_out(carry_out[30:0])
    );
    /* Third, we instantiate the most significant 1-bit ALU */
    msb_bit_alu msb (
        .a        (a[31]),
        .b        (b[31]),
        .less     (less[31]),
        .a_invert (a_invert[31]),
        .b_invert (b_invert[31]),
        .carry_in (carry_in[31]),
        .operation(operation[63:62]),
        .result   (result[31]),
        .set      (set),
        .overflow (overflow)
    );
    /** [step 2] wire these ALUs correctly
     * 1. `a` & `b` are already wired.
     * 2. About `less`, only the least significant bit should be used when SLT, so the other 31 bits ...?
     *    checkout: https://www.chipverify.com/verilog/verilog-concatenation
     * 3. `a_invert` should all connect to ?
     * 4. `b_invert` should all connect to ? (name it `b_negate` first!)
     * 5. What is the relationship between `carry_in[i]` & `carry_out[i-1]` ?
     * 6. `carry_in[0]` and `b_invert` appears to be the same when SUB... , right?
     * 7. `operation` should be wired to which 2 bits in `ALU_ctl` ?
     * 8. `result` is already wired.
     * 9. `set` should be wired to which `less` bit?
     * 10. `overflow` is already wired.
     * 11. You need another logic for `zero` output.
     */
    assign less[31:1]= 0;
    assign less[0] = set;
    assign a_invert = (ALU_ctl[3] == 1)? {32{1'b1}} : {32{1'b0}};
    assign b_invert = (ALU_ctl[2] == 1)? {32{1'b1}} : {32{1'b0}};
    assign carry_in[31:1] = carry_out[30:0];
    assign carry_in[0] = (ALU_ctl[2] == 1'b1);
    assign zero = ~(|(result));
    assign operation = {32{ALU_ctl[1], ALU_ctl[0]}};
endmodule
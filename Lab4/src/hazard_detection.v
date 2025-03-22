`timescale 1ns / 1ps
// <your student id> 111550088

/** [Reading] 4.7 p.372-375
 * Understand when and how to detect stalling caused by data hazards.
 * When read a reg right after it was load from memory,
 * it is impossible to solve the hazard just by forwarding.
 */

/* checkout FIGURE 4.59 to understand why a stall is needed */
/* checkout FIGURE 4.60 for how this unit should be connected */
module hazard_detection (
    input  [5:0] forward_opcode,
    input        ID_EX_mem_read,
    input        ID_EX_reg_write,
    input  [4:0] ID_EX_rt,
    input  [4:0] ID_EX_rd,
    input  [4:0] IF_ID_rs,
    input  [4:0] IF_ID_rt,
    input        EX_MEM_mem_read,
    input  [4:0] EX_MEM_rt,
    output       pc_write,        // only update PC when this is set
    output       IF_ID_write,     // only update IF/ID stage registers when this is set
    output       stall            // insert a stall (bubble) in ID/EX when this is set
);

    /** [step 3] Stalling
     * 1. calculate stall by equation from textbook.
     * 2. Should pc be written when stall?
     * 3. Should IF/ID stage registers be updated when stall?
     */
    wire branch;
    assign branch = (ID_EX_mem_read || EX_MEM_mem_read || ID_EX_reg_write) && forward_opcode == 6'b000100;
    assign stall = ((ID_EX_mem_read && (ID_EX_rt == IF_ID_rs || ID_EX_rt == IF_ID_rt)) || branch)?1'b1:1'b0;
    //update PC when pc_write == 1
    assign pc_write = !stall;
    assign IF_ID_write = !stall;
endmodule

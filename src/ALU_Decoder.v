//============================================================= 
// ALUOp meanings:
//   00 → Always ADD (used for load/store address calculation)
//   01 → SUB (used for branch comparisons)
//   10 → R-type or I-type ALU operations (use funct3/funct7)
//
// ALUControl encodings (example convention):
//   000 → ADD
//   001 → SUB
//   010 → AND
//   011 → OR
//   101 → SLT (set less than)
//==============================================================

module ALU_Decoder(ALUOp, funct3, funct7, op, ALUControl);

    input [1:0] ALUOp;       
    input [2:0] funct3;      // Bits [14:12] of instruction 
    input [6:0] funct7, op;  // funct7 distinguishes ADD/SUB; op[5] distinguishes R vs I type
    output [2:0] ALUControl; // Final ALU control signal to select exact operation

    assign ALUControl = 
        // Load/Store: Always perform ADD
        (ALUOp == 2'b00) ? 3'b000 :

        // Branch/Perform SUB
        (ALUOp == 2'b01) ? 3'b001 :

        // R-type SUB:  funct3=000, funct7[5]=1, op[5]=1
        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5], funct7[5]} == 2'b11)) ? 3'b001 :

        // R-type ADD or I-type ADDI: funct3=000 but not subtraction
        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5], funct7[5]} != 2'b11)) ? 3'b000 :

        // SLT (Set Less Than)
        ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 :

        // OR / ORI
        ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 :

        // AND / ANDI
        ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 :

        // Default: ADD 
        3'b000;

endmodule

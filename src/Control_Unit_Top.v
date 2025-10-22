`include "ALU_Decoder.v"
`include "Main_Decoder.v"

module Control_Unit_Top(Op, funct3, funct7, RegWrite, ResultSrc, MemWrite, Branch, ALUControl, ALUSrc, ImmSrc);

    input[6:0] Op, funct7; 
    input[2:0] funct3; 

    output RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;
    output[1:0] ImmSrc; 
    output [2:0] ALUControl; 

    wire[1:0] ALUOp; 

    Main_Decoder Main_decoder(.Op(Op), .RegWrite(RegWrite), .ImmSrc(ImmSrc), .ALUSrc(ALUSrc), .MemWrite(MemWrite), .ResultSrc(ResultSrc), .Branch(Branch), .ALUOp(ALUOp));

    ALU_Decoder ALU_Decoder(.ALUOp(ALUOp), .funct3(funct3), .funct7(funct7), .op(Op), .ALUControl(ALUControl));

endmodule
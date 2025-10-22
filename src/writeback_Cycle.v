

module writeback_cycle(clk, reset, ResultSrcW, ALU_ResultW, ReadDataW, PCPlus4W, ResultW);

    input clk, reset, ResultSrcW;
    input[31:0] ALU_ResultW, ReadDataW, PCPlus4W;

    output[31:0] ResultW;

    // Mux is used to decide whether to write back ALU result (R-type/I-type instruction) or 
    // readDataW for (S-Type)
    mux Result_Mux(.a(ALU_ResultW),.b(ReadDataW),.s(ResultSrcW),.c(ResultW));




endmodule
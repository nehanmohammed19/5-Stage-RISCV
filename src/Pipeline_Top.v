`include "Program_counter.v"
`include "Adder.v"
`include "MUX.v"
`include "imemory.v"
`include "Control_Unit_Top.v"
`include "register_file.v"
`include "Immediate_Gen.v"
`include "ALU.v"
`include "Data_Memory.v"
`include "fetch_cycle.v"
`include "decode_cycle.v"
`include "execute_cycle.v"
`include "Memory_Cycle.v"
`include "writeback_Cycle.v"
`include "Hazard_unit.v"

module Pipeline_Top(clk, reset);

    //I/O
    input clk, reset;

    //Wires
    wire PCSrcE, RegWriteW, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, RegWriteM, MemWriteM, ResultSrcM, ResultSrcW;
    wire [2:0] ALUControlE;
    wire [4:0] RD_E, RD_M, RDW;
    wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D, ResultW, RD1_E, RD2_E, Imm_ExtE, PCE, PCPlus4E, PCPlus4M, WriteDataM, ALU_ResultM;
    wire [31:0] PCPlus4W, ALU_ResultW, ReadDataW;
    wire [4:0] Rs1_E, Rs2_E; 
    wire [1:0] ForwardAE, ForwardBE;



    // Module Instantiation 

    // Fetch Cycle
    fetch_cycle Fetch (
        .clk(clk),
        .reset(reset),
        .PCsrcE(PCsrcE),
        .PCTargetE(PCTargetE),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
    );

    // Decode Cycle
    decode_cycle Decode (
        .clk(clk),
        .reset(reset),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .RDW(RDW),
        .ResultW(ResultW),
        .RegWriteW(RegWriteW),
        .RegWriteE(RegWriteE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .Imm_ExtE(Imm_ExtE),
        .RD_E(RD_E),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        .Rs1_E(Rs1_E),
        .Rs2_E(Rs2_E)
    );

    // Execute Cycle
    execute_cycle Execute (
        .clk(clk),
        .reset(reset),
        .RegWriteE(RegWriteE),
        .ResultSrcE(ResultSrcE),
        .MemWriteE(MemWriteE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .ALUSrcE(ALUSrcE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .PCE(PCE),
        .RD_E(RD_E),
        .Imm_ExtE(Imm_ExtE),
        .PCPlus4E(PCPlus4E),
        .PCsrcE(PCsrcE),
        .PCTargetE(PCTargetE),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .WriteDataM(WriteDataM),
        .PCPlus4M(PCPlus4M),
        .RD_M(RD_M),
        .ALU_ResultM(ALU_ResultM),
        .ResultW(ResultW),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE)
    );

    // Memory Cycle
    Memory_Cycle Memory (
        .clk(clk),
        .reset(reset),
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        .MemWriteM(MemWriteM),
        .ALU_ResultM(ALU_ResultM),
        .WriteDataM(WriteDataM),
        .RD_M(RD_M),
        .PCPlus4M(PCPlus4M),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .ALU_ResultW(ALU_ResultW),
        .ReadDataW(ReadDataW),
        .RD_W(RDW),
        .PCPlus4W(PCPlus4W)
    );

    // Writeback Cycle
    writeback_cycle WriteBack (
        .clk(clk),
        .reset(reset),
        .ResultSrcW(ResultSrcW),
        .ALU_ResultW(ALU_ResultW),
        .ReadDataW(ReadDataW),
        .PCPlus4W(PCPlus4W),
        .ResultW(ResultW)
    );
    //Hazard Unit
    Hazard_Unit forwarding_block(
        .reset(reset),
        .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteM),
        .RD_M(RD_M),
        .RDW(RDW),
        .Rs1_E(Rs1_E),
        .Rs2_E(Rs2_E),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE));


endmodule
module execute_cycle(clk, reset, RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUControlE, ALUSrcE, 
                    RD1_E, RD2_E, PCE, RD_E, Imm_ExtE, PCPlus4E, 
                    PCsrcE, PCTargetE, RegWriteM, MemWriteM, ResultSrcM, WriteDataM, PCPlus4M, RD_M, ALU_ResultM, 
                    ResultW, ForwardAE, ForwardBE);
    //Input
    input clk, reset, RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUSrcE;
    input [2:0] ALUControlE;
    input[31:0] RD1_E, RD2_E, Imm_ExtE;
    input[4:0] RD_E; 
    input[31:0] PCE, PCPlus4E; 
    input [31:0] ResultW; 
    input [1:0] ForwardAE, ForwardBE; 

    //output
    output[31:0] PCTargetE; 
    output PCsrcE, RegWriteM, MemWriteM, ResultSrcM;
    output [4:0] RD_M; 
    output [31:0] PCPlus4M, ALU_ResultM, WriteDataM;

    // Wires
    wire[31:0] SrcBE, src_A, src_B_interim; 
    wire[31:0] ResultE;
    wire ZeroE; 

    // Registers
    reg RegWriteE_r, ResultSrcE_r, MemWriteE_r;
    reg [4:0] RD_E_r;
    reg [31:0] PCPlus4E_r, RD2_E_r, ResultE_r; 

    //Module Declaration
    mux_3_by_1 SrcAMux(.a(RD1_E),.b(ResultW),.c(ALU_ResultM),.s(ForwardAE),.d(src_A));
    mux_3_by_1 SrcBMux(.a(RD2_E),.b(ResultW),.c(ALU_ResultM),.s(ForwardBE),.d(src_B_interim));
    Adder branch_Adder(.a(PCE), .b(Imm_ExtE), .c(PCTargetE));  
    ALU ALU(.A(src_A), .B(SrcBE), .Result(ResultE), .ALUControl(ALUControlE), .Overflow(), .Carry(), .Zero(ZeroE), .Negative());
    mux alu_src_mux(.a(src_B_interim),.b(Imm_ExtE),.s(ALUSrcE),.c(SrcBE));


    //Register Logic
    always @(posedge clk or negedge reset) begin
        if (reset == 1'b0) begin
            RegWriteE_r <= 1'b0;
            MemWriteE_r <= 1'b0;
            ResultSrcE_r <= 1'b0; 
            RD2_E_r <= 5'h00; 
            PCPlus4E_r <= 32'h00000000;
            RD2_E_r <= 32'h00000000;
            ResultE_r <= 32'h00000000;
        end
        else begin
            RegWriteE_r <= RegWriteE;
            MemWriteE_r <= MemWriteE;
            ResultSrcE_r <= ResultSrcE; 
            RD2_E_r <= src_B_interim; 
            PCPlus4E_r <= PCPlus4E;
            RD_E_r <= RD_E;
            ResultE_r <= ResultE;
        end
    end 


    assign PCsrcE = ZeroE & BranchE;
    assign RegWriteM = RegWriteE_r; 
    assign MemWriteM = MemWriteE_r; 
    assign ResultSrcM = ResultSrcE_r;
    assign WriteDataM = RD2_E_r; 
    assign PCPlus4M = PCPlus4E_r; 
    assign RD_M = RD_E_r; 
    assign ALU_ResultM = ResultE_r; 


endmodule
module decode_cycle(clk, reset, InstrD, PCD, PCPlus4D, RDW, ResultW, RegWriteW,
                    RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, ALUControlE, RD1_E, RD2_E, Imm_ExtE, RD_E, PCE, PCPlus4E,
                    Rs1_E, Rs2_E);

    // IO ports
    input clk, reset, RegWriteW; 
    input [31:0] InstrD, PCD, PCPlus4D, ResultW;
    input [4:0] RDW; 

    output RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUSrcE;
    output [2:0] ALUControlE;
    output[31:0] RD1_E, RD2_E, Imm_ExtE;
    output[4:0] RD_E, Rs1_E, Rs2_E; 
    output[31:0] PCE, PCPlus4E; 

    // wires
    wire RegWriteD, ResultSrcD, MemWriteD, BranchD, ALUSrcD;
    wire [2:0] ALUControlD;
    wire [1:0] ImmSrcD; 

    wire[31:0] RD1_D, RD2_D, Imm_ExtD;

    //intermediate registers
    reg RegWriteD_r, ResultSrcD_r, MemWriteD_r, BranchD_r, ALUSrcD_r;
    reg [2:0] ALUControlD_r;
    reg[31:0] RD1_D_r, RD2_D_r, Imm_ExtD_r;
    reg[4:0] RD_D_r, Rs1_D_r, Rs2_D_r; 
    reg[31:0] PCD_r, PCPlus4D_r; 





    Control_Unit_Top Control_Unit_Top(
        .Op(InstrD[6:0]), 
        .funct3(InstrD[14:12]), 
        .funct7(InstrD[31:25]), 
        .RegWrite(RegWriteD), 
        .ResultSrc(ResultSrcD), 
        .MemWrite(MemWriteD), 
        .Branch(BranchD), 
        .ALUControl(ALUControlD), 
        .ALUSrc(ALUSrcD),
        .ImmSrc(ImmSrcD)
        );

    Register_File Register(
        .clk(clk),
        .rst(reset),
        .WE3(RegWriteW),
        .WD3(ResultW),
        .A1(InstrD[19:15]),
        .A2(InstrD[24:20]),
        .A3(RDW),
        .RD1(RD1_D),
        .RD2(RD2_D)
        );
    

    Immediate_Gen Immediate_Generator(
        .In(InstrD[31:0]), 
        .ImmSrc(ImmSrcD), 
        .Imm_Ext(Imm_ExtD)
        );


    // Register Logic
    always @(posedge clk or negedge reset) begin
        // set all registers to 0
        if(reset == 1'b0) begin
            RegWriteD_r <= 1'b0; 
            ALUSrcD_r <= 1'b0; 
            MemWriteD_r <= 1'b0; 
            ResultSrcD_r <= 1'b0; 
            BranchD_r <= 1'b0; 
            ALUControlD_r <= 3'b000;
            RD1_D_r <= 32'h00000000;
            RD2_D_r <= 32'h00000000;
            Imm_ExtD_r <= 32'h00000000;
            RD_D_r <= 5'h00;
            PCD_r <= 32'h00000000;
            PCPlus4D_r <= 32'h00000000;
            Rs1_D_r <= 5'h00;
            Rs2_D_r <= 5'h00;
        end
        else begin
            // on each clock pulse set values of registers
            RegWriteD_r <= RegWriteD; 
            ALUSrcD_r <= ALUSrcD; 
            MemWriteD_r <= MemWriteD; 
            ResultSrcD_r <= ResultSrcD; 
            BranchD_r <= BranchD; 
            ALUControlD_r <= ALUControlD;
            RD1_D_r <= RD1_D;
            RD2_D_r <= RD2_D;
            Imm_ExtD_r <= Imm_ExtD;
            RD_D_r <= InstrD[11:7];
            PCD_r <= PCD;
            PCPlus4D_r <= PCPlus4D;
            Rs1_D_r <= InstrD[19:15];
            Rs2_D_r <= InstrD[24:20];
        end
    end

    // output assign statements
    assign RegWriteE = RegWriteD_r; 
    assign ALUSrcE = ALUSrcD_r; 
    assign MemWriteE = MemWriteD_r; 
    assign ResultSrcE = ResultSrcD_r; 
    assign BranchE= BranchD_r; 
    assign ALUControlE = ALUControlD_r;
    assign RD1_E= RD1_D_r;
    assign RD2_E = RD2_D_r;
    assign Imm_ExtE = Imm_ExtD_r;
    assign RD_E= RD_D_r;
    assign PCE= PCD_r;
    assign PCPlus4E= PCPlus4D_r;
    assign Rs1_E = Rs1_D_r; 
    assign Rs2_E = Rs2_D_r; 

    


endmodule
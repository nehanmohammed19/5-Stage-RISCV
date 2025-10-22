module Memory_Cycle(clk, reset, RegWriteM, ResultSrcM, MemWriteM, ALU_ResultM, WriteDataM, RD_M, PCPlus4M,
                    RegWriteW, ResultSrcW, ALU_ResultW, ReadDataW, RD_W, PCPlus4W);

    //Input
    input  clk, reset, PCsrcE, RegWriteM, MemWriteM, ResultSrcM;
    input [4:0] RD_M; 
    input [31:0] PCPlus4M, ALU_ResultM, WriteDataM;

    //outputs
    output RegWriteW, ResultSrcW;
    output [4:0] RD_W;
    output [31:0] ALU_ResultW, PCPlus4W, ReadDataW;


    //wire
    wire[31:0] ReadDataM; 

    //registers
    reg RegWriteM_r, ResultSrcM_r;
    reg [4:0] RD_M_R; 
    reg [31:0] PCPlus4M_r, ReadDataM_r, ALU_ResultM_r;



    //Modules
    Data_Memory data_memory(.clk(clk), .reset(reset), .A(ALU_ResultM), .WD(WriteDataM), .WE(MemWriteM), .RD(ReadDataM));


    //Register Logic
    always @(posedge clk or negedge reset)begin
        if (reset == 1'b0) begin
            RegWriteM_r <= 1'b0;
            ResultSrcM_r <= 1'b0;
            RD_M_R <= 5'h00; 
            PCPlus4M_r <= 32'h00000000; 
            ReadDataM_r <= 32'h00000000; 
            ALU_ResultM_r <= 32'h00000000;
        end
        else begin
            RegWriteM_r <= RegWriteM;
            ResultSrcM_r <= ResultSrcM;
            RD_M_R <= RD_M; 
            PCPlus4M_r <= PCPlus4M; 
            ReadDataM_r <= ReadDataM; 
            ALU_ResultM_r <= ALU_ResultM;
        end
    end


    assign RegWriteW = RegWriteM_r;
    assign ResultSrcW = ResultSrcM_r; 
    assign RD_W = RD_M_R;
    assign PCPlus4W = PCPlus4M_r; 
    assign ReadDataW = ReadDataM_r;
    assign ALU_ResultW = ALU_ResultM_r;

endmodule
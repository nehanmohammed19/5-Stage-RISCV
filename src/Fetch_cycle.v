module fetch_cycle(clk, reset, PCsrcE, PCTargetE, InstrD, PCD, PCPlus4D);

    //inputs and outputs
    input clk, reset;
    input PCsrcE;
    input [31:0]PCTargetE; 
    output [31:0]InstrD, PCD, PCPlus4D;
    //wire 
    wire [31:0] PC_F, PCF, PCPLUS4F;
    wire[31:0] InstrF; 

    reg[31:0] InstrF_reg;
    reg[31:0] PCF_reg, PCPLUS4F_reg;


    //mux
    mux PC_Mux (.a(PCPLUS4F),.b(PCTargetE),.s(PCsrcE),.c(PC_F));
    // program counter
    Program_counter PC(.clk(clk), .reset(reset), .counter(PCF), .counter_next(PC_F));

    // IMemory
    imemory imem(.reset(reset), .A(PCF), .RD(InstrF));

    // Program counter adder 
    Adder PC_adder(.a(PCF), .b(32'h00000004), .c(PCPLUS4F));


    always @(posedge clk or negedge reset) begin
        if (reset == 1'b0) begin
            InstrF_reg <= 32'h00000000;
            PCF_reg <= 32'h00000000;
            PCPLUS4F_reg <= 32'h00000000;
        end
        else begin
            InstrF_reg <= InstrF; 
            PCF_reg <= PCF;
            PCPLUS4F_reg <= PCPLUS4F;
        end

    end

    assign InstrD = (reset == 1'b0) ? 32'h00000000 : InstrF_reg;
    assign PCD = (reset == 1'b0) ? 32'h00000000 : PCF_reg; 
    assign PCPlus4D = (reset == 1'b0) ? 32'h00000000 : PCPLUS4F_reg;





endmodule

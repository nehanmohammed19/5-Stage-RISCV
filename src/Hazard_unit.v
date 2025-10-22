module Hazard_Unit(reset, RegWriteM, RegWriteW, RD_M, RDW, Rs1_E,Rs2_E, ForwardAE, ForwardBE);

    input reset, RegWriteM, RegWriteW;
    input [4:0]  RD_M, RDW, Rs1_E, Rs2_E;
    output [1:0] ForwardAE, ForwardBE; 

    assign ForwardAE = (reset == 1'b0) ? 2'b00 :
                       ((RegWriteM == 1'b1) & (RD_M != 5'h00) & (RD_M == Rs1_E)) ? 2'b10 : 
                       ((RegWriteM == 1'b1) & (RDW != 5'h00) & (RDW == Rs1_E)) ? 2'b01 : 2'b00;
    
    assign ForwardBE =  (reset == 1'b0) ? 2'b00 :
                        ((RegWriteM == 1'b1) & (RD_M != 5'h00) & (RD_M == Rs2_E)) ? 2'b10 : 
                        ((RegWriteM == 1'b1) & (RDW != 5'h00) & (RDW == Rs2_E)) ? 2'b01 : 2'b00;

endmodule
module Immediate_Gen(In, ImmSrc, Imm_Ext);

    input[31:0] In; 
    input[1:0] ImmSrc; 
    // Control signal from Main decoder telling which immediate format to build
    // 2'b00 -> I-Type
    // 2'b01 -> S-Type (stores)
    // 2'b10 -> B-type (Maybe implemented Later)

    output [31:0] Imm_Ext; 

    assign Imm_Ext = (ImmSrc == 2'b00) ? {{20{In[31]}}, In[31:20]} :
                     (ImmSrc == 2'b01) ? {{20{In[31]}}, In[31:25], In[11:7]} : 32'h00000000;
                     

endmodule

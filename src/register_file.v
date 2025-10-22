module Register_File(clk,rst,WE3,WD3,A1,A2,A3,RD1,RD2);

    input clk, rst, WE3; 
    input [4:0] A1, A2, A3; 
    input [31:0] WD3; 
    output [31:0] RD1, RD2; 

    reg [31:0] Register [31:0]; // 32X32 register array


    // on +ve clock edge
    always @ (posedge clk)

    // if Write enable is 1, and Destination address (A3) is not 0 
    // Write WD3 to register[A3]
    begin
        if (WE3 & (A3 != 5'h00))
            Register[A3] <= WD3; 
    end


    // if reset is 0 output = 0
    // else RD1 is the value of register rs1
    // RD2 is the value of register rs2 for the ALU in Execute stage
    assign RD1 = (rst == 1'b0) ? 32'd0 : Register[A1];
    assign RD2 = (rst == 1'b0) ? 32'd0 : Register[A2]; 

    initial begin
        Register[0] = 32'h00000000;
    end


endmodule
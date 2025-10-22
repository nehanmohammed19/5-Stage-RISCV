module Data_Memory(clk, reset, A, WD, WE, RD);

    input clk, reset, WE;
    input [31:0] A, WD; // A is effective address from ALU, WD is 32-bit write data (stores)
    output [31:0] RD; // 32-bit read Data (loads)


    reg [31:0] mem [1023:0]; // 4KB 1024 words 


    always @ (posedge clk) // on each clock edge if WE == 1 do a write
    begin
        if(WE)
            mem[A[31:2]] <= WD;
    end
    // when rst == 0 force RD = 0 otherwise output the addressed word
    assign RD = (~reset) ? 32'd0 : mem[A[31:2]];

    initial begin
        mem[0] = 32'h00000000; 
    end



endmodule
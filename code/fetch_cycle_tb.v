module tb();

    reg clk, reset, PCsrcE; 
    reg [31:0] PCTargetE;
    wire [31:0] InstrD, PCD, PCPlus4D;

    //declare the DUT (design under test)
    fetch_cycle DUT(.clk(clk), .reset(reset), .PCsrcE(PCsrcE), .PCTargetE(PCTargetE), .InstrD(InstrD), .PCD(PCD), .PCPlus4D(PCPlus4D));

    initial clk = 0;
    always #50 clk = ~clk; 

    initial begin
        reset <= 1'b0; 
        #200; 
        reset <= 1'b1; 
        PCsrcE <= 1'b0; 
        PCTargetE <= 32'h00000000;
        #500;
        $finish;
    end

    initial begin 
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end

endmodule
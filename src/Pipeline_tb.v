module Pipeline_tb();

    reg clk = 0, reset;

    always begin
        clk = ~clk; 
        #50;
    end

    initial begin
        reset <= 1'b0;
        #200;
        reset <= 1'b1;
        #1000;
        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end

    Pipeline_Top dut(.clk(clk), .reset(reset));


endmodule
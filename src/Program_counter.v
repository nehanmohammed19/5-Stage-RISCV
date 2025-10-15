module Program_counter(clk, reset, counter, counter_next);

    input clk, reset;
    input[31:0] counter_next; 
    output [31:0] counter; 
    reg [31:0] counter;


    always @(posedge clk) begin
        if (reset == 1'b0)begin
            counter <= {32{1'b0}};
        end
        else begin 
            counter <= counter_next;
        end  
    end

endmodule
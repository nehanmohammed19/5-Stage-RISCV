module ALU(A, B, Result, ALUControl, Overflow, Carry, Zero, Negative);

    input [31:0] A, B; // A is Rs1, B is Rs2 OR Immediate depending on ALUSrc
    input [2:0] ALUControl; // 000 ADD, 001 SUB, 010 AND, 011 OR, 101 SLT
    output Carry, Overflow, Zero, Negative; 
    // Carry is set when unsigned addition produces carry out from MSB
    // Overflow is set when signed operation is too large for 32 bits
    // Zero is high when result is 0 (For Branch decisions)
    // Negative is hgih when the MSB is 1 (means a negative number in the 2s compliment)
    output [31:0] Result; 
    // value that will be written to register destination

    wire Cout; // carry out bit from addition/subtraction
    wire[31:0] Sum; // temp result for addition /subtraction

    assign Sum = (ALUControl[0] == 1'b0) ? A + B : (A + (~B) + 1); // if LSB is 0 then ADD, else subtract in 2's compliment
    
    assign {Cout, Result} = (ALUControl == 3'b000) ? Sum : // ADD Sum already 
                            (ALUControl == 3'b001) ? Sum : 
                            (ALUControl == 3'b010) ? A & B : 
                            (ALUControl == 3'b011) ? A | B :
                            (ALUControl == 3'b101) ? {{32{1'b0}}, (Sum[31])} : {33{1'b0}}; // 000..01 for A < B and 000..00 for A >=B
    // overFlow is true (1) only if 3 conditions are True (1)
    assign Overflow = ((Sum[31] ^ A[31]) & // is the sign of result differnt than A? sum XOR A (if different will be 1)
                      ( ~(ALUControl[0] ^ B[31] ^A[31])) & 
                      // if add (ALUcontrol[0] = 0), are B and A same sign? ~(0 ^ 1 ^ 1) = 1 or ~(0 ^ 0 ^ 0) = 1
                      // if sub (ALUControl[0] = 1) are B and A different signs? ~(1 ^ 1 ^ 0) =  1 or ~(1 ^ 0 ^ 1) = 1
                      (~ALUControl[1])); // are we in ADD/SUB mode? ALUControl[1] == 0
    assign Carry = ((~ALUControl[1]) & Cout); // first check if we are in ADD/SUB mode (ALUContol[1] ==0) and if Cout is 1 then carry is 1

    assign Zero = &(~Result); // checks if all bits are 0. if the inverted version of all bits (~Result) is all 1s &(~Result), then zero = 1

    assign Negative = Result[31]; 


endmodule
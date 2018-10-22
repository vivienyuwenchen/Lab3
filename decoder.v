//------------------------------------------------------------------------
// Behavioral Instruction Decoder
//------------------------------------------------------------------------

module instructionDecoder
(
input 	    x,
output reg  y
);

    always @(OP) begin
        case(OP)
            opADDI: begin
                RegDst = 0;
                RegWr = ;
                ALUcntrl = x;
                MemWr = x;
                MemToReg = 1;
                ALUsrc = 0;
            end
        endcase
    end

endmodule

//------------------------------------------------------------------------
// Behavioral Instruction Look Up Table
//------------------------------------------------------------------------

module instructionLUT
(
    input 	    OP,
    input       zero,
    input       overflow,
    output reg  RegDst,
    output reg  RegWr,
    output reg  MemWr,
    output reg  MemToReg,
    output reg  ALUctrl,
    output reg  ALUsrc,
    output reg  IsJump,
    output reg  IsJAL,
    output reg  IsJR,
    output reg  IsBranch
);

    always @(OP) begin
        case(OP)
            opLW: begin
                RegDst = 0;
                RegWr = 1;
                MemWr = 0;
                MemToReg = 1;
                ALUcntrl = 000;
                ALUsrc = 1;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                IsBranch = 0;
            end
            opSW: begin
                RegDst = 0;
                RegWr = 0;
                MemWr = 1;
                MemToReg = 0;
                ALUcntrl = 000;
                ALUsrc = 1;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                IsBranch = 0;
            end
            opJ: begin
                RegDst = 0;
                RegWr = 0;
                MemWr = 0;
                MemToReg = 0;
                ALUcntrl = 000;
                ALUsrc = 0;
                IsJump = 1;
                IsJAL = 0;
                IsJR = 0;
            end
            opJR: begin
                RegDst = 0;
                RegWr = 0;
                MemWr = 0;
                MemToReg = 0;
                ALUcntrl = 000;
                ALUsrc = 0;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 1;
                IsBranch = 0;
            end
            opJAL: begin
                RegDst = 0;
                RegWr = 1;
                MemWr = 0;
                MemToReg = 0;
                ALUcntrl = 000;
                ALUsrc = 0;
                IsJump = 1;
                IsJAL = 0;
                IsJR = 1;
                IsBranch = 0;
            end
            opBEQ: begin
                RegDst = 0;
                RegWr = 0;
                MemWr = 0;
                MemToReg = 0;
                ALUcntrl = 001;
                ALUsrc = 0;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                if ((zero == 1) && (overflow == 0))
                    IsBranch = 1;
                else
                    IsBranch = 0;
            end
            opBNE: begin
                RegDst = 0;
                RegWr = 0;
                MemWr = 0;
                MemToReg = 0;
                ALUcntrl = 001;
                ALUsrc = 0;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                if ((zero == 0) && (overflow == 0))
                    IsBranch = 1;
                else
                    IsBranch = 0;
            end
            opXORI: begin
                RegDst = 0;
                RegWr = 1;
                MemWr = 0;
                MemToReg = 0;
                ALUcntrl = 010;
                ALUsrc = 1;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                IsBranch = 0;
            end
            opADDI: begin
                RegDst = 0;
                RegWr = 1;
                MemWr = 0;
                MemToReg = 0;
                ALUcntrl = 000;
                ALUsrc = 1;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                IsBranch = 0;
            end
            opADD: begin
                RegDst = 1;
                RegWr = 1;
                MemWr = 0;
                MemToReg = 0;
                ALUcntrl = 000;
                ALUsrc = 0;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                IsBranch = 0;
            end
            opSUB: begin
                RegDst = 1;
                RegWr = 1;
                MemWr = 0;
                MemToReg = 0;
                ALUcntrl = 001;
                ALUsrc = 0;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                IsBranch = 0;
            end
            opSLT: begin
                RegDst = 1;
                RegWr = 1;
                MemWr = 0;
                MemToReg = 0;
                ALUcntrl = 011;
                ALUsrc = 0;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                IsBranch = 0;
            end
        endcase
    end
endmodule

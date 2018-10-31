//------------------------------------------------------------------------
// Behavioral Instruction Look Up Table
//------------------------------------------------------------------------

`define opLW    6'b100011
`define opSW    6'b101011
`define opJ     6'b000010
`define opJR    6'b001000 //FUNCT, OP = 6'b000000
`define opJAL   6'b000011
`define opBEQ   6'b000100
`define opBNE   6'b000101
`define opXORI  6'b001110
`define opADDI  6'b001000
`define opADD   6'b100000 //FUNCT, OP = 6'b000000
`define opSUB   6'b100010 //FUNCT, OP = 6'b000000
`define opSLT   6'b101010 //FUNCT, OP = 6'b000000
`define Rtype   6'b000000

module instructionLUT
(
    input [5:0] OP,
    input [5:0] FUNCT,
    input       zero,
    input       overflow,
    output reg  RegDst,
    output reg  RegWr,
    output reg  MemWr,
    output reg  MemToReg,
    output reg [2:0] ALUctrl,
    output reg  ALUsrc,
    output reg  IsJump,
    output reg  IsJAL,
    output reg  IsJR,
    output reg  IsBranch
);

    always @(OP or FUNCT or zero or overflow) begin
        case(OP)
            `opLW: begin
                RegDst = 0;
                RegWr = 1;
                MemWr = 0;
                MemToReg = 1;
                ALUctrl = 3'b000;
                ALUsrc = 1;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                IsBranch = 0;
            end
            `opSW: begin
                RegDst = 0;
                RegWr = 0;
                MemWr = 1;
                MemToReg = 0;
                ALUctrl = 3'b000;
                ALUsrc = 1;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                IsBranch = 0;
            end
            `opJ: begin
                RegDst = 0;
                RegWr = 0;
                MemWr = 0;
                MemToReg = 0;
                ALUctrl = 3'b000;
                ALUsrc = 0;
                IsJump = 1;
                IsJAL = 0;
                IsJR = 0;
                IsBranch = 0;
            end
            `opJAL: begin
                RegDst = 0;
                RegWr = 1;
                MemWr = 0;
                MemToReg = 0;
                ALUctrl = 3'b000;
                ALUsrc = 0;
                IsJump = 1;
                IsJAL = 1;
                IsJR = 0;
                IsBranch = 0;
            end
            `opBEQ: begin
                RegDst = 0;
                RegWr = 0;
                MemWr = 0;
                MemToReg = 0;
                ALUctrl = 3'b001;
                ALUsrc = 0;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                if ((zero == 1) && (overflow == 0))
                    IsBranch = 1;
                else
                    IsBranch = 0;
            end
            `opBNE: begin
                RegDst = 0;
                RegWr = 0;
                MemWr = 0;
                MemToReg = 0;
                ALUctrl = 3'b001;
                ALUsrc = 0;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                if ((zero == 1) && (overflow == 0))
                    IsBranch = 0;
                else
                    IsBranch = 1;
            end
            `opXORI: begin
                RegDst = 0;
                RegWr = 1;
                MemWr = 0;
                MemToReg = 0;
                ALUctrl = 3'b010;
                ALUsrc = 1;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                IsBranch = 0;
            end
            `opADDI: begin
                RegDst = 0;
                RegWr = 1;
                MemWr = 0;
                MemToReg = 0;
                ALUctrl = 3'b000;
                ALUsrc = 1;
                IsJump = 0;
                IsJAL = 0;
                IsJR = 0;
                IsBranch = 0;
            end
            `Rtype: begin
                case(FUNCT)
                    `opJR: begin
                        RegDst = 0;
                        RegWr = 0;
                        MemWr = 0;
                        MemToReg = 0;
                        ALUctrl = 3'b000;
                        ALUsrc = 0;
                        IsJump = 0;
                        IsJAL = 0;
                        IsJR = 1;
                        IsBranch = 0;
                    end
                    `opADD: begin
                        RegDst = 1;
                        RegWr = 1;
                        MemWr = 0;
                        MemToReg = 0;
                        ALUctrl = 3'b000;
                        ALUsrc = 0;
                        IsJump = 0;
                        IsJAL = 0;
                        IsJR = 0;
                        IsBranch = 0;
                    end
                    `opSUB: begin
                        RegDst = 1;
                        RegWr = 1;
                        MemWr = 0;
                        MemToReg = 0;
                        ALUctrl = 3'b001;
                        ALUsrc = 0;
                        IsJump = 0;
                        IsJAL = 0;
                        IsJR = 0;
                        IsBranch = 0;
                    end
                    `opSLT: begin
                        RegDst = 1;
                        RegWr = 1;
                        MemWr = 0;
                        MemToReg = 0;
                        ALUctrl = 3'b011;
                        ALUsrc = 0;
                        IsJump = 0;
                        IsJAL = 0;
                        IsJR = 0;
                        IsBranch = 0;
                    end // opSLT
                    default: begin
                        $display("ERROR: Invalid operation or function code.");
                    end
                endcase // case(FUNCT)
            end // Rtype
            default: begin
                $display("ERROR: Invalid operation or function code.");
            end
        endcase // case(OP)
    end // always
endmodule

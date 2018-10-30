//------------------------------------------------------------------------
// Test Bench for Behavioral Instruction Look Up Table
//------------------------------------------------------------------------
`timescale 1 ns / 1 ps
`include "lut.v"

module testlut();

    reg  [5:0]  OP, FUNCT;
    reg         zero, overflow;
    wire        RegDst, RegWr, MemWr, MemToReg, ALUsrc, IsJump, IsJAL, IsJR, IsBranch;
    wire [3:0]  ALUctrl;

    instructionLUT lut(.OP(OP),
                    .FUNCT(FUNCT),
                    .zero(zero),
                    .overflow(overflow),
                    .RegDst(RegDst),
                    .RegWr(RegWr),
                    .MemWr(MemWr),
                    .MemToReg(MemToReg),
                    .ALUctrl(ALUctrl),
                    .ALUsrc(ALUsrc),
                    .IsJump(IsJump),
                    .IsJAL(IsJAL),
                    .IsJR(IsJR),
                    .IsBranch(IsBranch));

    initial begin
        $display("Starting instruction LUT test...");

        // Test 1: Load Word
        $display("Testing LW...");
        OP=6'b100011; FUNCT='bx; zero='bx; overflow='bx; #1000
        if(RegDst != 1'b0)
            $display("error with LW RegDst; Expected: 0, Got: %d", RegDst);
        if(RegWr != 1'b1)
            $display("error with LW RegWr; Expected: 1, Got: %d", RegWr);
        if(MemWr != 1'b0)
            $display("error with LW MemWr; Expected: 0, Got: %d", MemWr);
        if(MemToReg != 1'b1)
            $display("error with LW MemToReg; Expected: 1, Got: %d", MemToReg);
        if(ALUctrl != 3'b000)
            $display("error with LW ALUctrl; Expected: 000, Got: %d", ALUctrl);
        if(ALUsrc != 1'b1)
            $display("error with LW ALUsrc; Expected: 1, Got: %d", ALUsrc);
        if(IsJump != 1'b0)
            $display("error with LW IsJump; Expected: 0, Got: %d", IsJump);
        if(IsJAL != 1'b0)
            $display("error with LW IsJAL; Expected: 0, Got: %d", IsJAL);
        if(IsJR != 1'b0)
            $display("error with LW IsJR; Expected: 0, Got: %d", IsJR);
        if(IsBranch != 1'b0)
            $display("error with LW IsBranch; Expected: 0, Got: %d", IsBranch);

        // Test 2: Store Word
        $display("Testing SW...");
        OP=6'b101011; FUNCT='bx; zero='bx; overflow='bx; #1000
        if(RegDst != 1'b0)
            $display("error with SW RegDst; Expected: 0, Got: %d", RegDst);
        if(RegWr != 1'b0)
            $display("error with SW RegWr; Expected: 0, Got: %d", RegWr);
        if(MemWr != 1'b1)
            $display("error with SW MemWr; Expected: 1, Got: %d", MemWr);
        if(MemToReg != 1'b0)
            $display("error with SW MemToReg; Expected: 0, Got: %d", MemToReg);
        if(ALUctrl != 3'b000)
            $display("error with SW ALUctrl; Expected: 000, Got: %d", ALUctrl);
        if(ALUsrc != 1'b1)
            $display("error with SW ALUsrc; Expected: 1, Got: %d", ALUsrc);
        if(IsJump != 1'b0)
            $display("error with SW IsJump; Expected: 0, Got: %d", IsJump);
        if(IsJAL != 1'b0)
            $display("error with SW IsJAL; Expected: 0, Got: %d", IsJAL);
        if(IsJR != 1'b0)
            $display("error with SW IsJR; Expected: 0, Got: %d", IsJR);
        if(IsBranch != 1'b0)
            $display("error with SW IsBranch; Expected: 0, Got: %d", IsBranch);

        // Test 3: Jump
        $display("Testing J...");
        OP=6'b000010; FUNCT='bx; zero='bx; overflow='bx; #1000
        if(RegDst != 1'b0)
            $display("error with J RegDst; Expected: 0, Got: %d", RegDst);
        if(RegWr != 1'b0)
            $display("error with J RegWr; Expected: 0, Got: %d", RegWr);
        if(MemWr != 1'b0)
            $display("error with J MemWr; Expected: 0, Got: %d", MemWr);
        if(MemToReg != 1'b0)
            $display("error with J MemToReg; Expected: 0, Got: %d", MemToReg);
        if(ALUctrl != 3'b000)
            $display("error with J ALUctrl; Expected: 000, Got: %d", ALUctrl);
        if(ALUsrc != 1'b0)
            $display("error with J ALUsrc; Expected: 0, Got: %d", ALUsrc);
        if(IsJump != 1'b1)
            $display("error with J IsJump; Expected: 1, Got: %d", IsJump);
        if(IsJAL != 1'b0)
            $display("error with J IsJAL; Expected: 0, Got: %d", IsJAL);
        if(IsJR != 1'b0)
            $display("error with J IsJR; Expected: 0, Got: %d", IsJR);
        if(IsBranch != 1'b0)
            $display("error with J IsBranch; Expected: 0, Got: %d", IsBranch);

        // Test 4: Jump Register
        $display("Testing JR...");
        OP=6'b000000; FUNCT=6'b001000; zero='bx; overflow='bx; #1000
        if(RegDst != 1'b0)
            $display("error with JR RegDst; Expected: 0, Got: %d", RegDst);
        if(RegWr != 1'b0)
            $display("error with JR RegWr; Expected: 0, Got: %d", RegWr);
        if(MemWr != 1'b0)
            $display("error with JR MemWr; Expected: 0, Got: %d", MemWr);
        if(MemToReg != 1'b0)
            $display("error with JR MemToReg; Expected: 0, Got: %d", MemToReg);
        if(ALUctrl != 3'b000)
            $display("error with JR ALUctrl; Expected: 000, Got: %d", ALUctrl);
        if(ALUsrc != 1'b0)
            $display("error with JR ALUsrc; Expected: 0, Got: %d", ALUsrc);
        if(IsJump != 1'b0)
            $display("error with JR IsJump; Expected: 0, Got: %d", IsJump);
        if(IsJAL != 1'b0)
            $display("error with JR IsJAL; Expected: 0, Got: %d", IsJAL);
        if(IsJR != 1'b1)
            $display("error with JR IsJR; Expected: 1, Got: %d", IsJR);
        if(IsBranch != 1'b0)
            $display("error with JR IsBranch; Expected: 0, Got: %d", IsBranch);

        // Test 5: Jump and Link
        $display("Testing JAL...");
        OP=6'b000011; FUNCT='bx; zero='bx; overflow='bx; #1000
        if(RegDst != 1'b0)
            $display("error with JAL RegDst; Expected: 0, Got: %d", RegDst);
        if(RegWr != 1'b1)
            $display("error with JAL RegWr; Expected: 1, Got: %d", RegWr);
        if(MemWr != 1'b0)
            $display("error with JAL MemWr; Expected: 0, Got: %d", MemWr);
        if(MemToReg != 1'b0)
            $display("error with JAL MemToReg; Expected: 0, Got: %d", MemToReg);
        if(ALUctrl != 3'b000)
            $display("error with JAL ALUctrl; Expected: 000, Got: %d", ALUctrl);
        if(ALUsrc != 1'b0)
            $display("error with JAL ALUsrc; Expected: 0, Got: %d", ALUsrc);
        if(IsJump != 1'b1)
            $display("error with JAL IsJump; Expected: 1, Got: %d", IsJump);
        if(IsJAL != 1'b1)
            $display("error with JAL IsJAL; Expected: 1, Got: %d", IsJAL);
        if(IsJR != 1'b0)
            $display("error with JAL IsJR; Expected: 0, Got: %d", IsJR);
        if(IsBranch != 1'b0)
            $display("error with JAL IsBranch; Expected: 0, Got: %d", IsBranch);

        // Test 6: Branch on Equal
        $display("Testing BEQ...");
        OP=6'b000100; FUNCT='bx; zero=1'b1; overflow=1'b0; #1000
        if(RegDst != 1'b0)
            $display("error with BEQ RegDst; Expected: 0, Got: %d", RegDst);
        if(RegWr != 1'b0)
            $display("error with BEQ RegWr; Expected: 0, Got: %d", RegWr);
        if(MemWr != 1'b0)
            $display("error with BEQ MemWr; Expected: 0, Got: %d", MemWr);
        if(MemToReg != 1'b0)
            $display("error with BEQ MemToReg; Expected: 0, Got: %d", MemToReg);
        if(ALUctrl != 3'b001)
            $display("error with BEQ ALUctrl; Expected: 001, Got: %d", ALUctrl);
        if(ALUsrc != 1'b0)
            $display("error with BEQ ALUsrc; Expected: 0, Got: %d", ALUsrc);
        if(IsJump != 1'b0)
            $display("error with BEQ IsJump; Expected: 0, Got: %d", IsJump);
        if(IsJAL != 1'b0)
            $display("error with BEQ IsJAL; Expected: 0, Got: %d", IsJAL);
        if(IsJR != 1'b0)
            $display("error with BEQ IsJR; Expected: 0, Got: %d", IsJR);
        if(IsBranch != 1'b1)
            $display("error with BEQ IsBranch true; Expected: 1, Got: %d", IsBranch);
        // zero != 1 || overflow != 0
        OP=6'b000100; FUNCT='bx; zero=1'b0; overflow=1'b0; #1000
        if(IsBranch != 1'b0)
            $display("error with BEQ IsBranch false; Expected: 0, Got: %d", IsBranch);

        // Test 7: Branch on Not Equal
        $display("Testing BNE...");
        OP=6'b000101; FUNCT='bx; zero=1'b1; overflow=1'b0; #1000
        if(RegDst != 1'b0)
            $display("error with BNE RegDst; Expected: 0, Got: %d", RegDst);
        if(RegWr != 1'b0)
            $display("error with BNE RegWr; Expected: 0, Got: %d", RegWr);
        if(MemWr != 1'b0)
            $display("error with BNE MemWr; Expected: 0, Got: %d", MemWr);
        if(MemToReg != 1'b0)
            $display("error with BNE MemToReg; Expected: 0, Got: %d", MemToReg);
        if(ALUctrl != 3'b001)
            $display("error with BNE ALUctrl; Expected: 001, Got: %d", ALUctrl);
        if(ALUsrc != 1'b0)
            $display("error with BNE ALUsrc; Expected: 0, Got: %d", ALUsrc);
        if(IsJump != 1'b0)
            $display("error with BNE IsJump; Expected: 0, Got: %d", IsJump);
        if(IsJAL != 1'b0)
            $display("error with BNE IsJAL; Expected: 0, Got: %d", IsJAL);
        if(IsJR != 1'b0)
            $display("error with BNE IsJR; Expected: 0, Got: %d", IsJR);
        if(IsBranch != 1'b0)
            $display("error with BNE IsBranch false; Expected: 0, Got: %d", IsBranch);
        OP=6'b000101; FUNCT='bx; zero=1'b0; overflow=1'b0; #1000
        if(IsBranch != 1'b1)
            $display("error with BNE IsBranch true; Expected: 1, Got: %d", IsBranch);

        // Test 8: Exclusive OR with Immediate
        $display("Testing XORI...");
        OP=6'b001110; FUNCT='bx; zero='bx; overflow='bx; #1000
        if(RegDst != 1'b0)
            $display("error with XORI RegDst; Expected: 0, Got: %d", RegDst);
        if(RegWr != 1'b1)
            $display("error with XORI RegWr; Expected: 1, Got: %d", RegWr);
        if(MemWr != 1'b0)
            $display("error with XORI MemWr; Expected: 0, Got: %d", MemWr);
        if(MemToReg != 1'b0)
            $display("error with XORI MemToReg; Expected: 0, Got: %d", MemToReg);
        if(ALUctrl != 3'b010)
            $display("error with XORI ALUctrl; Expected: 010, Got: %d", ALUctrl);
        if(ALUsrc != 1'b1)
            $display("error with XORI ALUsrc; Expected: 1, Got: %d", ALUsrc);
        if(IsJump != 1'b0)
            $display("error with XORI IsJump; Expected: 0, Got: %d", IsJump);
        if(IsJAL != 1'b0)
            $display("error with XORI IsJAL; Expected: 0, Got: %d", IsJAL);
        if(IsJR != 1'b0)
            $display("error with XORI IsJR; Expected: 0, Got: %d", IsJR);
        if(IsBranch != 1'b0)
            $display("error with XORI IsBranch; Expected: 0, Got: %d", IsBranch);

        // Test 9: Add with Immediate
        $display("Testing ADDI...");
        OP=6'b001000; FUNCT='bx; zero='bx; overflow='bx; #1000
        if(RegDst != 1'b0)
            $display("error with ADDI RegDst; Expected: 0, Got: %d", RegDst);
        if(RegWr != 1'b1)
            $display("error with ADDI RegWr; Expected: 1, Got: %d", RegWr);
        if(MemWr != 1'b0)
            $display("error with ADDI MemWr; Expected: 0, Got: %d", MemWr);
        if(MemToReg != 1'b0)
            $display("error with ADDI MemToReg; Expected: 0, Got: %d", MemToReg);
        if(ALUctrl != 3'b000)
            $display("error with ADDI ALUctrl; Expected: 000, Got: %d", ALUctrl);
        if(ALUsrc != 1'b1)
            $display("error with ADDI ALUsrc; Expected: 1, Got: %d", ALUsrc);
        if(IsJump != 1'b0)
            $display("error with ADDI IsJump; Expected: 0, Got: %d", IsJump);
        if(IsJAL != 1'b0)
            $display("error with ADDI IsJAL; Expected: 0, Got: %d", IsJAL);
        if(IsJR != 1'b0)
            $display("error with ADDI IsJR; Expected: 0, Got: %d", IsJR);
        if(IsBranch != 1'b0)
            $display("error with ADDI IsBranch; Expected: 0, Got: %d", IsBranch);

        // Test 10: Add
        $display("Testing ADD...");
        OP=6'b000000; FUNCT=6'b100000; zero='bx; overflow='bx; #1000
        if(RegDst != 1'b1)
            $display("error with ADD RegDst; Expected: 1, Got: %d", RegDst);
        if(RegWr != 1'b1)
            $display("error with ADD RegWr; Expected: 1, Got: %d", RegWr);
        if(MemWr != 1'b0)
            $display("error with ADD MemWr; Expected: 0, Got: %d", MemWr);
        if(MemToReg != 1'b0)
            $display("error with ADD MemToReg; Expected: 0, Got: %d", MemToReg);
        if(ALUctrl != 3'b000)
            $display("error with ADD ALUctrl; Expected: 000, Got: %d", ALUctrl);
        if(ALUsrc != 1'b0)
            $display("error with ADD ALUsrc; Expected: 0, Got: %d", ALUsrc);
        if(IsJump != 1'b0)
            $display("error with ADD IsJump; Expected: 0, Got: %d", IsJump);
        if(IsJAL != 1'b0)
            $display("error with ADD IsJAL; Expected: 0, Got: %d", IsJAL);
        if(IsJR != 1'b0)
            $display("error with ADD IsJR; Expected: 0, Got: %d", IsJR);
        if(IsBranch != 1'b0)
            $display("error with ADD IsBranch; Expected: 0, Got: %d", IsBranch);

        // Test 11: Subtract
        $display("Testing SUB...");
        OP=6'b000000; FUNCT=6'b100010; zero='bx; overflow='bx; #1000
        if(RegDst != 1'b1)
            $display("error with SUB RegDst; Expected: 1, Got: %d", RegDst);
        if(RegWr != 1'b1)
            $display("error with SUB RegWr; Expected: 1, Got: %d", RegWr);
        if(MemWr != 1'b0)
            $display("error with SUB MemWr; Expected: 0, Got: %d", MemWr);
        if(MemToReg != 1'b0)
            $display("error with SUB MemToReg; Expected: 0, Got: %d", MemToReg);
        if(ALUctrl != 3'b001)
            $display("error with SUB ALUctrl; Expected: 001, Got: %d", ALUctrl);
        if(ALUsrc != 1'b0)
            $display("error with SUB ALUsrc; Expected: 0, Got: %d", ALUsrc);
        if(IsJump != 1'b0)
            $display("error with SUB IsJump; Expected: 0, Got: %d", IsJump);
        if(IsJAL != 1'b0)
            $display("error with SUB IsJAL; Expected: 0, Got: %d", IsJAL);
        if(IsJR != 1'b0)
            $display("error with SUB IsJR; Expected: 0, Got: %d", IsJR);
        if(IsBranch != 1'b0)
            $display("error with SUB IsBranch; Expected: 0, Got: %d", IsBranch);

        // Test 12: Set Less Than
        $display("Testing SLT...");
        OP=6'b000000; FUNCT=6'b101010; zero='bx; overflow='bx; #1000
        if(RegDst != 1'b1)
            $display("error with SLT RegDst; Expected: 1, Got: %d", RegDst);
        if(RegWr != 1'b1)
            $display("error with SLT RegWr; Expected: 1, Got: %d", RegWr);
        if(MemWr != 1'b0)
            $display("error with SLT MemWr; Expected: 0, Got: %d", MemWr);
        if(MemToReg != 1'b0)
            $display("error with SLT MemToReg; Expected: 0, Got: %d", MemToReg);
        if(ALUctrl != 3'b011)
            $display("error with SLT ALUctrl; Expected: 011, Got: %d", ALUctrl);
        if(ALUsrc != 1'b0)
            $display("error with SLT ALUsrc; Expected: 0, Got: %d", ALUsrc);
        if(IsJump != 1'b0)
            $display("error with SLT IsJump; Expected: 0, Got: %d", IsJump);
        if(IsJAL != 1'b0)
            $display("error with SLT IsJAL; Expected: 0, Got: %d", IsJAL);
        if(IsJR != 1'b0)
            $display("error with SLT IsJR; Expected: 0, Got: %d", IsJR);
        if(IsBranch != 1'b0)
            $display("error with SLT IsBranch; Expected: 0, Got: %d", IsBranch);

        $display("Done!");
    end
endmodule

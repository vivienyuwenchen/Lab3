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

    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    initial begin
        $display("I am working :)");
        // Test 1: Load Word
        OP=6'b100011; FUNCT='bx; zero='bx; overflow='bx; #50
        if(RegDst != 1'b0)
            $display("error with LW RegDst; Expected: 0, Got: %d", RegDst);
        if(RegWr != 1'b1)
            $display("error with LW RegWr; Expected: 1, Got: %d", RegWr);
        if(MemWr != 1'b0)
            $display("error with LW MemWr; Expected: 0, Got: %d", MemWr);
        if(MemToReg != 1'b1)
            $display("error with LW MemToReg; Expected: 1, Got: %d", MemToReg);
        if(ALUcntrl != 3'b000)
            $display("error with LW ALUcntrl; Expected: 000, Got: %d", ALUcntrl);
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


        // Test 3: Jump


        // Test 4: Jump Register


        // Test 5: Jump and Link


        // Test 6: Branch on Equal


        // Test 7: Branch on Not Equal


        // Test 8: Exclusive OR with Immediate


        // Test 9: Add with Immediate


        // Test 10: Add


        // Test 11: Subtract


        // Test 12: Set Less Than

        
    end
endmodule

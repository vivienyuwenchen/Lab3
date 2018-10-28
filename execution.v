//------------------------------------------------------------------------
// Behavioral Instruction Look Up Table
//------------------------------------------------------------------------

`include "regfile.v"
`include "datamemory.v"
`include "muxes.v"
`include "alu.v"

module execution
(
    input 	    OP,
    input       zero,
    output reg  RegDst,
    output reg  IsBranch
);

    mux regdest(.out(clk),
                    .in0(MemOut),
                    .in1(MemAddr),
                    .sel(MemWr));

    mux isjalawmux(.out(clk),
                    .in0(MemOut),
                    .in1(MemAddr),
                    .sel(MemWr));

    mux isjaldinmux(.out(clk),
                    .in0(MemOut),
                    .in1(MemAddr),
                    .sel(MemWr));

    regfile register(.ReadData1(Da),
                    .ReadData2(Db),
                    .WriteData(Din),
                    .ReadRegister1(Aa),
                    .ReadRegister2(Ab),
                    .WriteRegister(Aw),
                    .RegWrite(WrEn),
                    .Clk(clk));

    alu alu0(.carryout(clk),
                    .zero(MemOut),
                    .overflow(MemAddr),
                    .result(MemWr),
                    .operandA(),
                    .operandB(),
                    .command());

    mux alusrcmux(.out(clk),
                    .in0(MemOut),
                    .in1(MemAddr),
                    .sel(MemWr));

    datamemory datamem(.clk(clk),
                    .dataOut(MemOut),
                    .address(MemAddr),
                    .writeEnable(MemWr),
                    .dataIn(MemIn));

    mux mem2regmux(.out(clk),
                    .in0(MemOut),
                    .in1(MemAddr),
                    .sel(MemWr));

endmodule

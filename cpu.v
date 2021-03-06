//------------------------------------------------------------------------
// CPU Compilation
//------------------------------------------------------------------------

`include "regfile.v"
// `include "datamemory.v"
`include "memory.v"
`include "basicbuildingblocks.v"
`include "alu.v"
`include "instructiondecoder.v"
`include "lut.v"

module cpu_all
(
    input 	          clk
);

    // control wires
    wire RegDst, RegWr, MemWr, MemToReg, ALUsrc, IsJump, IsJAL, IsJR, IsBranch;
    wire [2:0] ALUctrl;
    wire [31:0]      datain;
    // decoder wires
    wire [5:0] OP, FUNCT;
    wire [4:0] RT, RS, RD, SHAMT;
    wire [15:0] IMM16;
    wire [25:0] TA;
  
    wire aluadd4carryout, aluadd4zero, aluadd4overflow, aluaddcarryout, aluaddzero, aluaddoverflow, carryout;

    wire [31:0] isjrout, PCplus4, shift2, aluaddsum, isbranchout, isjumpout, mem2regout, alusrcout, INSTRUCT;
    wire zero, overflow;
    wire [31:0] regDa, regDb, regDin, SE, result;
    wire [4:0] Rint, regAw;
    wire [31:0] PCcount, jumpaddr, branchaddr;
    wire [31:0] memout, instruction;

    memory mem(.clk(clk),
                    .WrEn(MemWr),
                    .DataAddr(result),
                    .DataIn(regDb),
                    .DataOut(memout),
                    .InstrAddr(PCcount),
                    .Instruction(instruction));

    instructiondecoder decoder(.OP(OP),
                    .RT(RT),
                    .RS(RS),
                    .RD(RD),
                    .IMM16(IMM16),
                    .TA(TA),
                    .SHAMT(SHAMT),
                    .FUNCT(FUNCT),
                    .instruction(instruction));

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

    dff #(32) pccounter(.trigger(clk),
                    .enable(1'b1),
                    .d(isjrout),
                    .q(PCcount));

    assign PCplus4 = PCcount + 32'h00000004;

    assign jumpaddr = {PCplus4[31:28], TA, 2'b00};
    assign branchaddr = {{14{IMM16[15]}}, IMM16, 2'b00};

    mux2 #(32) muxshift2(.in0(jumpaddr),
                    .in1(branchaddr),
                    .sel(IsBranch),
                    .out(shift2));

    assign aluaddsum = PCplus4 + shift2;

    mux2 #(32) muxisbranch(.in0(PCplus4),
                    .in1(aluaddsum),
                    .sel(IsBranch),
                    .out(isbranchout));

    mux2 #(32) muxisjump(.in0(isbranchout),
                    .in1(shift2),
                    .sel(IsJump),
                    .out(isjumpout));

    mux2 #(32) muxisjr(.in0(isjumpout),
                    .in1(regDa),
                    .sel(IsJR),
                    .out(isjrout));

    mux2 #(5) muxregdst(.in0(RT),
                    .in1(RD),
                    .sel(RegDst),
                    .out(Rint));

    mux2 #(5) muxixjalaw(.in0(Rint),
                    .in1(5'd31),
                    .sel(IsJAL),
                    .out(regAw));

    mux2 #(32) muxisjaldin(.in0(mem2regout),
                    .in1(PCplus4),
                    .sel(IsJAL),
                    .out(regDin));

    regfile register(.ReadData1(regDa),
                    .ReadData2(regDb),
                    .WriteData(regDin),
                    .ReadRegister1(RS),
                    .ReadRegister2(RT),
                    .WriteRegister(regAw),
                    .RegWrite(RegWr),
                    .Clk(clk));

    ALU alumain(.carryout(carryout),
                    .zero(zero),
                    .overflow(overflow),
                    .result(result),
                    .operandA(regDa),
                    .operandB(alusrcout),
                    .command(ALUctrl));

    assign SE = {{16{IMM16[15]}}, IMM16};

    mux2 #(32) muxalusrc(.in0(regDb),
                    .in1(SE),
                    .sel(ALUsrc),
                    .out(alusrcout));

    mux2 #(32) muxmem2reg(.in0(result),
                    .in1(memout),
                    .sel(MemToReg),
                    .out(mem2regout));

endmodule


`include "memory.v"


module instructiondecoder
(
    output [5:0]  OP,     //OP code
    output [4:0]   RT,      // the 20:15 bits of instruction
    output [4:0]   RS,      // the 25:21 bits of instruction
    output [4:0]   RD,      // the 15:11 bits of instruction
    output  [15:0]    IMM16,  // the 15:0 bits of instruction
    output  [25:0]    TA,  // the 25:0 bit of instruction -  target address
    output  [4:0]       SHAMT, // ther 10:6 biit of R type instruction
    output  [5:0]       FUNCT,  // the 5:0 bit of the R type instruction
    input  [31:0]    readAddress,  // the 32 bit address from the Program Counter
    input           RegWrite,       // Enable writing of register when High
    input           Clk, DataIn            // Clock (Positive Edge Triggered)
);

  wire [31:0] instructions;

  memory instructionMem(.clk(Clk), .regWE(RegWrite), .Addr(readAddress), .DataIn(DataIn), .DataOut(instructions));
  assign OP = instructions[31:26];
  assign RT = instructions[20:16];
  assign RS = instructions[25:21];
  assign RD = instructions[15:11];
  assign imm16 = instructions[15:0];
  assign TA = instructions[25:0];
  assign SHAMT = instructions[10:6];
  assign FUNCT = instructions[5:0];

endmodule

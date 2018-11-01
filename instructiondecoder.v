// `include "memory.v"
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
    input  [31:0]    instruction  // the 32 bit address from the Program Counter
);

  assign OP = instruction[31:26];
  assign RT = instruction[20:16];
  assign RS = instruction[25:21];
  assign RD = instruction[15:11];
  assign IMM16 = instruction[15:0];
  assign TA = instruction[25:0];
  assign SHAMT = instruction[10:6];
  assign FUNCT = instruction[5:0];

endmodule

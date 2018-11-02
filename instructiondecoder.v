//------------------------------------------------------------------------
// Instruction Decoder
//------------------------------------------------------------------------

module instructiondecoder
(
    output [5:0]    OP,     // 31:26 bits of all types [operation]
    output [4:0]    RT,     // 20:16 bits of I-type & R-type
    output [4:0]    RS,     // 25:21 bits of I-type & R-type
    output [4:0]    RD,     // 15:11 bits of R-type
    output [15:0]   IMM16,  // 15:0 bits of I-type [16-bit immediate]
    output [25:0]   TA,     // 25:0 bit of J-type [target address]
    output [4:0]    SHAMT,  // 10:6 bits of R-type [shift amount]
    output [5:0]    FUNCT,  // 5:0 bits of R-type [function]
    input  [31:0]   instruction  // 32 bits of instruction from instruction memory
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

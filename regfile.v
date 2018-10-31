//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------

`include "basicbuildingblocks.v"

module regfile
(
    output [31:0]   ReadData1,      // Contents of first register read
    output [31:0]   ReadData2,      // Contents of second register read
    input  [31:0]   WriteData,      // Contents to write to register
    input  [4:0]    ReadRegister1,  // Address of first register to read
    input  [4:0]    ReadRegister2,  // Address of second register to read
    input  [4:0]    WriteRegister,  // Address of register to write
    input           RegWrite,       // Enable writing of register when High
    input           Clk             // Clock (Positive Edge Triggered)
);

    wire [31:0]   DecoderOutput;
    wire [31:0]   RegisterOutput[31:0];

    decoder1to32 decoder(DecoderOutput, RegWrite, WriteRegister);
    register32zero register0(RegisterOutput[0], RegWrite, Clk);

    genvar i;
    generate for (i = 1; i < 32; i = i + 1) begin
            register32 register(RegisterOutput[i], WriteData, DecoderOutput[i], Clk);
        end
    endgenerate

    mux32to1by32 multiplexer1(ReadData1, ReadRegister1, RegisterOutput[0], RegisterOutput[1], RegisterOutput[2], RegisterOutput[3],
        RegisterOutput[4], RegisterOutput[5], RegisterOutput[6], RegisterOutput[7], RegisterOutput[8], RegisterOutput[9],
        RegisterOutput[10], RegisterOutput[11], RegisterOutput[12], RegisterOutput[13], RegisterOutput[14], RegisterOutput[15],
        RegisterOutput[16], RegisterOutput[17], RegisterOutput[18], RegisterOutput[19], RegisterOutput[20], RegisterOutput[21],
        RegisterOutput[22], RegisterOutput[23], RegisterOutput[24], RegisterOutput[25], RegisterOutput[26], RegisterOutput[27],
        RegisterOutput[28], RegisterOutput[29], RegisterOutput[30], RegisterOutput[31]);
    mux32to1by32 multiplexer2(ReadData2, ReadRegister2, RegisterOutput[0], RegisterOutput[1], RegisterOutput[2], RegisterOutput[3],
        RegisterOutput[4], RegisterOutput[5], RegisterOutput[6], RegisterOutput[7], RegisterOutput[8], RegisterOutput[9],
        RegisterOutput[10], RegisterOutput[11], RegisterOutput[12], RegisterOutput[13], RegisterOutput[14], RegisterOutput[15],
        RegisterOutput[16], RegisterOutput[17], RegisterOutput[18], RegisterOutput[19], RegisterOutput[20], RegisterOutput[21],
        RegisterOutput[22], RegisterOutput[23], RegisterOutput[24], RegisterOutput[25], RegisterOutput[26], RegisterOutput[27],
        RegisterOutput[28], RegisterOutput[29], RegisterOutput[30], RegisterOutput[31]);

endmodule

//------------------------------------------------------------------------------
// Support Modules
//------------------------------------------------------------------------------
module register32 #(parameter W = 32)
(
    output reg [W-1:0]  q,
    input      [W-1:0]  d,
    input               wrenable,
    input               clk
);

    always @(posedge clk) begin
        if(wrenable) begin
            q <= d;
        end
    end

endmodule


module register32zero #(parameter W = 32)
(
    output reg [W-1:0]  q,
    input               wrenable,
    input               clk
);

    always @(posedge clk) begin
        if(wrenable) begin
            q <= 32'd0;;
        end
    end

endmodule

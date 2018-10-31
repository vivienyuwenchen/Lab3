//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------

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


// 32 bit decoder with enable signal
//   enable=0: all output bits are 0
//   enable=1: out[address] is 1, all other outputs are 0
module decoder1to32
(
    output [31:0]   out,
    input           enable,
    input  [4:0]    address
);

    assign out = enable<<address;

endmodule


// 32 to 1 multiplexer with 32 bit output
module mux32to1by32
(
    output [31:0]  out,
    input  [4:0]   address,
    input  [31:0]  input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10,
    input  [31:0]  input11, input12, input13, input14, input15, input16, input17, input18, input19, input20,
    input  [31:0]  input21, input22, input23, input24, input25, input26, input27, input28, input29, input30, input31
);

    wire[31:0] mux[31:0];       // Create a 2D array of wires
    assign mux[0] = input0;     // Connect the sources of the array
    assign mux[1] = input1;
    assign mux[2] = input2;
    assign mux[3] = input3;
    assign mux[4] = input4;
    assign mux[5] = input5;
    assign mux[6] = input6;
    assign mux[7] = input7;
    assign mux[8] = input8;
    assign mux[9] = input9;
    assign mux[10] = input10;
    assign mux[11] = input11;
    assign mux[12] = input12;
    assign mux[13] = input13;
    assign mux[14] = input14;
    assign mux[15] = input15;
    assign mux[16] = input16;
    assign mux[17] = input17;
    assign mux[18] = input18;
    assign mux[19] = input19;
    assign mux[20] = input20;
    assign mux[21] = input21;
    assign mux[22] = input22;
    assign mux[23] = input23;
    assign mux[24] = input24;
    assign mux[25] = input25;
    assign mux[26] = input26;
    assign mux[27] = input27;
    assign mux[28] = input28;
    assign mux[29] = input29;
    assign mux[30] = input30;
    assign mux[31] = input31;
    assign out = mux[address];  // Connect the output of the array

endmodule

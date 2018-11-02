//------------------------------------------------------------------------
// Memory Module
//------------------------------------------------------------------------

module memory
(
    input clk,
    input WrEn,                 // Data memory write enable
    input[31:0] DataAddr,       // Data memory address
    input[31:0] DataIn,         // Data memory input
    output[31:0] DataOut,       // Data memory output
    input[31:0] InstrAddr,      // Instruction memory address
    output[31:0] Instruction    // Instruction memory output
);

    wire [11:0] DataIndex;      // Data memory index
    wire [11:0] InstrIndex;     // Instruction memory index
    reg [31:0] mem[4095:0];     // 16kb Memory

    assign InstrIndex = {InstrAddr[13:2]};
    assign DataIndex = {DataAddr[13:2]};

    always @(posedge clk) begin
        if (WrEn) begin
            mem[DataAddr] <= DataIn;
        end
    end

    initial $readmemh("addN.dat", mem);

    assign DataOut = mem[DataIndex];
    assign Instruction = mem[InstrIndex];

endmodule

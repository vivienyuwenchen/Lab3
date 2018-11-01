module memory
(
    input clk, WrEn,
    input[31:0] DataAddr, //31:0
    input[31:0] DataIn,
    output[31:0] DataOut,
    input[31:0] InstrAddr,
    output[31:0] Instruction
);
    wire [11:0] InstrIndex;
    wire [11:0] DataIndex;
    reg [31:0] mem[4095:0];

    assign InstrIndex = {InstrAddr[13:2]};
    assign DataIndex = {DataAddr[13:2]};

    always @(posedge clk) begin
        if (WrEn) begin
            mem[DataAddr] <= DataIn;
        end
    end

    initial $readmemh("addN.dat", mem);

    assign Instruction = mem[InstrIndex];
    assign DataOut = mem[DataIndex];
endmodule

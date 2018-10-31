`include "instructiondecoder.v"
module instructiontest();
    // decoder wires
    wire [5:0] OP, FUNCT;
    wire [4:0] RT, RS, RD, SHAMT;
    wire [15:0] IMM16;
    wire [25:0] TA;
    wire [31:0] datain;
    reg [31:0] PCcount;
    wire [31:0] INSTRUCT;
    wire RegWr, clk;

    instructiondecoder decoder(.OP(OP),
                    .RT(RT),
                    .RS(RS),
                    .RD(RD),
                    .IMM16(IMM16),
                    .TA(TA),
                    .SHAMT(SHAMT),
                    .FUNCT(FUNCT),
                    .INSTRUCT(INSTRUCT),
                    .readAddress(PCcount),
                    .RegWrite(RegWr),
                    .Clk(clk),
                    .DataIn(datain));
    initial begin
        $display("Starting instruction test..");
//
//         // Test 1: Fetch Instruction memory
//         $display("Fetch PC count 0");
//         PCcount= 0; #1000
//
//             $display("Intruction: Expected: 00000000, Got: %d", INSTRUCT);
//     end
// endmodule


    PCcount = 0;
    if (INSTRUCT == 32'h1000_0001) begin
        $display("Test 1 Passed");
    end
    else begin
        $display("Test 1 Failed");
    end

    PCcount = 1;
    if (INSTRUCT == 32'h1000_000F) begin
        $display("Test 2 Passed");
    end
    else begin
        $display("Test 2 Failed");
    end

    PCcount = 2;
    if (INSTRUCT == 32'h0000_0000) begin
        $display("Test 3 Passed");
    end
    else begin
        $display("Test 3 Failed");
    end
end
endmodule

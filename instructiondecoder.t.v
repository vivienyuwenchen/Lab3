//------------------------------------------------------------------------
// Test Bench for Instruction Decoder
//------------------------------------------------------------------------

`include "instructiondecoder.v"

module instructiontest();
    wire [5:0]  OP, FUNCT;
    wire [4:0]  RT, RS, RD, SHAMT;
    wire [15:0] IMM16;
    wire [25:0] TA;
    reg  [31:0] instruction;

    instructiondecoder dut(.OP(OP),
                    .RT(RT),
                    .RS(RS),
                    .RD(RD),
                    .IMM16(IMM16),
                    .TA(TA),
                    .SHAMT(SHAMT),
                    .FUNCT(FUNCT),
                    .instruction(instruction));

    initial begin

        $display("Instruction Decoder Test Starting...");

        // J-type instruction
        instruction = 32'h0c000016; #1000

        if (OP == 6'b000011 && RT == 5'b00000 && RS == 5'b00000 && RD == 5'b00000 && IMM16 == 16'b0000000000010110 &&
            TA == 26'b00000000000000000000010110 && SHAMT == 5'b00000 && FUNCT == 6'b010110) begin
            $display("Test 1 Passed!");
        end
        else begin
            $display("Test 1 Failed :(");
            $display("OP: %b, Expected: 000011", OP);
            $display("RT: %b, Expected: 00000", RT);
            $display("RS: %b, Expected: 00000", RS);
            $display("RD: %b, Expected: 00000", RD);
            $display("IMM16: %b, Expected: 0000000000010110", IMM16);
            $display("TA: %b, Expected: 00000000000000000000010110", TA);
            $display("SHAMT: %b, Expected: 00000", SHAMT);
            $display("FUNCT: %b, Expected: 010110", FUNCT);
        end

        // I-type instruction
        instruction = 32'h2004000a; #1000

        if (OP == 6'b001000 && RT == 5'b00100 && RS == 5'b00000 && RD == 5'b00000 && IMM16 == 16'b0000000000001010 &&
            TA == 26'b00000001000000000000001010 && SHAMT == 5'b00000 && FUNCT == 6'b001010) begin
            $display("Test 2 Passed!");
        end
        else begin
            $display("Test 2 Failed :(");
            $display("OP: %b, Expected: 001000", OP);
            $display("RT: %b, Expected: 00100", RT);
            $display("RS: %b, Expected: 00000", RS);
            $display("RD: %b, Expected: 00000", RD);
            $display("IMM16: %b, Expected: 0000000000001010", IMM16);
            $display("TA: %b, Expected: 00000001000000000000001010", TA);
            $display("SHAMT: %b, Expected: 00000", SHAMT);
            $display("FUNCT: %b, Expected: 001010", FUNCT);
        end

        // R-type instruction
        instruction = 32'h02111020; #1000

        if (OP == 6'b000000 && RT == 5'b10001 && RS == 5'b10000 && RD == 5'b00010 && IMM16 == 16'b0001000000100000 &&
            TA == 26'b10000100010001000000100000 && SHAMT == 5'b00000 && FUNCT == 6'b100000) begin
            $display("Test 3 Passed!");
        end
        else begin
            $display("Test 3 Failed :(");
            $display("OP: %b, Expected: 000000", OP);
            $display("RT: %b, Expected: 10001", RT);
            $display("RS: %b, Expected: 10000", RS);
            $display("RD: %b, Expected: 00010", RD);
            $display("IMM16: %b, Expected: 0001000000100000", IMM16);
            $display("TA: %b, Expected: 10000100010001000000100000", TA);
            $display("SHAMT: %b, Expected: 00000", SHAMT);
            $display("FUNCT: %b, Expected: 100000", FUNCT);
        end

        $display("Instruction Decoder Test Done!");

    end
endmodule

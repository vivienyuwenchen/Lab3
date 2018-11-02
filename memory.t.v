//------------------------------------------------------------------------
// Test Bench for Memory Module
//------------------------------------------------------------------------

`timescale 1 ns / 1 ps
`include "memory.v"

module testMemory();

    reg clk;
    reg WrEn;
    reg[31:0] DataAddr;
    reg[31:0] DataIn;
    wire[31:0] DataOut;
    reg[31:0] InstrAddr;
    wire[31:0] Instruction;

    memory mem(.clk(clk),
                    .WrEn(WrEn),
                    .DataAddr(DataAddr),
                    .DataIn(DataIn),
                    .DataOut(DataOut),
                    .InstrAddr(InstrAddr),
                    .Instruction(Instruction));

    initial clk=0;
    always #10 clk = !clk;

    initial begin
        $display("--------------------------------------------------");
        $display("Memory tests starting...");

        $readmemh("./dat/addN.dat", mem.mem, 0);

        // Instruction memory and data memory output tests
        InstrAddr = 32'h0; DataAddr = 32'h0; #1000
        if (Instruction == 32'h2004000a && DataOut == 32'h2004000a) begin
            $display("Test 1 Passed");
        end
        else begin
            $display("Test 1 Failed %h", DataOut);
        end

        InstrAddr = 32'h10; DataAddr = 32'h10; #1000
        if (Instruction == 32'h11040003 && DataOut == 32'h11040003) begin
            $display("Test 2 Passed");
        end
        else begin
            $display("Test 2 Failed");
        end

        InstrAddr = 32'h14; DataAddr = 32'h14; #1000
        if (Instruction == 32'h01284820 && DataOut == 32'h01284820) begin
            $display("Test 3 Passed");
        end
        else begin
            $display("Test 3 Failed");
        end

        // Data memory input and output tests
        WrEn = 1'b1; DataAddr = 32'hFFFFFFFC; DataIn = 32'h12345678; #1000
        if (DataOut == 32'h12345678) begin
            $display("Test 4 Passed");
        end
        else begin
            $display("Test 4 Failed");
        end

        WrEn = 1'b0; DataAddr = 32'hFFFFFFFC; DataIn = 32'habcdef90; #1000
        if (DataOut == 32'h12345678) begin
            $display("Test 5 Passed");
        end
        else begin
            $display("Test 5 Failed");
        end

        $display("Memory tests done!");
        $display("--------------------------------------------------");
        $finish;
    end

endmodule

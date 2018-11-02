//------------------------------------------------------------------------
// Test Bench for Memory Module
//------------------------------------------------------------------------

`include "memory.v"

module testMemory();

    reg clk, regWE;
    reg[31:0] Addr;
    reg[31:0] DataIn;
    wire[31:0]  DataOut;

    memory_test Instruction_Memory(.clk(clk), .regWE(regWE), .Addr(Addr), .DataIn(DataIn), .DataOut(DataOut));

    initial begin
        Addr = 0;
        if (DataOut == 32'h1000_0001) begin
            $display("Test 1 Passed");
        end
        else begin
            $display("Test 1 Failed");
        end

        Addr = 1;
        if (DataOut == 32'h1000_000F) begin
            $display("Test 2 Passed");
        end
        else begin
            $display("Test 2 Failed");
        end

        Addr = 2;
        if (DataOut == 32'h0000_0000) begin
            $display("Test 3 Passed");
        end
        else begin
            $display("Test 3 Failed");
        end
    end

endmodule

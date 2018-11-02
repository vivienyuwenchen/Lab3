//------------------------------------------------------------------------
// Test bench for DFF (PC Counter), MUX2
//------------------------------------------------------------------------

`timescale 1 ns / 1 ps
`include "basicbuildingblocks.v"

module testDFF();

    reg clk;
    reg enable;
    reg [31:0] d;
    wire [31:0] q;

    dff #(32) dut(.trigger(clk),
                .enable(enable),
			    .d(d),
			    .q(q));

    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

    initial begin
        $display("--------------------------------------------------");
        $display("Testing DFF...");
        enable=1'b1; d=32'hAAAAAAAA; #1000
        if(q != 32'hAAAAAAAA)
            $display("ERROR Expected: AAAAAAAA, Got: %h", q);
        enable=1'b0; d=32'hBBBBBBBB; #1000
        if(q != 32'hAAAAAAAA)
            $display("ERROR Expected: AAAAAAAA, Got: %h", q);
        enable=1'b1; d=32'hCCCCCCCC; #1000
        if(q != 32'hCCCCCCCC)
            $display("ERROR Expected: CCCCCCCC, Got: %h", q);
        enable=1'b0; d=32'hDDDDDDDD; #1000
        if(q != 32'hCCCCCCCC)
            $display("ERROR Expected: CCCCCCCC, Got: %h", q);
        $display("Done with DFF!");
        $display("--------------------------------------------------");
        $finish();
    end
endmodule

module testMUX2();

    reg [31:0] in0;
    reg [31:0] in1;
    reg sel;
    wire [31:0] out;

    mux2 #(32) dut(.in0(in0),
                .in1(in1),
			    .sel(sel),
			    .out(out));

    initial begin
        $display("Testing MUX2...");
        in0=32'hAAAAAAAA; in1=32'hBBBBBBBB; sel=1'b0; #1000
        if(out != 32'hAAAAAAAA)
            $display("ERROR Expected: AAAAAAAA, Got: %h", out);
        in0=32'hAAAAAAAA; in1=32'hBBBBBBBB; sel=1'b1; #1000
        if(out != 32'hBBBBBBBB)
            $display("ERROR Expected: BBBBBBBB, Got: %h", out);
        $display("Done with MUX2!");
    end
endmodule

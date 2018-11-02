//-----------------------------------------------------------------------------
// Basic building block modules (DFF and MUX2)
//-----------------------------------------------------------------------------

// D flip-flop with parameterized bit width (default: 1-bit)
// Parameters in Verilog: http://www.asic-world.com/verilog/para_modules1.html
module dff #( parameter W = 32 )
(
    input trigger,
    input enable,
    input   [W-1:0] d,
    output  [W-1:0] q
);

    reg [W-1:0] mem;

    initial begin
        mem <= {W{1'b0}};
    end

    always @(posedge trigger) begin
        if(enable) begin
            mem <= d;
        end
    end

    assign q = mem;
endmodule

// Two-input MUX with parameterized bit width (default: 1-bit)
module mux2 #( parameter W = 32 )
(
    input[W-1:0]    in0,
    input[W-1:0]    in1,
    input           sel,
    output[W-1:0]   out
);
    // Conditional operator - http://www.verilog.renerta.com/source/vrg00010.htm
    assign out = (sel) ? in1 : in0;
endmodule

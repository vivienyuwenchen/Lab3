// Single-bit D Flip-Flop with enable
//   Positive edge triggered
module register
(
    output reg  q,
    input       d,
    input       wrenable,
    input       clk
);

    always @(posedge clk) begin
        if(wrenable) begin
            q <= d;
        end
    end

endmodule


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

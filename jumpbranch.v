`include "basicbuildingblocks.v"

module jumpbranch (
  input  [25:0]    TA,  // the 25:0 bit of instruction -  target address
  input  [31:0]    Da,
  input           Clk,   // Clock (Positive Edge Triggered)
  output [31:0]    PC
);

  wire [31:0] pctoadd;
  wire [31:0] aluadd4carryout;
  wire [31:0] aluadd4zero;
  wire [31:0] aluadd4overflow;
  wire [31:0] aluaddcarryout;
  wire [31:0] aluaddzero;
  wire [31:0] aluaddoverflow;
  wire [31:0] pc4;
  wire [31:0] TAPC4;
  wire [31:0] shifted2;
  wire [31:0] addedpc4shift2;
  wire [31:0] isbranchout;
  wire [31:0] isjumpout;
  wire [31:0] isjrout;


  alu aluadd4 (aluadd4carryout, aluadd4zero, aluadd4overflow, pc4, pctoadd, 3'b100, 3'b001);
  assign TAPC4 = {pc4[31:28], TA};
  assign shifted2 = TAPC4<<2'b00; 
  alu aluadd (aluaddcarryout, aluaddzero, aluaddoverflow, addedpc4shift2, shifted2, pc4, 3'b001);
  mux2 muxisbranch (isbranchout, pc4, addedpc4shift2, isbranch); //   mux muxisbranch (out, in0, in1, sel)
  mux2 muxisjump (isjumpout, isbranchout, shifted2, isjump);
  mux2 muxisjr (isjrout, isjumpout, Da, isjr);
  dff PC (Clk, 1, isjrout, PC);

endmodule
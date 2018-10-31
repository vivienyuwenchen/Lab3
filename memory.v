module memory_test
(
  input clk, regWE,
  input[31:0] Addr, //31:0
  input[31:0] DataIn,
  output[31:0]  DataOut
);
  reg [31:0] index;
  reg [31:0] mem[1023:0];

  always @(posedge clk) begin
    //index <= {{2{Addr[31]}}, Addr[31:2]};
    if (regWE) begin
      //mem[index] <= DataIn;
      mem[Addr]<= DataIn;
    end
  end

  initial $readmemh("mem.dat", mem);

  assign DataOut = mem[Addr];
endmodule

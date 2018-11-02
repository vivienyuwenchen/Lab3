`include "cpu.v"

//------------------------------------------------------------------------
// Test bench for Fibbanocci sequence
// This tests for ADD, ADDI, BNE, LW, SW, J, JAL, JR functionalities
// The final answer can be found in $v0$
//------------------------------------------------------------------------

module cpu_test_fib ();

    reg clk;
    reg reset;

    // Clock generation
    initial clk=0;
    always #10 clk = !clk;

    // Instantiate CPU
    cpu_all cpu(.clk(clk));

    initial begin

    $readmemh("fib_func.dat", cpu.mem.mem,0);

  	$dumpfile("cpu_fib.vcd");
  	$dumpvars();

  	// Assert reset pulse
  	reset = 0; #10;
  	reset = 1; #10;
  	reset = 0; #10;

    #1000000
    if(cpu.register.RegisterOutput[2] != 32'h3a) begin
          $display("----------------------------------------");
          $display("FAILED FIB TEST");
          $display("$v0: Expected: %h, ACTUAL: %h", 32'h3a, cpu.register.RegisterOutput[2]);
          $display("----------------------------------------");
          end
   else begin
         $display("----------------------------------------");
         $display("PASSED FIB TEST");
         $display("----------------------------------------");
         end
  	#2000 $finish();
      end

  endmodule

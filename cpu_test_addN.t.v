`include "cpu.v"

//------------------------------------------------------------------------
// Test bench for adding together 10 consecutive integers.
// The final answer can be found in $t1$
// This test bench tests the BEQ, ADD, ADDI, J functionalities of the CPU
//------------------------------------------------------------------------

module cpu_test_addN ();

    reg clk;
    reg reset;

    // Clock generation
    initial clk=0;
    always #10 clk = !clk;

    // Instantiate CPU
    cpu_all cpu(.clk(clk));

    initial begin

    $readmemh("./dat/addN.dat", cpu.mem.mem,0); // load assembly instructions into memory
  	// Dump waveforms to file
  	$dumpfile("cputest.vcd");
  	$dumpvars();

  	// Assert reset pulse
  	reset = 0; #10;
  	reset = 1; #10;
  	reset = 0; #10;
    #1000
    if(cpu.register.RegisterOutput[2] != 32'h37 || cpu.register.RegisterOutput[4] != 32'hb || cpu.register.RegisterOutput[8] != 32'hb || cpu.register.RegisterOutput[9] != 32'h37) begin
          $display("----------------------------------------");
          $display("FAILED ADD_N TEST. $v0$: Expected: %h, ACTUAL: %h", 32'h37, cpu.register.RegisterOutput[2]);
          $display("FAILED ADD_N TEST. $a0$:  Expected: %h, ACTUAL: %h", 32'hb, cpu.register.RegisterOutput[4]);
          $display("FAILED ADD_N TEST. $t0$: Expected: %h, ACTUAL: %h", 32'h3b, cpu.register.RegisterOutput[8]);
          $display("FAILED ADD_N TEST. $t1$: Expected: %h, ACTUAL: %h", 32'h37, cpu.register.RegisterOutput[9]);
          $display("----------------------------------------");
          end
    else begin
          $display("----------------------------------------");
          $display("PASSED ADD_N TEST");
          $display("----------------------------------------");
          end
  	#2000 $finish();
      end

  endmodule

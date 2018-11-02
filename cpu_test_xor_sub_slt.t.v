`include "execution.v"

//------------------------------------------------------------------------
// Test bench for XOR SUB SLT sequence
//------------------------------------------------------------------------

module cpu_test_fib ();

    reg clk;
    reg reset;

    // Clock generation
    initial clk=0;
    always #10 clk = !clk;

    // Instantiate CPU
    execution cpu(.clk(clk));

    // Filenames for memory images and VCD dump file
    reg [1023:0] mem_text_fn;
    reg [1023:0] mem_data_fn;
    reg [1023:0] dump_fn;
    reg init_data = 1;      // Initializing .data segment is optional

    initial begin


    $readmemh("xor_sub_slt.dat", cpu.mem.mem,0);
  	// Dump waveforms to file
  	// Note: arrays (e.g. memory) are not dumped by default
  	$dumpfile("cpu_xor.vcd");
  	$dumpvars();

  	// Assert reset pulse
  	reset = 0; #10;
  	reset = 1; #10;
  	reset = 0; #10;

    #1000000
    if(cpu.register.RegisterOutput[8] != 32'h1 || cpu.register.RegisterOutput[9] != 32'h1 || cpu.register.RegisterOutput[10] != 32'h7 || cpu.register.RegisterOutput[11] != 32'hfffffffb || cpu.register.RegisterOutput[12] != 32'h3 || cpu.register.RegisterOutput[13] != 32'hfffffff2 || cpu.register.RegisterOutput[14] != 32'hfffffff7  ) begin// || cpu.register.RegisterOutput[4] != 32'hb || cpu.register.RegisterOutput[8] != 32'hb || cpu.register.RegisterOutput[9] != 32'h37)
          $display("FAILED XOR SUB SLT TEST");
          $display("$v0: Expected: %h, ACTUAL: %h", 32'h1, cpu.register.RegisterOutput[8]);
          $display("$v0: Expected: %h, ACTUAL: %h", 32'h1, cpu.register.RegisterOutput[9]);
          $display("$v0: Expected: %h, ACTUAL: %h", 32'h1, cpu.register.RegisterOutput[10]);
          $display("$v0: Expected: %h, ACTUAL: %h", 32'h1, cpu.register.RegisterOutput[11]);
          $display("$v0: Expected: %h, ACTUAL: %h", 32'h1, cpu.register.RegisterOutput[12]);
          $display("$v0: Expected: %h, ACTUAL: %h", 32'h1, cpu.register.RegisterOutput[13]);
          $display("$v0: Expected: %h, ACTUAL: %h", 32'h1, cpu.register.RegisterOutput[14]);

          end
   else
         $display("PASSED XOR, SUB, SLT TEST");

  	#2000 $finish();
      end

  endmodule

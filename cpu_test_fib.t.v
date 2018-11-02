`include "execution.v"

//------------------------------------------------------------------------
// Test bench for fibbanocci sequence
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


    $readmemh("fib.dat", cpu.mem.mem,0);
  	// Dump waveforms to file
  	// Note: arrays (e.g. memory) are not dumped by default
  	$dumpfile("cpu_fib.vcd");
  	$dumpvars();

  	// Assert reset pulse
  	reset = 0; #10;
  	reset = 1; #10;
  	reset = 0; #10;


  	$display("Time | PC       | Instruction");
  	repeat(4) begin
          $display("%4t | %h | %h", $time, cpu.PCcount, cpu.instruction); #20 ;
          end
  	$display("... more execution (see waveform)");
    #10000
    if(cpu.register.RegisterOutput[2] != 32'h1 || cpu.register.RegisterOutput[4] != 32'h3a || cpu.register.RegisterOutput[5] != 32'ha) begin// || cpu.register.RegisterOutput[4] != 32'hb || cpu.register.RegisterOutput[8] != 32'hb || cpu.register.RegisterOutput[9] != 32'h37)
          $display("FAILED FIB TEST");
          $display("$v0: Expected: %h, ACTUAL: %h", 32'h1, cpu.register.RegisterOutput[2]);
          $display("$a0: %h, ACTUAL: %h", 32'h3a, cpu.register.RegisterOutput[4]);
          $display("$a1: %h, ACTUAL: %h", 32'ha, cpu.register.RegisterOutput[5]);
          end
   else
         $display("PASSED FIB TEST");

  	// End execution after some time delay - adjust to match your program
  	// or use a smarter approach like looking for an exit syscall or the
  	// PC to be the value of the last instruction in your program.
  	#2000 $finish();
      end

  endmodule

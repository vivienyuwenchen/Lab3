`include "execution.v"

//------------------------------------------------------------------------
// Test bench for adding together N integers
//------------------------------------------------------------------------

module cpu_test ();

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


    $readmemh("addN.dat", cpu.mem.mem,0);
  	// Dump waveforms to file
  	// Note: arrays (e.g. memory) are not dumped by default
  	$dumpfile("cputest.vcd");
  	$dumpvars();

  	// Assert reset pulse
  	reset = 0; #10;
  	reset = 1; #10;
  	reset = 0; #10;
    #1000
    if(cpu.register.RegisterOutput[2] != 32'h37 || cpu.register.RegisterOutput[4] != 32'hb || cpu.register.RegisterOutput[8] != 32'hb || cpu.register.RegisterOutput[9] != 32'h37)
          $display("FAILED ADD_N TEST. Expected: %h, ACTUAL: %h", 32'h37, cpu.register.RegisterOutput[2]);
    else
          $display("PASSED ADD_N TEST");


  	#2000 $finish();
      end

  endmodule

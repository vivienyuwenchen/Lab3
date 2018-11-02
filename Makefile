cpu: cpu_test_addN.t.v cpu_test_fib.t.v cpu_test_xor_sub_slt.t.v
	iverilog -o cpu_test_addN.o cpu_test_addN.t.v
	iverilog -o cpu_test_fib.o cpu_test_fib.t.v
	iverilog -o cpu_test_xor_sub_slt.o cpu_test_xor_sub_slt.t.v
	./cpu_test_addN.o
	./cpu_test_fib.o
	./cpu_test_xor_sub_slt.o

test: alu.t.v basicbuildingblocks.t.v instructiondecoder.t.v lut.t.v memory.t.v regfile.t.v
	iverilog -o alu.o alu.t.v
	iverilog -o basicbuildingblocks.o basicbuildingblocks.t.v
	iverilog -o instructiondecoder.o instructiondecoder.t.v
	iverilog -o lut.o lut.t.v
	iverilog -o memory.o memory.t.v
	iverilog -o regfile.o regfile.t.v
	./alu.o
	./basicbuildingblocks.o
	./instructiondecoder.o
	./lut.o
	./memory.o
	./regfile.o

clean:
	rm *.o
	rm *.vcd

There are 4 assembly files in this folder.
---------------------------------------
fibfunc.asm
This file tests the fibonacci sequence.
This tests for ADD, ADDI, BNE, LW, SW, J, JAL, JR functionalities
The final answer can be found in $v0$ = 32'h3a
---------------------------------------

addNintegers.asm
Tests for adding together 10 consecutive integers.
This tests the BEQ, ADD, ADDI, J functionalities of the CPU
The final answer can be found in $t1$  = 32'h37
---------------------------------------

xor_sub_slt.asm
Tests for XOR SUB SLT sequence.
This tests the ADDI, XORI, SUB, SLT, BNE, J functionality
outputs are found in $t0$ through $t6$
Where:
$t0$ = 32h'1
$t1$ = 32h'1
$t2$ = 32h'7
$t3$ = 32h'fffffffb
$t4$ = 32h'3
$t5$ = 32h'fffffff2
$t6$ = 32h'fffffff7
--------------------------------------

test1.asm
This stores 6 variables into t1 through t6 by using addi.
Then it will SLT the first 2 variables and store it in t0.
Then it bne the next variables. Since these are not equal it should skip the next line and go to SLT the last pair of variables. Then it jumps to end and stays in the end loop until the program is stopped.

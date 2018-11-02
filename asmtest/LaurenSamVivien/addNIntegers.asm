addi $a0, $zero, 10 #n
addi $t0, $zero, 0 #num
addi $t1, $zero, 0 #sum


add $a0, $a0, 1
IF:
beq $t0, $a0, ENDIF
add $t1, $t1, $t0
add $t0, $t0, 1
j IF

ENDIF:
add $v0, $t1, 0


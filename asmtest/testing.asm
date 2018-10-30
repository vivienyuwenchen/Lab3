main:
addi $t1, $zero, 3
addi $t2, $zero, 7

addi $t3, $zero, -5
addi $t4, $zero, 10

addi $t5, $zero, -14
addi $t6, $zero, -9

slt $t0, $t1, $t2
bne $t3, $t4, branchtaken
slt $t0, $t3, $t4
j end
branchtaken:
slt $t0, $t5, $t6
j end

end:
j end

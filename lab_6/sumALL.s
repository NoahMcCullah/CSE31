	.data
strPos:	.asciiz "\nSum of positive numbers is:\n"
strNeg:	.asciiz "\nSum of negative numbers is:\n"

	.text
	addi $s0, $zero, 1
while:	beq $s0, $zero, print	#while input != 0, if 0, jump to calc
	li $v0, 5 		#read integer
	syscall
	add $s0, $zero, $v0	#store read int in $s0
	bgt $s0, $zero, posInput	#else if input>0, go to posInput
	blt $s0, $zero, negInput	#else if input<0, go to negInput
return:	j while		#jump back to while

posInput:
	addi $s1, $s1, 1	#increment posCounter
	add $s2, $s2, $s0	#add input to posSum
	j return

negInput:
	addi $s3, $s3, 1	#increment negCounter
	add $s4, $s4, $s0	#add input to negSum
	j return

print:
	#print posAve
	li $v0, 4
	la $a0, strPos
	syscall
	li $v0, 1
	addi $a0, $s2, 0
	syscall
	#print negAve
	li $v0, 4
	la $a0, strNeg
	syscall
	li $v0, 1
	addi $a0, $s4, 0
	syscall
	j finish	#jump to finish

finish:
	li $v0, 10
	syscall


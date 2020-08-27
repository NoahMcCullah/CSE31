	.data
n:      .word 25
str1:	.asciiz "Less than\n"
str2:	.asciiz "Less than or equal to\n"
str3:	.asciiz "Greater than\n"
str4:	.asciiz "Greater than or equal to\n"

	.text
	#Read integer
	li $v0, 5 #code to read integer passed to $v0
	syscall
	add $s0, $zero, $v0 #store read int in $s0
		
	#access n
	la      $s1, n
	lw      $s1, 0($s1)
	
ltCheck:	#branches
	#blt $s0, $s1, lessThan
	slt $at, $s0, $s1
	bne $at, $zero, lessThan		#if usr < n, go the lessThan
gteCheck:	
	#bge $s0, $s1, greaterThanEqual
	slt $at, $s0, $s1
	beq $at, $zero, greaterThanEqual	#if usr >= n, go the greaterThanEqual
gtCheck:
	#bgt $s0, $s1, greaterThan
	slt $at, $s1, $s0
	bne $at, $zero, greaterThan	#if usr > n, go the greaterThan
lteCheck:
	#ble $s0, $s1, lessThanEqual
	slt $at, $s1, $s0
	beq $at, $zero, lessThanEqual	#if usr <= n, go the lessThanEqual
	j exit
	
lessThan:
	li $v0, 4
	la $a0, str1
	syscall
	j gteCheck
greaterThanEqual:
	li $v0, 4
	la $a0, str4
	syscall
	j gtCheck
greaterThan:
	li $v0, 4
	la $a0, str3
	syscall
	j lteCheck
lessThanEqual:
	li $v0, 4
	la $a0, str2
	syscall
	j exit
exit:
	li      $v0,10                  # syscall to end the program
    	syscall	

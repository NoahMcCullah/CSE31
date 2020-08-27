		.data
x:		.word 5
y:		.word 10

		.text
MAIN:		#int x=5, y=10
		la $t0, x
		lw $s0, 0($t0)	# s0 = x
		la $t0, y
		lw $s1, 0($t0)	# s1 = y
		#y = y + x + sum(x, y);
		add $a0, $zero, $s0	#sum(x, y)
		add $a1, $zero, $s1
		jal SUM
		lw $s0, 0($sp)
		lw $s1, 4($sp)
		add $s1, $zero, $v1
		addi $sp, $sp, 8
		add $a0, $zero, $s1
		addi $v0, $zero, 1
		syscall
		j END
		
		
SUM:		# input x = int m, y = int n
		addi $sp, $sp, -12	#move stack pointer 
		sw $ra, 8($sp)		#store return to main
		sw $a0, 0($sp)
		add $t0, $zero, $s0		#store x in $t0
		sw $a1, 4($sp)
		add $t1, $zero, $s1		#store y in $t1
		# int p = sub(n+1, m+1)
		addi $a0, $t1, 1
		addi $a1, $t0, 1
		jal SUB
		add $s0, $zero, $v0	#p = s0 = return of SUB
		#int q = sub(m-1, n-1)
		subi $a0, $t0, 1
		subi $a1, $t1, 1
		jal SUB
		add $s1, $zero, $v0	#q = s1 = return of SUB
		add $v1, $s0, $s1	#return p + q
		lw $ra, 8($sp)
		addi $sp, $sp, 4
		jr $ra

SUB:		#input int a, int b
		sub $v0, $a1, $a0
		jr $ra
		
END:		li $v0, 10
		syscall
		
		
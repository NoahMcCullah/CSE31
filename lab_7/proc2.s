		.data
x:		.word 5
y:		.word 10
m:		.word 15
b:		.word 2

		.text
MAIN:	la $t0, x
		lw $s0, 0($t0)	# s0 = x
		la $t0, y
		lw $s1, 0($t0) 	# s1 = y
		
		# Prepare to call sum(x)
		add $a0, $zero, $s0	# Set a0 as input argument for SUM
		jal SUM
		add $t0, $s1, $s3
		add $s1, $t0, $v0
		addi $a0, $s1, 0 
		li $v0, 1		 
		syscall	
		j END

		
SUM: 	la $t0, m
		addi $sp, $sp, -8
		sw $ra, 0($sp)
		sw $a0, 4($sp)		#stores return to MAIN 
		lw $s2, 0($t0)		# s1 = m
		lw $t3, 4($sp)		#x = n = 4($sp) = $t3
		add $a0, $s2, $t3	# Update a0 as new argument for SUB
		jal SUB
		add $v0, $v0, $t3
		add $s3, $zero, $t3
		lw $ra, 0($sp)
		addi $sp, $sp, 8
		jr $ra		
		
SUB:	la $t0, b
		addi $sp, $sp -4
		sw $s2, 8($sp)		# Backup s0 from SUM
		lw $s0, 0($t0)		# s0 = b
		sub $v0, $a0, $s0	#return $a0-$s0
		lw $s0, 8($sp)		# Restore s0 from SUM
		addi $sp, $sp 4
		jr $ra

		
END:

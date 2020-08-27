       .data
plsEnter:	.asciiz "\nPlease enter a number: "

        .text
main: 		addi	 $sp, $sp, -4		# Moving stack pointer to make room for storing local variables (push the stack frame)
		la	$a0, plsEnter
		li	$v0, 4			#print string
		syscall
		li	$v0, 5			
		syscall				#read integer
		addi	$a0, $v0, 0		#a0 = x
		jal recursion			# Call recursion(x)
		move	$a0, $v0
		li	$v0, 1
		syscall
		j end				# Jump to end of program
		
recursion:	addi	$sp, $sp, -12		# Push stack frame for local storage
		sw	$ra, 12($sp)		#save return to 0($sp)
		#################################
		addi	$t0, $a0, 1		#$t0 = 10
		bne	$a0, $t0, not_negative_one	#if(x+1 == 0) //if(x == -1)
		addi	$v0, $zero, 1		#return 1
		#################################
		j	end_recur		#jump to end_recur
		
not_negative_one:
		bne	$a0, $zero, not_zero	#if(x == 0)
		addi	$v0, $zero, 3		#return 3
		#################################
		j	end_recur		#jump to end_recur
		
not_zero:	sw	$a0, 8($sp) 		#store current input m to memory
		#################################
		addi	$a0, $a0, -2
		jal	recursion		# Call recursion(m + 2)
		#################################
		sw	$v0, 4($sp)
		lw	$t0, 8($sp)
		addi	$a0, $t0, -1
		jal recursion			# Call recursion(m + 1)
		#################################
		sw	$v0, 8($sp)
		lw	$t0, 4($sp)
		add	$v0, $v0, $t0
		#################################
		j end_recur			#jump to end_recur
		
end_recur:	lw	$ra, 12($sp)		#$ra = return to main
		addi	$sp, $sp, 12		# Pop stack frame 
		jr	$ra			#return to main
		
end:		addi	$sp, $sp 4	# Moving stack pointer back (pop the stack frame)
		li	$v0, 10 
		syscall
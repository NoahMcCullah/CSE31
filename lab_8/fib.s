        .data
#n:      .word 13
plsEnter:	.asciiz "\nPlease enter a number: "

        .text
main: 	la	$a0, plsEnter			#load string plsEnter
		li	$v0, 4			
		syscall				#print string
		li	$v0, 5			
		syscall				#read integer
		addi	$t3, $v0, 0
		add     $t0, $0, $zero		#$t0 = 0
		addi    $t1, $zero, 1		#$t1 = 1
		#la      $t3, n			
		#lw      $t3, 0($t3)		
						#$t3 is the index of the fibonnacci sequence
fib: 	beq     $t3, $0, finish			#while($t3 != 0), else jump to finish
		add     $t2,$t1,$t0		#$t2 = $t1 + $t0
		move    $t0, $t1		#$t0 = $t1, add $t0, $zero, $t1
		move    $t1, $t2		#$t1 = $t2
		subi    $t3, $t3, 1		#$t3-1
		j       fib			#loop
		
finish: addi    $a0, $t0, 0			#$a0 = $t0
		li      $v0, 1			#$v0 = 1
		syscall				#print final number
		li      $v0, 10			#$v0 = 10
		syscall				#exit


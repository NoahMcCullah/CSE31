.data 

original_list: .space 100 
sorted_list: .space 100

str0: .asciiz "Enter size of list (between 1 and 25): "
str1: .asciiz "Enter one list element: \n"
str2: .asciiz "\nContent of original list: "
str3: .asciiz "\nEnter a key to search for: "
str4: .asciiz "\nContent of sorted list: "
strYes: .asciiz "Key found!"
strNo: .asciiz "Key not found!"



.text 

#This is the main program.
#It first asks user to enter the size of a list.
#It then asks user to input the elements of the list, one at a time.
#It then calls printList to print out content of the list.
#It then calls inSort to perform insertion sort
#It then asks user to enter a search key and calls bSearch on the sorted list.
#It then prints out search result based on return value of bSearch
main: 
	addi $sp, $sp -8
	sw $ra, 0($sp)
	li $v0, 4 
	la $a0, str0 
	syscall 
	li $v0, 5	#read size of list from user
	syscall
	move $s0, $v0
	move $t0, $0
	la $s1, original_list
loop_in:
	li $v0, 4 
	la $a0, str1 
	syscall 
	sll $t1, $t0, 2
	add $t1, $t1, $s1
	li $v0, 5	#read elements from user
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	bne $t0, $s0, loop_in
	move $a0, $s1
	move $a1, $s0
	
	jal inSort	#Call inSort to perform insertion sort in original list
	
	sw $v0, 4($sp)
	li $v0, 4 
	la $a0, str2 
	syscall 
	la $a0, original_list
	move $a1, $s0
	jal printList	#Print original list
	li $v0, 4 
	la $a0, str4 
	syscall 
	lw $a0, 4($sp)
	jal printList	#Print sorted list
	
	li $v0, 4 
	la $a0, str3 
	syscall 
	li $v0, 5	#read search key from user
	syscall
	move $a3, $v0
	lw $a0, 4($sp)
	jal bSearch	#call bSearch to perform binary search
	
	beq $v0, $0, notFound
	li $v0, 4 
	la $a0, strYes 
	syscall 
	j end
	
notFound:
	li $v0, 4 
	la $a0, strNo 
	syscall 
end:
	lw $ra, 0($sp)
	addi $sp, $sp 8
	li $v0, 10 
	syscall
	
	
#printList takes in a list and its size as arguments. 
#It prints all the elements in one line.
printList:
	#Your implementation of printList here	
	move	$t0, $a0		#arrayPointer = t0
	move	$t1, $a1		#size = t1
	add	$t2, $zero, $zero	#loopCounter = t2 = 0
	
	print_loop:					#print by traversing array
		bge	$t2, $t1, print_loop_end	#while(loopCounter < size)
		mul	$t3, $t2, 4			#loopCounter * 4
		add	$t0, $t0, $t3			#arr[loopCounter*4]
		lw	$a0, ($t0)			#print 4*ith value of array
		li	$v0, 1
		syscall
		
		addi	$t2, $t2, 1	#increment loopCounter
		j	print_loop
		
	print_loop_end:
		jr 	$ra
	
	
#inSort takes in a list and it size as arguments. 
#It performs INSERTION sort in ascending order and returns a new sorted list
#You may use the pre-defined sorted_list to store the result
inSort:
	#Your implementation of inSort here
	move	$t0, $a0		#$t0 = $a0 = original_list address
	move	$t1, $a1		#$t1 = $a1 = size
	la	$t2, sorted_list	#$t2 = sorted_list address

	addi	$t3, $zero, 0	#$t3 = i = 0	
	fill_sorted_list:
		bge	$t3, $t1, after_fill	# for(int i = 0; i < size; i++)
		mul	$t4, $t3, 4
		add	$t4, $t4, $t0		# $t4 = &orgArr[i]
		lw	$t4, ($t4)		# $t4 = orgArr[i]
		mul	$t5, $t3, 4
		add	$t5, $t5, $t2		# $t5 = &sortArr[i]
		sw	$t4, ($t5)		# sortArr[i] = orgArr[i]
		addi	$t3, $t3, 1		#i++
		j	fill_sorted_list
	after_fill:
	addi	$t3, $zero, 1	#$t3 = i = 1
	
	outer_loop:
		bge	$t3, $t1, after_outer_loop	#for(int i = 1; i < size; i++)
		mul	$t4, $t3, 4			# i * 4
		add	$t4, $t2, $t4			#$t4 = &sortArr[i]
		lw	$t4, ($t4)			#$t4 = key = sortArr[i]
		addi	$t5, $t3, -1			#$t5 = j = i - 1
		
		inner_loop:
			blt	$t5, $zero, after_inner_loop	#while(j >= 0 && sortArr[j] > key)
			mul	$t6, $t5, 4			# j * 4
			add	$t6, $t2, $t6			#$t6 = &sortArr[j]
			lw	$t6, ($t6)			#$t6 = sortArr[j]
			bge	$t6, $t4, after_inner_loop
			addi	$t7, $t5, 1			#$t7 = j + 1
			mul	$t7, $t7, 4			#(j+1) * 4
			add	$t7, $t2, $t7			#$t7 = &sortArr[j+1]
			sw	$t6, ($t7)			#sortArr[j+1] = sortArr[j]
			addi	$t5, $t5, -1			#j = j - 1
			j	inner_loop
		after_inner_loop:
		addi	$t7, $t5, 1			#$t7 = j + 1
		mul	$t7, $t7, 4			#(j+1) * 4
		add	$t7, $t2, $t7			#$t7 = &sortArr[j+1]
		sw	$t4, ($t7)			#sortArr[j+1] = key
		addi	$t3, $t3, 1			#i++
		j	outer_loop
	after_outer_loop:
	add	$v0, $zero, $t2		#$v0 = &sortArr
	jr	$ra
	
	
#bSearch takes in a list, its size, and a search key as arguments.
#It performs binary search RECURSIVELY to look for the search key.
#It will return a 1 if the key is found, or a 0 otherwise.
#Note: you MUST NOT use iterative approach in this function.
bSearch:
	#Your implementation of bSearch here
	move	$t0, $a0		#$t0 = $a0 = &sortArr
	move	$t1, $a1		#$t1 = $a1 = size
	move	$t2, $a3		#$t2 = $a3 = key
	add	$t3, $zero, $zero	#$t3 = left = 0
	addi	$t4, $t1, -1		#$t4 = size - 1 = right
	
	search_loop:
		addi	$sp, $sp, -4
		sw	$ra, 0($sp)		#save $ra to memory
		blt	$t4, $t3, key_not_found	#if(right >= left)
			addi	$t5, $t4, -1		#$t5 = right - 1
			add	$t5, $t5, $t3		#$t5 = left + (right - 1)
			div	$t5, $t5, 2		#$t5 = (left + (right - 1)) / 2 = mid
			mul	$t6, $t5, 4		# mid * 4
			add	$t6, $t0, $t6		# &sortArr[mid]
			lw	$t6, ($t6)		# sortArr[mid]
			bne	$t6, $t2, search_left
				j	key_found
			search_left:
				bge	$t6, $t2, search_right
					addi	$t4, $t5, -1
					j	search_loop
			search_right:
				addi	$t3, $t5, 1
				j	search_loop
	key_not_found:
		add	$v0, $zero, $zero
		j	after_search
	key_found:
		addi	$v0, $zero, 1
		j	after_search
	after_search:
		lw	$ra, 0($sp)
		addi	$sp, $sp, 4
		jr	$ra
	

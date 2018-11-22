		.text
		j	bootstrap			

		.data
string1:		.asciiz "Enter Array Size: \n"
string2:		.asciiz "Add element:  \n"
string3:		.asciiz "Sorted Array: \n"
string4:		.asciiz " "

		.text
		.globl	bootstrap 
bootstrap: 
		la	$a0, string1		
		li	$v0, 4			
		syscall				

		li	$v0, 5			
		syscall				
		move	$s2, $v0		
		sll	$s0, $v0, 2		
		sub	$sp, $sp, $s0		
		la	$a0, string2		
		li	$v0, 4			
		syscall				

		move	$s1, $zero		
loop_get:	bge	$s1, $s2, exit_get	
		sll	$t0, $s1, 2		
		add	$t1, $t0, $sp		
		li	$v0, 5			
		syscall				
		sw	$v0, 0($t1)		
						
		la	$a0, string4
		li	$v0, 4
		syscall
		addi	$s1, $s1, 1		
		j	loop_get
exit_get:	move	$a0, $sp		
		move	$a1, $s2		
		jal	startselection_sort			
						
						
		la	$a0, string3		
		li	$v0, 4
		syscall

		move	$s1, $zero		
loop_print:	bge	$s1, $s2, exit_print	
		sll	$t0, $s1, 2		
		add	$t1, $sp, $t0		
		lw	$a0, 0($t1)		
		li	$v0, 1			
		syscall				

		la	$a0, string4
		li	$v0, 4
		syscall
		addi	$s1, $s1, 1		
		j	loop_print
exit_print:	add	$sp, $sp, $s0		 
              
		li	$v0, 10			
		syscall			
		
		

startselection_sort:		addi	$sp, $sp, -20		
		sw	$ra, 0($sp)
		sw	$s0, 4($sp)
		sw	$s1, 8($sp)
		sw	$s2, 12($sp)
		sw	$s3, 16($sp)

		move 	$s0, $a0		
		move	$s1, $zero		

		subi	$s2, $a1, 1	
startselection_sort_loop:	bge 	$s1, $s2, startselection_sort_exit	
		
		move	$a0, $s0	
		move	$a1, $s1	
		move	$a2, $s2		
		
		jal	index_minimum
		move	$s3, $v0		
		
		move	$a0, $s0		
		move	$a1, $s1		
		move	$a2, $s3		
		
		jal	swap

		addi	$s1, $s1, 1		
		j	startselection_sort_loop		
		
startselection_sort_exit:	lw	$ra, 0($sp)		
		lw	$s0, 4($sp)
		lw	$s1, 8($sp)
		lw	$s2, 12($sp)
		lw	$s3, 16($sp)
		addi	$sp, $sp, 20		
		jr	$ra			



index_minimum:		move	$t0, $a0		
		move	$t1, $a1		
		move	$t2, $a2		
		
		sll	$t3, $t1, 2		
		add	$t3, $t3, $t0				
		lw	$t4, 0($t3)		
		
		addi	$t5, $t1, 1		
index_minimum_loop:	bgt	$t5, $t2, index_minimum_end	

		sll	$t6, $t5, 2		
		add	$t6, $t6, $t0			
		lw	$t7, 0($t6)		

		bge	$t7, $t4, index_minimum_if_exit	
		
		move	$t1, $t5		
		move	$t4, $t7	

index_minimum_if_exit:	addi	$t5, $t5, 1		
		j	index_minimum_loop

index_minimum_end:	move 	$v0, $t1		
		jr	$ra



swap:		sll	$t1, $a1, 2		
		add	$t1, $a0, $t1		
		
		sll	$t2, $a2, 2		
		add	$t2, $a0, $t2		

		lw	$t0, 0($t1)		
		lw	$t3, 0($t2)		

		sw	$t3, 0($t1)		
		sw	$t0, 0($t2)		

		jr	$ra
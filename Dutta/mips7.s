.data
	Arr:	.word 1, 4, 9, 15, 15, 21
	size:	.word 6
	inp:	.asciiz "Please enter the number to search in the array : "
	F:	.asciiz "Number found! Lowest indes is : "
	notF:	.asciiz "Number not found in the array"
.text
.globl main
.ent main

main:
	la $t0, Arr
	li $t7, -1

	la $a0, inp
	li $v0, 4
	syscall	

	li $v0, 5
	syscall
	

	li $t1, 0
	lw $t2, size
	li $t4, 2
	addi $t2, $t2, -1
	
	
	binSearch:
		la $t0, Arr
		#syscall
		bgt $t1, $t2, Print
		add $t3, $t1, $t2
		div $t3, $t4
		mflo $t3
		sll $t6,$t3,2
		add $t0, $t0, $t6
		lw $t5, 0($t0)
		bne $t5, $v0, Cont
		beq $t3, $zero, NoLeft
		addi $t0, $t0, -4		
		lw $t6, 0($t0)
		beq $t5, $t6, Cont
		NoLeft:
		move $t7, $t3
		j Print
		Cont:
		blt $t5, $v0, Right
		addi $t2,$t3,-1
		j binSearch
		Right:
		addi $t1, $t3, 1
		j binSearch
		

	Print:
		li $a0,-1
		beq $t7, $a0, NotFound
		la $a0, F
		li $v0, 4
		syscall
		move $a0, $t7
		li $v0, 1
		syscall
		j Exit
		NotFound:
		li $v0, 4
		la $a0, notF
		syscall

	Exit:

	li $v0,10
	syscall
.end main


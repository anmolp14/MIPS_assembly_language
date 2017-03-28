.data
	myWord:	.space 100
.text
.globl main

main:
	la $a0, myWord
	li $a1, 100
	li $v0, 8
	syscall


	li $t0, 0
	Loop:
		add $t3, $a0, $t0
		lbu $t1, 0($t3)
		beq $t1, $zero, EXIT		
		slti $t2, $t1, 97
		bne $t2, $zero, L1
		slti $t2, $t1, 123
		beq $t2, $zero, L1 
		addi $t1, $t1, -32
		sb $t1, 0($t3)
		L1:
			addi $t0, $t0, 1
		j Loop
	EXIT:
	
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall


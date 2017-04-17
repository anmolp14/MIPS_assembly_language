.data
.text

.globl main
main:
	li $v0 5
	syscall
	move $t0 $v0
	li $v0 5
	syscall
	move $t1 $v0
	move $t2 $v0
	move $t3 $v0
	move $t4 $v0
	li $t5 1
	loop: 
		li $v0 5
		syscall
		
		max: 
			ble $v0 $t2 min 
			blt $v0 $t1 repm2
			move $t2 $t1
			move $t1 $v0 
			j min
			repm2:
				move $t2 $v0  
		min:
			bge $v0 $t4 nd
			bgt $v0 $t3 repmi2
			move $t4 $t3
			move $t3 $v0
			j nd
			repmi2:
				move $t4 $v0 
		nd:
			add $t5 $t5 1
			blt $t5 $t0 loop
	move $a0 $t4 
	li $v0 1
	syscall 
	move $a0 $t2 
	li $v0 1
	syscall 
	
	li $v0 10
	syscall
.end main


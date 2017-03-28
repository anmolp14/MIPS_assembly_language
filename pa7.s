.data 

Array: .word  1 2 3 4 5 6 7 8 
Size:  .word  8
sFound: .asciiz "Number found. Index of array is : "
sNotFound: .asciiz "No number in array matches the given number."
sInput:  .asciiz  "Please input number to be found : "
.text

.globl main
main: 	la $a0, sInput
	li $v0, 4
	syscall  	#input prompt
	li $v0 5	#input       
	syscall		#input
	la $t0 Array	#array address
	move $t1 $0       #initial left index
	lw $t2 Size	#initial right index + 1
	add $t2 $t2 -1  #initial right index
	loop:
		add $t3 $t1 $t2 
		divu $t3 $t3 2		#mid index
		mul $t4 $t3 4		
		add $t4 $t4 $t0		#address of mid index
                lw $t4 ($t4)		#value of mid index     
		beq $t4 $v0 Found
		blt $t4 $v0 LessThan
                add $t3 $t3 -1  
		move $t2 $t3
		j end
		LessThan: 
			add $t3 $t3 1
			move $t1 $t3
			j end
		Found: 
			la $a0 sFound
			li $v0 4
			syscall	
			move $a0 $t3
			li $v0 1
			syscall
			j term
		end:
			ble $t1 $t2 loop
	la $a0 sNotFound 
	li $v0 4
	syscall				  
	term:
		li $v0 10 
		syscall		
.end main

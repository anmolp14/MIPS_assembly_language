.data
Farray  .space  20


.text
.globl Fibb
Fibb:
	



.end Fibb
.globl main
main:
	li $v0 5
	syscall
	move $a0 $v0
	jal Fibb
	li $v0 10
	syscall
.end main


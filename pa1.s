.data
x: .space  4
y: .space  4

.text
.globl main
.ent main
main:
  li $v0  5
  syscall
  sw $v0  x  
  li $v0  5
  syscall
  sw $v0  y 
  lw $a0 x
  lw $a1 y 
  jal func		 
  move $a0 $v0
  li $v0 1
  syscall 
  li $v0  10
  syscall
.end main
.globl func
.ent func
func: 
   subu $sp $sp 4
   sw $s0 ($sp)
   mul $t0 $a0 -5
   mul $t1 $a1 -7
   add $s0 $t0 $t1
   bge $s0 -35 sec
   li $v0 -35
   j end 
sec: 
   ble $s0 35 last
   li $v0 35
   j end 
last:
   move $v0 $s0 
end:
   lw $s0 ($sp)
   add $sp $sp 4 
   jr $ra
.end func     

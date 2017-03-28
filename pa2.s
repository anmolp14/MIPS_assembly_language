.data

.text
.globl main
.ent main
main:

loop: 
   li $v0 12
   syscall
   sub $sp $sp 1
   beq $v0 $zero print
   bge $v0 65 cond1
   j end
cond1:
   ble $v0 90 cond2
   j end
cond2:
   add $v0 $v0 32 
end:
   sb  $v0 ($sp)
   j loop
print:
   sub $fp $fp 1
   li $v0 11
   lb $a0 ($fp)  
   syscall
   beq $fp $sp print 
   li $v0 10
   syscall
.end main





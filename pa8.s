.data
MdArray1: .double  1.23434 2.33443  9.039493 12.3432   3.45546
          .double  4.2349  2.45534  6.353453  5.34534  6.08973 
          .double  6.23525 2.24234  4.42342   5.23524  7.34345
          .double  5.30943 9.234234 2.34423   4.34923  3.4351

MdArray2: .double   5.23466 4.38843  6.034443 
          .double   6.2019  1.45537  7.351413 
          .double   0.23544 7.27814  2.53302  
          .double   4.35945 5.334238 8.30420  
	  .double   2.34432 5.2826   5.2740   
M1RowSize:  	 .word    4
M1ColM2RowSize:  .word    5
M2ColSize:	 .word    3

ResMat:  .space  10000


.text
.globl main
.ent main
main:
    la $t0 MdArray1  		#address of 1st array 
    la $s1 MdArray2  		#"         "2nd"    "  
    la $t9 ResMat
    lw $t2 M1RowSize 		#No of rows in 1st array also temporary variable for outer loop goes from [RowSize] - [1] 
    lw $t3 M1ColM2RowSize  	#"    "columns"        " 	 	
    lw $t4 M2ColSize   		#matrix 2 col size 
    mul $s0 $t3 8
    mul $s2 $t4 8	
    	
	loop1:
		
    		move $t5 $0    		#temporary variable for middle loop goes from [0] - [colsize-1]  
		move $t1 $s1 
		loop2:	
			li.d  $f12 0.0
		      	move $t7 $t0    
    		      	move $t8 $t1    	
    			move $t6 $0			#temp var for innermost loop
			loop3:			
			
				l.d $f0 ($t7)
				l.d $f2 ($t8)
				mul.d $f4 $f0 $f2 
				add.d $f12 $f12 $f4 
				add $t8 $t8 $s2
				add $t7 $t7 8
				add $t6 $t6 1
				blt $t6 $t3 loop3
		
			s.d $f12 ($t9)
			li $v0 3 
			syscall  
    	                li $a0 32
			li $v0 11
			syscall
	
	    		add $t9 $t9 8
			add $t1 $t1 8
			add $t5 $t5 1 
			blt $t5 $t4 loop2
		li $a0 10
		li $v0 11
	        syscall 
		add $t0 $t0 $s0
		add $t2 $t2 -1
		bgt $t2 $0 loop1			    				 
    li $v0 10
    syscall				
.end main


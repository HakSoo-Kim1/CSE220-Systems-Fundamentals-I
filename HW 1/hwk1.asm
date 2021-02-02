# Hak Soo Kim
# Haksokim
# 111045936

.data
# Command-line arguments
num_args: .word 0
addr_arg0: .word 0
addr_arg1: .word 0
addr_arg2: .word 0
addr_arg3: .word 0
addr_arg4: .word 0
addr_arg5: .word 0
addr_arg6: .word 0
addr_arg7: .word 0
no_args: .asciiz "You must provide at least one command-line argument.\n"

# Output messages
big_bobtail_str: .asciiz "BIG_BOBTAIL\n"
full_house_str: .asciiz "FULL_HOUSE\n"
five_and_dime_str: .asciiz "FIVE_AND_DIME\n"
skeet_str: .asciiz "SKEET\n"
blaze_str: .asciiz "BLAZE\n"
high_card_str: .asciiz "HIGH_CARD\n"

# Error messages
invalid_operation_error: .asciiz "INVALID_OPERATION\n"
invalid_args_error: .asciiz "INVALID_ARGS\n"

# Put your additional .data declarations here, if any.

# Main program starts here
.text
.globl main
main:
    # Do not modify any of the code before the label named "start_coding_here"
    # Begin: save command-line arguments to main memory
    sw $a0, num_args
    beqz $a0, zero_args
    li $t0, 1
    beq $a0, $t0, one_arg
    li $t0, 2
    beq $a0, $t0, two_args
    li $t0, 3
    beq $a0, $t0, three_args
    li $t0, 4
    beq $a0, $t0, four_args
    li $t0, 5
    beq $a0, $t0, five_args
    li $t0, 6
    beq $a0, $t0, six_args
seven_args:
    lw $t0, 24($a1)
    sw $t0, addr_arg6
six_args:
    lw $t0, 20($a1)
    sw $t0, addr_arg5
five_args:
    lw $t0, 16($a1)
    sw $t0, addr_arg4
four_args:
    lw $t0, 12($a1)
    sw $t0, addr_arg3
three_args:
    lw $t0, 8($a1)
    sw $t0, addr_arg2
two_args:
    lw $t0, 4($a1)
    sw $t0, addr_arg1
one_arg:
    lw $t0, 0($a1)
    sw $t0, addr_arg0
    j start_coding_here

zero_args:
    la $a0, no_args
    li $v0, 4
    syscall
    j exit
    # End: save command-line arguments to main memory

start_coding_here:
    # Start the assignment by writing your code here
    
    ## first argument switch
     lw $t0, addr_arg0 		# t0 contains address of first argument
     					# check if letter is not one character
    	li $t1,0			# t1 = 0	
     	lb $t2, 1($t0)			# t2 = t0 + 1
     	bne $t1, $t2, invalid_operation_error_exit	# if t2 != 0 branch to invalid_operation_error_exit
     
     lb $s0, 0($t0)							# s0 contains first argument
# case 1
   	case1: 								# if first argument is 1
    	li $t0, 49							# t0 contains ASCII code of 1
    	bne $s0, $t0, case2						# if first argument != 1 go to case2
    		lw $s7 , num_args  					## s7 = num_args
    		li $t1, 3				## t1 = 3
    		bne $s7, $t1, invalid_args_error_exit 			## if s7 != 3 go to invalid_args_error_exit
		add  $s1, $0, $0 						# s1 = 0     # integer value will be here 
		lw $t2, addr_arg1 				# t2 has second argument address
		li $t0, 0			# t0 = 0 (counter)
		li $t1, 4			
		_1_for_loop_fourletter:
		lbu $t4, 0($t2) 						#t4 has each character of argument
		li $t3, 48							# t3 has ASCII of 1
		blt $t4, $t3, invalid_args_error_exit  				#branch if $s1 is less than 0 (48), means below 48 - error
		li $t3, 57							# t3 has ASCII of 9
		bleu $t4,$t3, _1_between_0_and_9	 				## branch if  first argument letter <= 9 (57)
		li $t3, 65							# t3 has ASCII of A
		blt $t4,$t3, invalid_args_error_exit				#branch if $t1 is lessthan A (65)
		li $t3, 70							# t3 has ASCII of F
		bleu $t4,$t3, _1_between_A_and_F 					## branch if first argument letter <= F (70)
		j invalid_args_error_exit					# rest of them will be error
			_1_between_0_and_9: 	## char is between 0 and 9
			addi $t4,$t4,-48	 #make it int by - 48
			add $s1,$s1,$t4		#add letter value to $s1
			addi $t0,$t0,1		# counter + 1
			addi $t2,$t2,1		# move letter up
			beq $t0,$t1, _1_finally_integer
			
			sll $s1,$s1,4 # move left 4 

			j _1_for_loop_fourletter
	
		_1_between_A_and_F: ## char is between A and F
		addi $t4,$t4, -55 # make it int 
		add $s1,$s1,$t4
		addi $t0,$t0,1		# counter + 1
		addi $t2,$t2,1		# move letter up
		beq $t0,$t1,_1_finally_integer
		sll $s1,$s1,4
		j _1_for_loop_fourletter
	

		_1_finally_integer:
		# s1 has integer value with given strings_1
    		## one' complement to two's complement
    		li $t1, 32768 					# t1 = 32768
    		andi $t2, $s1, 32768				#And bit s1 with 32768
    		bne $t1, $t2, _1_one_complement_two_complement 	#if t1 != $t1, means positive, branch  
    		addi $s1,$s1,1					# negative one's  + 1  = negative two's  
    	# two's complement
    	# now check third argument
    		_1_one_complement_two_complement: 			# finally two complement, starting checking if 3rd valid
    		lw $t0, addr_arg2 				#t0 has address of arg2					
		lbu $t1, 0($t0)					#t1 has 1st letter arg3
		lbu $t2, 1($t0)					#t2 has 2nd letter arg3
		li $t3,10					# t3 = 10
		addi $t1, $t1, -48				# t1 = t1 - 48
		addi $t2, $t2,  -48				# t2 = t2 - 48
		li $t3,10					# t3 = 10
		add $s2, $0, $0
		mul $s2,$t1,$t3					# s2 = t1 * t3
		add $s2,$s2,$t2					# s2 = s3 + t2
		li $t1, 16					# t1 = 16
		blt $s2,$t1, invalid_args_error_exit		# if s2 < 16 , branch
		li $t1, 32					# t1 = 32
		bgt $s2, $t1, invalid_args_error_exit		# if s2 > 32 ,branch 
	# s2 is  valid 3rd arg, int
	# start printing 
		#check positive or negative
		li $t1, 32768					# t1 = 2^15 
		and $t2, $s1, $t1				# 2^15 and s1
		beq $t2,$t1, _1_negative				# t1 == t2, branch 
		li $t1, -16					# t1 = 16
		add $t2, $s2, $t1				# t2 = s2 + t1     t2 = 3rd arg - 16
		li $t3, 0					# t3(counter) = 0
		_1_for_loop_printing_positive_sign_extension:		
		beq $t3, $t2, _1_done_printing_sign_extension	# if t3 == t2, brnach
		li $a0, 0 					# a0 = 0
		li $v0, 1					# v0 = 1
		syscall						# print 1
		addi $t3,$t3,1					# t3 (counter) = t3 + 1
		j _1_for_loop_printing_positive_sign_extension
		
		_1_negative: 
		li $t1, -16					# t1 = 16
		add $t2, $s2, $t1				# t2 = s2 + t1     t2 = 3rd arg - 16
		li $t3, 0					# t3(counter) = 0
		_1_for_loop_printing_negative_sign_extension:		
		beq $t3, $t2, _1_done_printing_sign_extension	# if t3 == t2, brnach
		li $a0, 1 					# a0 = 1
		li $v0, 1					# v0 = 0
		syscall						# print 0
		addi $t3,$t3,1					# t3 (counter) = t3 + 1
		j _1_for_loop_printing_negative_sign_extension
		_1_done_printing_sign_extension:
	# start printing real number
		li $t1 , 32768					#t1 = 32768 (2^15)
		li $t2, 0					#t2 = 0
		li $t3, 2					#t3 = 2
		_1_for_loop_printing_number:
		and $t4, $s1, $t1				# t4 = $s1 and $t1
		beq $t4, $t1, _1_printing_one			# t4 == t1, branch 	bit in position = 1
		li $a0, 0					# a0 = 0
		syscall						# print 0
		j _1_done_print_onebit				# printed, jump 
		_1_printing_one:					
		li $a0, 1					# a0 = 1
		syscall						# print 1
		_1_done_print_onebit:
		div $t1,$t3				# t1 / t3     t1 /2
		mflo $t1
		beq  $t2, $t1, _1_done_printing		# if t2 == t1 ,branch  (t2 == 0)
		j _1_for_loop_printing_number
		_1_done_printing: 
		li $v0,11					# v0 = 11
		li $a0, '\n'					# a0 = '\n'
		syscall						# printing new line
    	j exit
    	
    	
    	
#case 2	
    case2:
   	li $t0, 50		# t0 conatains ASCII code of 2
    	bne $s0, $t0, caseS	# if first argument != 2 go to caseS
    		lw $s7 , num_args  	## s7 = num_args
    		li $t1, 3		## t1 = 3
    		bne $s7,$t1, invalid_args_error_exit ## if s7 != 3 go to invalid_args_error_exit
    		add  $s1, $0, $0 						# s1 = 0     # integer value will be here 
		lw $t2, addr_arg1 				# t2 has second argument address
		li $t0, 0			# t0 = 0 (counter)
		li $t1, 4			
		_2_for_loop_fourletter:
		lbu $t4, 0($t2) 						#t4 has each character of argument
		li $t3, 48							# t3 has ASCII of 1
		blt $t4, $t3, invalid_args_error_exit  				#branch if $s1 is less than 0 (48), means below 48 - error
		li $t3, 57							# t3 has ASCII of 9
		bleu $t4,$t3, _2_between_0_and_9	 				## branch if  first argument letter <= 9 (57)
		li $t3, 65							# t3 has ASCII of A
		blt $t4,$t3, invalid_args_error_exit				#branch if $t1 is lessthan A (65)
		li $t3, 70							# t3 has ASCII of F
		bleu $t4,$t3, _2_between_A_and_F 					## branch if first argument letter <= F (70)
		j invalid_args_error_exit					# rest of them will be error
			_2_between_0_and_9: 	## char is between 0 and 9
			addi $t4,$t4,-48	 #make it int by - 48
			add $s1,$s1,$t4		#add letter value to $s1
			addi $t0,$t0,1		# counter + 1
			addi $t2,$t2,1		# move letter up
			beq $t0,$t1, _2_finally_integer
			
			sll $s1,$s1,4 # move left 4 

			j _2_for_loop_fourletter
	
		_2_between_A_and_F: ## char is between A and F
		addi $t4,$t4, -55 # make it int 
		add $s1,$s1,$t4
		addi $t0,$t0,1		# counter + 1
		addi $t2,$t2,1		# move letter up
		beq $t0,$t1,_2_finally_integer
		sll $s1,$s1,4
		j _2_for_loop_fourletter
	

		_2_finally_integer:
	# s1 has integer value with given strings_1
    	# two's complement
    	# now check third argument
    		lw $t0, addr_arg2 				#t0 has address of arg2					
		lbu $t1, 0($t0)					#t1 has 1st letter arg3
		lbu $t2, 1($t0)					#t2 has 2nd letter arg3
		li $t3,10					# t3 = 10
		addi $t1, $t1, -48				# t1 = t1 - 48
		addi $t2, $t2,  -48				# t2 = t2 - 48
		li $t3,10					# t3 = 10
		add $s2, $0, $0
		mul $s2,$t1,$t3					# s2 = t1 * t3
		add $s2,$s2,$t2					# s2 = s3 + t2
		li $t1, 16					# t1 = 16
		blt $s2,$t1, invalid_args_error_exit		# if s2 < 16 , branch
		li $t1, 32					# t1 = 32
		bgt $s2, $t1, invalid_args_error_exit		# if s2 > 32 ,branch 
	# s2 is  valid 3rd arg, int
	# start printing 
		#check positive or negative
		li $t1, 32768					# t1 = 2^15 
		and $t2, $s1, $t1				# 2^15 and s1
		beq $t2,$t1, _2_negative				# t1 == t2, branch 
		li $t1, -16					# t1 = 16
		add $t2, $s2, $t1				# t2 = s2 + t1     t2 = 3rd arg - 16
		li $t3, 0					# t3(counter) = 0
		_2_for_loop_printing_positive_sign_extension:		
		beq $t3, $t2, _2_done_printing_sign_extension	# if t3 == t2, brnach
		li $a0, 0 					# a0 = 0
		li $v0, 1					# v0 = 1
		syscall						# print 1
		addi $t3,$t3,1					# t3 (counter) = t3 + 1
		j _2_for_loop_printing_positive_sign_extension
		
		_2_negative: 
		li $t1, -16					# t1 = 16
		add $t2, $s2, $t1				# t2 = s2 + t1     t2 = 3rd arg - 16
		li $t3, 0					# t3(counter) = 0
		_2_for_loop_printing_negative_sign_extension:		
		beq $t3, $t2, _2_done_printing_sign_extension	# if t3 == t2, brnach
		li $a0, 1 					# a0 = 1
		li $v0, 1					# v0 = 0
		syscall						# print 0
		addi $t3,$t3,1					# t3 (counter) = t3 + 1
		j _2_for_loop_printing_negative_sign_extension
		_2_done_printing_sign_extension:
	# start printing real number
		li $t1 , 32768					#t1 = 32768 (2^15)
		li $t2, 0					#t2 = 0
		li $t3, 2					#t3 = 2
		_2_for_loop_printing_number:
		and $t4, $s1, $t1				# t4 = $s1 and $t1
		beq $t4, $t1, _2_printing_one			# t4 == t1, branch 	bit in position = 1
		li $a0, 0					# a0 = 0
		syscall						# print 0
		j _2_done_print_onebit				# printed, jump 
		_2_printing_one:					
		li $a0, 1					# a0 = 1
		syscall						# print 1
		_2_done_print_onebit:
		div $t1,$t3				# t1 / t3     t1 /2
		mflo $t1
		beq  $t2, $t1, _2_done_printing		# if t2 == t1 ,branch  (t2 == 0)
		j _2_for_loop_printing_number
		_2_done_printing: 
		li $v0,11					# v0 = 11
		li $a0, '\n'					# a0 = '\n'
		syscall						# printing new line
    	j exit
    	
    	
    	
    	
    	
    	
    	
    caseS:
    	li $t0, 83		# t0 conatains ASCII code of S
    	bne $s0, $t0, caseF	# if first argument != S go to caseF
		lw $s7 , num_args  					## s7 = num_args
    		li $t1, 3				## t1 = 3
    		bne $s7, $t1, invalid_args_error_exit 			## if s7 != 3 go to invalid_args_error_exit
		add  $s1, $0, $0 						# s1 = 0     # integer value will be here 
		lw $t2, addr_arg1 				# t2 has second argument address
		li $t0, 0			# t0 = 0 (counter)
		li $t1, 4			
		_S_for_loop_fourletter:
		lbu $t4, 0($t2) 						#t4 has each character of argument
		li $t3, 48							# t3 has ASCII of 1
		blt $t4, $t3, invalid_args_error_exit  				#branch if $s1 is less than 0 (48), means below 48 - error
		li $t3, 57							# t3 has ASCII of 9
		bleu $t4,$t3, _S_between_0_and_9	 				## branch if  first argument letter <= 9 (57)
		li $t3, 65							# t3 has ASCII of A
		blt $t4,$t3, invalid_args_error_exit				#branch if $t1 is lessthan A (65)
		li $t3, 70							# t3 has ASCII of F
		bleu $t4,$t3, _S_between_A_and_F 					## branch if first argument letter <= F (70)
		j invalid_args_error_exit					# rest of them will be error
			_S_between_0_and_9: 	## char is between 0 and 9
			addi $t4,$t4,-48	 #make it int by - 48
			add $s1,$s1,$t4		#add letter value to $s1
			addi $t0,$t0,1		# counter + 1
			addi $t2,$t2,1		# move letter up
			beq $t0,$t1, _S_finally_integer
			
			sll $s1,$s1,4 # move left 4 

			j _S_for_loop_fourletter
	
		_S_between_A_and_F: ## char is between A and F
		addi $t4,$t4, -55 # make it int 
		add $s1,$s1,$t4
		addi $t0,$t0,1		# counter + 1
		addi $t2,$t2,1		# move letter up
		beq $t0,$t1,_S_finally_integer
		sll $s1,$s1,4
		j _S_for_loop_fourletter
	

		_S_finally_integer:
		# s1 has integer value with given strings_1
    		## one' complement to two's complement
    		li $t1, 32768 					# t1 = 32768
    		andi $t2, $s1, 32768				#And bit s1 with 32768
    		bne $t1, $t2, _S_singed_to_one_complement_positive	#if t1 != $t1, means positive, branch  
    		xor $t3, $s1, $t2		#t3 = s1 xor t2 (t3 has positive)
    		li $t4 , 32768					#t1 = 32768 (2^15)
		li $t5, 0					#t2 = 0
		li $t6, 2
		add $t7, $0,$0					#t3 = 2
    		_S_forloop_signed_to_ones_:
    		and $t8, $t3, $t4
    		beq $t8,$t4, _S_no_adding
    		add $t7,$t7,$t4
    		_S_no_adding:
    		div $t4,$t6				# t1 / t3     t1 /2
		mflo $t4
		beq  $t4, $t5, _S_singed_to_one_complement_negative
		j _S_forloop_signed_to_ones_				
    	# two's complement
    	# now check third argument
    		_S_singed_to_one_complement_negative: 		# finally two complement, starting checking if 3rd valid
    		move $s1,$t7					#t1 = one's value of given sign binanry value
    		 _S_singed_to_one_complement_positive:
    								## one' complement to two's complement
    		li $t1, 32768 					# t1 = 32768
    		andi $t2, $s1, 32768				#And bit s1 with 32768
    		bne $t1, $t2, _S_one_complement_two_complement 	#if t1 != $t1, means positive, branch  
    		addi $s1,$s1,1					# negative one's  + 1  = negative two's 
    		
    		_S_one_complement_two_complement: # now we have s1 in two's given sign value
    		
    		#move $a0,$s1
    		#li $v0, 1
    		#syscall 
    		
    		lw $t0, addr_arg2 				#t0 has address of arg2					
		lbu $t1, 0($t0)					#t1 has 1st letter arg3
		lbu $t2, 1($t0)					#t2 has 2nd letter arg3
		li $t3,10					# t3 = 10
		addi $t1, $t1, -48				# t1 = t1 - 48
		addi $t2, $t2,  -48				# t2 = t2 - 48
		li $t3,10					# t3 = 10
		add $s2, $0, $0
		mul $s2,$t1,$t3					# s2 = t1 * t3
		add $s2,$s2,$t2					# s2 = s3 + t2
		li $t1, 16					# t1 = 16
		blt $s2,$t1, invalid_args_error_exit		# if s2 < 16 , branch
		li $t1, 32					# t1 = 32
		bgt $s2, $t1, invalid_args_error_exit		# if s2 > 32 ,branch 
	# s2 is  valid 3rd arg, int
	# start printing 
		#check positive or negative
		li $t1, 32768					# t1 = 2^15 
		and $t2, $s1, $t1				# 2^15 and s1
		beq $t2,$t1, _S_negative				# t1 == t2, branch 
		li $t1, -16					# t1 = 16
		add $t2, $s2, $t1				# t2 = s2 + t1     t2 = 3rd arg - 16
		li $t3, 0					# t3(counter) = 0
		_S_for_loop_printing_positive_sign_extension:		
		beq $t3, $t2, _S_done_printing_sign_extension	# if t3 == t2, brnach
		li $a0, 0 					# a0 = 0
		li $v0, 1					# v0 = 1
		syscall						# print 1
		addi $t3,$t3,1					# t3 (counter) = t3 + 1
		j _S_for_loop_printing_positive_sign_extension
		_S_negative: 
		li $t1, -16					# t1 = 16
		add $t2, $s2, $t1				# t2 = s2 + t1     t2 = 3rd arg - 16
		li $t3, 0					# t3(counter) = 0
		_S_for_loop_printing_negative_sign_extension:		
		beq $t3, $t2, _S_done_printing_sign_extension	# if t3 == t2, brnach
		li $a0, 1 					# a0 = 1
		li $v0, 1					# v0 = 0
		syscall						# print 0
		addi $t3,$t3,1					# t3 (counter) = t3 + 1
		j _S_for_loop_printing_negative_sign_extension
		_S_done_printing_sign_extension:
	# start printing real number
		li $t1 , 32768					#t1 = 32768 (2^15)
		li $t2, 0					#t2 = 0
		li $t3, 2					#t3 = 2
		_S_for_loop_printing_number:
		and $t4, $s1, $t1				# t4 = $s1 and $t1
		beq $t4, $t1, _S_printing_one			# t4 == t1, branch 	bit in position = 1
		li $v0, 1
		li $a0, 0					# a0 = 0
		syscall						# print 0
		j _S_done_print_onebit				# printed, jump 
		_S_printing_one:					
		li $v0, 1
		li $a0, 1					# a0 = 1
		syscall						# print 1
		_S_done_print_onebit:
		div $t1,$t3				# t1 / t3     t1 /2
		mflo $t1
		beq  $t2, $t1, _S_done_printing		# if t2 == t1 ,branch  (t2 == 0)
		j _S_for_loop_printing_number
		_S_done_printing: 
		li $v0,11					# v0 = 11
		li $a0, '\n'					# a0 = '\n'
		syscall	
    	j exit
    	
	
    caseF:
    	li $t0, 70		# t0 conatains ASCII code of S
    	bne $s0, $t0, caseR	# if first argument != F go to caseR
		lw $s7 , num_args  	## s7 = num_args
    		li $t1, 2		## t1 = 2
    		bne $s7,$t1, invalid_args_error_exit ## if s7 != 2 go to invalid_args_error_exit
    		add $s1, $0, $0
    		lw $t0, addr_arg1 	#t0 = address of arg1
    		lb $t1, 0($t0)		# t1 = 1st char arg 1
    		lb $t2, 1($t0)		# t2 = 2nd char arg 1
    		lb $t3, 2($t0)		# t3 = 3rd char arg 1
    		li $t4, 48	
    		li $t5, 57
    		blt $t1, $t4, invalid_args_error_exit 		#if 1st char invalid
    		bgt $t1, $t5, invalid_args_error_exit		#if 1st char invalid
    		blt $t2, $t4, invalid_args_error_exit 		#if 2nd char invalid
    		bgt $t2, $t5, invalid_args_error_exit		#if 2nd char invalid
    		blt $t3, $t4, invalid_args_error_exit 		#if 3rd char invalid
    		bgt $t3, $t5, invalid_args_error_exit		#if 3rd char invalid
    		addi $t1, $t1, -48				#t1 = t1 -48
    		addi $t2, $t2, -48				#t2 = t2 -48
    		addi $t3, $t3, -48				#t3 = t3 -48				
    		li $t6, 100					#t6= 100
    		mul $t7, $t1, $t6				# t7 = t1 * t6(100)
    		add $s1, $s1, $t7				#s1 = s1 + t7
    		li $t6, 10					# t6 = 10
    		mul $t7, $t2, $t6				#t7 = t2 * t6
    		add $s1, $s1, $t7				#s1 = s1 +t7
    		add $s1, $s1, $t3				#s1 = s1 + t3

    	#s1 = int part in int form
    		#printing process from here 
    		li $t1, 0			# t1 = 0
    		beq $s1, $t1, _F_when_int_zero		# if s1 == t1(0), branch
    		li $t1 , 512					#t1 = 512 (2^9)
    		li $t2, 2					#t2 = 2 
    		li $t4, 0					#t4 = 0
    		_F_while_loop_before_start_printing:	#while loop for check the number before print
    		bge $s1, $t1, _F_ready_to_print_	# if (s1 >= t1) branch
    		div $t1, $t2				# t1 / t2(2)
    		mflo $t1				# t1 = qutioent
    		j _F_while_loop_before_start_printing
    		
    		_F_ready_to_print_:
    		_F_while_loop_start_printing :
    		and $t3, $s1, $t1				# t3 = s1 and t1
    		beq $t3, $t1, _F_int_printing_one			# if t3 == t1 , branch means bit exist in position
    		li $v0,1					# v0 = 1
    		li $a0,0					# a0 = 0
    		syscall						# print 0
    		j _F_done_print_onebit
    		_F_int_printing_one:
    		li $v0, 1					# v0  = 1
		li $a0, 1					# a0 = 1
		syscall						# print 1
    		_F_done_print_onebit:
    		div $t1, $t2					# t1 / t2(2)
    		mflo $t1					# t1 = qutioent
    		beq  $t1, $t4, _F_done_int_printing		# if t4 == t1 ,branch  (t2 == 0)
		j _F_while_loop_start_printing
		
		_F_when_int_zero:  #print only 0 when whole number = 0
		li $v0,1	 	#v0 = 1
		li $a0,0		#a0 = 0
		syscall			#print 0
		_F_done_int_printing: 
		li $a0, 46			#a0 = 46 (.)
		li $v0, 11			#v0 = 11
		syscall				#print . (dot)
	#prepare float	
		add $s2, $0, $0		# s2 = 0
		li $t1, 10000		# t1 = 100000
		lw $t2, addr_arg1	# t2 = address of arg1
		addi $t2, $t2,4		# t2 = t2 + 4 (address + 4)
		li $t7, 10		# t7 = 10
		li $t5 , 0		# t5 = 1
		_F_preparing_float_part:
		lbu $t3, 0($t2)		# t3  = 1 byte at t2
		li $t4 ,48					# t4 = 48
		blt $t3, $t4, invalid_args_error		# if (t3 < t4) ,branch
		li $t4, 57					# t4 = 57
		bgt $t3, $t4, invalid_args_error		# if (t3 > t5), branch
		addi $t3, $t3, -48				# t3 = t3 - 48
		mul $t6, $t3, $t1				# t6 = t3 * t1
		add $s2, $s2, $t6				# s2 = s2 + t6
		div $t1, $t7					# t1/t7(10)
		mflo $t1					# t1 = t1/t7
		addi $t2, $t2, 1				# t2 = t2 +1
		beq $t1 , $t5, _F_done_preparing_float_part	# if (t1 == t5), branch
		j _F_preparing_float_part
		
		_F_done_preparing_float_part:
	# print float part
		li $t0, 50000				# t0 = 50000
		li $t1, 2				# t1 = 2
		li $t4 , 0
		li $t5, 5
		_F_fourloop_printing_float_part:
		bge $s2, $t0, _F_float_printing_one		# if s0 >= t0, branch
		div $t0,$t1				# t0 / t1
		mflo $t0				# t= t0 / t1 
		li $a0, 0				# a0 = 0
		li $v0, 1				# v= = 1
		syscall
		j _F_done_printing_one_bit
		_F_float_printing_one:
		li $a0, 1				# a0 = 1
		li $v0, 1				# v = 1
		syscall
		li $t2 , -1
		mul $t3, $t0, $t2
		add $s2, $s2, $t3
		div $t0,$t1				# t0 / t1
		mflo $t0				# t= t0 / t1 
		 _F_done_printing_one_bit:
		 addi $t4, $t4, 1
		 beq $t4, $t5, 	_F_done_fourloop_printing_float_part
		 j _F_fourloop_printing_float_part
		 _F_done_fourloop_printing_float_part:
		li $v0,11					# v0 = 11
		li $a0, '\n'					# a0 = '\n'
		syscall						# printing new line
    	j exit
    	
	
    caseR:
    	li $t0, 82		# t0 conatains ASCII code of S
    	bne $s0, $t0, caseP	# if first argument != R go to caseP
		lw $s7 , num_args  	## s7 = num_args
    		li $t1, 7		## t1 = 7
    		bne $s7,$t1, invalid_args_error_exit ## if s7 != 7 go to invalid_args_error_exit
 		
 	#first arg
    		add $s1 ,$0,$0	 				# s1 = 0
    		lw $t0, addr_arg1 				#t0 = address of arg1							
		lbu $t1, 0($t0)					#t1 = 0 byte at t0
		lbu $t2, 1($t0)					#t2 = 1 byte at t0
		addi $t1, $t1, -48				#t1 = t1 - 48
		li $t3, 10					#t3 = 10
		mul $t1, $t1, $t3				#t1 = t1 * t3(10)
		addi $t2, $t2, -48				#t2 = t2 - 48
		add $s1, $t1, $t2				#s1 = t1 + t2
		li $t3, 31					#t3 = 31
		bgt $s1, $t3, invalid_args_error_exit		# if (s1 > t3 (31)) branch,
	#second arg
    		add $s2 ,$0,$0	 				# s2 = 0
    		lw $t0, addr_arg2 				#t0 = address of arg2							
		lbu $t1, 0($t0)					#t1 = 0 byte at t0
		lbu $t2, 1($t0)					#t2 = 1 byte at t0
		addi $t1, $t1, -48				#t1 = t1 - 48
		li $t3, 10					#t3 = 10
		mul $t1, $t1, $t3				#t1 = t1 * t3(10)
		addi $t2, $t2, -48				#t2 = t2 - 48
		add $s2, $t1, $t2				#s2 = t1 + t2
		li $t3, 31					#t3 = 31
		bgt $s2, $t3, invalid_args_error_exit		# if (s2 > t3 (31)) branch,
	#third arg
    		add $s3 ,$0,$0	 				# s3 = 0
    		lw $t0, addr_arg3				#t0 = address of arg3							
		lbu $t1, 0($t0)					#t1 = 0 byte at t0
		lbu $t2, 1($t0)					#t2 = 1 byte at t0
		addi $t1, $t1, -48				#t1 = t1 - 48
		li $t3, 10					#t3 = 10
		mul $t1, $t1, $t3				#t1 = t1 * t3(10)
		addi $t2, $t2, -48				#t2 = t2 - 48
		add $s3, $t1, $t2				#s3 = t1 + t2
		li $t3, 31					#t3 = 31
		bgt $s3, $t3, invalid_args_error_exit		# if (s3 > t3 (31)) branch,
	#fourth arg
    		add $s4 ,$0,$0	 				# s4 = 0
    		lw $t0, addr_arg4				#t0 = address of arg4							
		lbu $t1, 0($t0)					#t1 = 0 byte at t0
		lbu $t2, 1($t0)					#t2 = 1 byte at t0
		addi $t1, $t1, -48				#t1 = t1 - 48
		li $t3, 10					#t3 = 10
		mul $t1, $t1, $t3				#t1 = t1 * t3(10)
		addi $t2, $t2, -48				#t2 = t2 - 48
		add $s4, $t1, $t2				#s4 = t1 + t2
		li $t3, 31					#t3 = 31
		bgt $s4, $t3, invalid_args_error_exit		# if (s4 > t3 (31)) branch,
	#fifth arg
    		add $s5 ,$0,$0	 				# s5 = 0
    		lw $t0, addr_arg5				#t0 = address of arg5							
		lbu $t1, 0($t0)					#t1 = 0 byte at t0
		lbu $t2, 1($t0)					#t2 = 1 byte at t0
		addi $t1, $t1, -48				#t1 = t1 - 48
		li $t3, 10					#t3 = 10
		mul $t1, $t1, $t3				#t1 = t1 * t3(10)
		addi $t2, $t2, -48				#t2 = t2 - 48
		add $s5, $t1, $t2				#s5 = t1 + t2
		li $t3, 31					#t3 = 31
		bgt $s5, $t3, invalid_args_error_exit		# if (s5 > t3 (31)) branch,
	#sixth arg
    		add $s6 ,$0,$0	 				# s6 = 0
    		lw $t0, addr_arg6				#t0 = address of arg6							
		lbu $t1, 0($t0)					#t1 = 0 byte at t0
		lbu $t2, 1($t0)					#t2 = 1 byte at t0
		addi $t1, $t1, -48				#t1 = t1 - 48
		li $t3, 10					#t3 = 10
		mul $t1, $t1, $t3				#t1 = t1 * t3(10)
		addi $t2, $t2, -48				#t2 = t2 - 48
		add $s6, $t1, $t2				#s6 = t1 + t2
		li $t3, 63					#t3 = 31
		bgt $s6, $t3, invalid_args_error_exit		# if (s6 > t3 (31)) branch,
	# now shifting 
		sll $s1, $s1, 26
		sll $s2, $s2, 27
		srl $s2, $s2, 6
		sll $s3, $s3, 27
		srl $s3, $s3, 11
		sll $s4, $s4, 27
		srl $s4, $s4, 16
		sll $s5, $s5, 27
		srl $s5, $s5, 21
		sll $s6, $s6, 26
		srl $s6, $s6, 26
	# adding
		or $t0, $s1, $s2
		or $t1, $s3, $s4
		or $t2, $s5, $s6
		or $t3, $t0, $t1
		or $s7, $t2, $t3	# s7 = sum of value	
	move $a0, $s7	#a0 = s7
	li $v0,34	
	syscall
	li $v0,11					# v0 = 11
	li $a0, '\n'					# a0 = '\n'
	syscall						# printing new line
	j exit
	
    caseP:
    	li $t0, 80		# t0 conatains ASCII code of S
    	bne $s0, $t0, default	# if first argument != P go to default
    		lw $s7 , num_args  	## s7 = num_args
    		li $t1, 2		## t1 = 2
    		bne $s7,$t1, invalid_args_error_exit 	## if s7 != 2 go to invalid_args_error_exit
    	lw  $t9, addr_arg1		# t0 = arg1 address
    	lbu $s1, 0($t9)			# s1 = 1st card
    	lbu $s2, 1($t9)			# s2 = 2st second
    	lbu $s3, 2($t9)			# s3 = 3st third
    	lbu $s4, 3($t9)			# s4 = 4st fourth
    	lbu $s5, 4($t9)			# s5 = 5st fifth
    # check Big bobtail
    	li $t0, 0	#Club counter
    	li $t1, 0	#Spade counter
    	li $t2, 0	#Diamond Counter
    	li $t3, 0 	#Heart Counter
    	li $t4, 0	# t4 (counter) = 0
    	li $t5, 4	# t5 = 4
    	forloop_for_check_shape:		#check each char shape
    	lbu $t6, 0 ($t9)	# t6 has each char of arg
    	andi $t6, $t6, 0x70		# t6 has shape hex
    	li $t7, 0x40		# t7 = 0x70
    	and $t8,$t7,$t6 	# t8 = t7 and t6
    	beq $t8,$t6, Club	# t8 != t6, branch
    	li $t7, 0x50		# t7 = 0x70
    	and $t8,$t7,$t6 	# t8 = t7 and t6
    	beq $t8,$t6, Spade	
    	li $t7, 0x60		# t7 = 0x70
    	and $t8,$t7,$t6 	# t8 = t7 and t6
    	beq $t8,$t6, Diamond	# t8 != t6, branch
    	li $t7, 0x70		# t7 = 0x70
    	and $t8,$t7,$t6 	# t8 = t7 and t6
    	beq $t8,$t6, Heart	# t8 != t6, branch
    	done_checking_one_char:
    	addi $t9, $t9, 1	# t9 = t9 +1
    	beq $t4, $t5, done_shape_counting	# t4 == t5, branch
    	addi $t4, $t4, 1	#t4 = t4 + 1A
    	j forloop_for_check_shape	
    	Club:	#club counter
    	addi $t0,$t0,1	# club counter + 1
    	j done_checking_one_char  	# done checking one char 	
    	Spade:	#spade counter
    	addi $t1,$t1,1	# spade counter + 1	
    	j done_checking_one_char	# done checking one char 
    	Diamond:#diamond counter
    	addi $t2,$t2,1	# diamond counter + 1
    	j done_checking_one_char	# done checking one char 
    	Heart:	#heart counter
    	addi $t3,$t3,1	# heart counter + 1
    	j done_checking_one_char	# done checking one char 
	done_shape_counting:
	li $t4, 4	#t4 = 4
	bge $t0, $t4, before_Club_check_consecutive		# if t0 >= t4(4), branch 	club
	bge $t1, $t4, before_Spade_check_consecutive		# if t1 >= t4(4), branch	spade
	bge $t2, $t4, before_Diamond_check_consecutive		# if t2 >= t4(4), branch	diamond
	bge $t3, $t4, before_Heart_check_consecutive		# if t3 >= t4(4), branch	heart
	j _collecting_number	
	
	before_Club_check_consecutive:	
	li $t6, 0x40			#t6 = 40 (club char)
	j prepare_sorting
	before_Spade_check_consecutive:
	li $t6, 0x50			#t6 = 50 (spade char)
	j prepare_sorting
	before_Diamond_check_consecutive:
	li $t6, 0x60			#t6 = 60 (diamond char)
	j prepare_sorting
	before_Heart_check_consecutive:
	li $t6, 0x70			#t6 = 70 (heart char)			
	
	
	
	prepare_sorting:	#prepare sorting (collect same shapes in t0 t1 t2 t3)
	li $t4, 0x70	#t4 = 0x70
	and $t5, $s1, $t4	# t5 = shape of first char
	bne $t6, $t5, first_different 	# if (t6 != t5), branch 
	and $t5, $s2, $t4	# t5 = shape of second char
	bne $t6, $t5, second_different	# if (t6 != t5), branch 
	and $t5, $s3, $t4	# t5 = shape of third char
	bne $t6, $t5, third_different	# if (t6 != t5), branch 
	and $t5, $s4, $t4	# t5 = shape of fourth char
	bne $t6, $t5, fourth_different	# if (t6 != t5), branch 
	and $t5, $s5, $t4	# t5 = shape of fifth char
	bne $t6, $t5, fifth_different	# if (t6 != t5), branch 
	## all same shape (same shape 5 cards)
	move $t0, $s1	# t0 = s1
	move $t1, $s2	# t1 = s2
	move $t2, $s3	# t2 = s3
	move $t3, $s4	# t3 = s4
	li $t9, 0	# t9 = 0
	j sorting	# jump to sorting (time to sort)  		sort first 4 char first
	done_sorting_for_5_same_shapes:		#after done 4 same shape, now we need to find where to put fifth char
	bgt $s5, $t3, fifth_place	# if (s5 > t3), branch		fifth char goes fifth 
	bgt $s5, $t2, fourth_place	# if (s5 > t2), branch		fifth char goes fourth
	bgt $s5, $t1, third_place	# if (s5 > t1), branch		fifth char goes third
	bgt $s5, $t0, second_place	# if (s5 > t0), branch		fifth char goes second
	move $t4,$t3		#t4 = t3				fifth char goes first
	move $t3,$t2		#t3 = t2
	move $t2,$t1		#t2 = t1
	move $t1,$t0		#t1 = t0
	move $t0,$s5		#t0 = s5
	j all_shapes_sorted	# all 5 same shape chars sorted
	
	fifth_place:	
	move $t4, $s5	# t4 = s5
	j all_shapes_sorted
	fourth_place:
	move $t4,$t3	# t4 = t3
	move $t3, $s5	# t3 = s5
	j all_shapes_sorted
	third_place:
	move $t4,$t3	# t4 = t3
	move $t3,$t2	# t3 = t2
	move $t2,$s5	# t2 = s5
	j all_shapes_sorted
	second_place:
	move $t4,$t3	#t4 = t3
	move $t3,$t2	# t3 = t2
	move $t2,$t1	# t2 = t1
	move $t1, $s5	# t1 = s5
	 all_shapes_sorted:		# now we have to check if it is consecutive
	#first check JQKA first 
	li $t6 , 15
	and $t6, $t0, $t6
	li $t7,1	# t7 = 1		
	bne $t6, $t7, all_shapes_notJQKA	#if t0 != t7, branch
	li $t6 , 15
	and $t6, $t2, $t6
	li $t7,11	# t7 = 11
	bne $t6, $t7, all_shapes_notJQKA	#if t2 != t7, branch
	li $t6 , 15
	and $t6, $t3, $t6
	li $t7,12	# t7 = 12
	bne $t6, $t7, all_shapes_notJQKA	#if t3 != t7, branch
	li $t6 , 15
	and $t6, $t4, $t6
	li $t7, 13	# t7 = 13
	bne $t6, $t7, all_shapes_notJQKA	#if t4 != t7, branch
	la $a0, big_bobtail_str		# a0 = big bobtail string
	li $v0, 4			# v0 = 4
	syscall				# print big big tail string
	j exit
	all_shapes_notJQKA:
	addi $t0,$t0,1				# t0 = t0 + 1
	bne $t0, $t1, _still_have_a_chance	# if (t0 != t1), branch 
	addi $t1, $t1,1				# t1 = t1 + 1
	bne $t1, $t2, _collecting_number		# t1 != t2, branch 
	addi $t2, $t2,1				# t2 = t2 + 1
	bne $t2, $t3, _collecting_number	# t3 != t2, branch 
	la $a0, big_bobtail_str		# a0 = big bobtail string
	li $v0, 4			# v0 = 4
	syscall				# print big big tail string
	j exit
	
	_still_have_a_chance:		
	addi $t1, $t1,1				# t1 = t1 + 1
	bne $t1, $t2, _collecting_number		# t1 != t2, branch 
	addi $t2, $t2,1				# t2 = t2 + 1
	bne $t2, $t3, _collecting_number	# t3 != t2, branch 
	addi $t3, $t3,1				# t3 = t3 +1
	bne $t3, $t4, _collecting_number	# if (t3 != t4) , branch
	la $a0, big_bobtail_str			# a0 = big bobtail string
	li $v0, 4				# v0 = 4
	syscall					# print big big tail string
	j exit 
	
	
	

	first_different:	# when first is different and rest them are same
	move $t0, $s2
	move $t1, $s3
	move $t2, $s4
	move $t3, $s5
	li $t9, 1
	j sorting
	second_different:	# when second is different and rest them are same
	move $t0, $s1
	move $t1, $s3
	move $t2, $s4
	move $t3, $s5
	li $t9, 1
	j sorting
	third_different:	# when third is different and rest them are same
	move $t0, $s1
	move $t1, $s2
	move $t2, $s4
	move $t3, $s5
	li $t9, 1
	j sorting
	fourth_different:	# when fourth is different and rest them are same
	move $t0, $s1
	move $t1, $s2
	move $t2, $s3
	move $t3, $s5
	li $t9, 1
	j sorting		
	fifth_different:	# when fifth is different and rest them are same
	move $t0, $s1
	move $t1, $s2
	move $t2, $s3
	move $t3, $s4
	li $t9, 1
	
	sorting:	# sorting (bubble sort)
	bgt $t0, $t1, first_swap_t0_t1
	first_done_swap_t0_t1:
	bgt $t1, $t2, first_swap_t1_t2
	first_done_swap_t1_t2:
	bgt $t2, $t3, first_swap_t2_t3
	first_done_swap_t2_t3:
	bgt $t0, $t1, second_swap_t0_t1
	second_done_swap_t0_t1:
	bgt $t1, $t2, second_swap_t1_t2
	second_done_swap_t1_t2:
	bgt $t0, $t1, third_swap_t0_t1
	third_done_swap_t0_t1:
	li $t8, 0					# t8 = 0
	beq $t8 , $t9, done_sorting_for_5_same_shapes	# since all 5 same shapes has t9 = 1 (flag)
	# before check if it is consecutive,
	# check JQKA first
	li $t6 , 15
	and $t6, $t0, $t6
	li $t7,1	# t7 = 1		
	bne $t6, $t7, all_shapes_notJQKA	#if t0 != t7, branch
	li $t6 , 15
	and $t6, $t1, $t6
	li $t7,11	# t7 = 11
	bne $t6, $t7, all_shapes_notJQKA	#if t2 != t7, branch
	li $t6 , 15
	and $t6, $t2, $t6
	li $t7,12	# t7 = 12
	bne $t6, $t7, all_shapes_notJQKA	#if t3 != t7, branch
	li $t6 , 15
	and $t6, $t3, $t6
	li $t7, 13	# t7 = 13
	bne $t6, $t7, all_shapes_notJQKA	#if t4 != t7, branch
	la $a0, big_bobtail_str		# a0 = big bobtail string
	li $v0, 4			# v0 = 4
	syscall				# print big big tail string
	j exit
	fours_shapes_notJQKA:
	addi $t0,$t0,1				# t0 = t0 + 1
	bne $t0, $t1, _collecting_number	# if t0 != t1, branch
	addi $t1, $t1,1				# t1 = t1 + 1
	bne $t1, $t2, _collecting_number	# if (t1 != t2), branch
	addi $t2, $t2,1				# t2 = t2 + 1
	bne $t2, $t3, _collecting_number	# if (t2 != t3), branch
	la $a0, big_bobtail_str			# a0 = big bobtail string
	li $v0, 4				# v0 = 4
	syscall					# print 
	j exit
	first_swap_t0_t1:	# sorting tool
	add $t8, $0, $0
	add $t8 ,$t1, $0
	add $t1, $t0, $0
	add $t0, $t8, $0
	j first_done_swap_t0_t1
	second_swap_t0_t1:	# sorting tool
	add $t8, $0, $0
	add $t8 ,$t1, $0
	add $t1, $t0, $0
	add $t0, $t8, $0
	j second_done_swap_t0_t1	
	third_swap_t0_t1:	# sorting tool
	add $t8, $0, $0
	add $t8 ,$t1, $0
	add $t1, $t0, $0
	add $t0, $t8, $0
	j third_done_swap_t0_t1
	
	first_swap_t1_t2:	# sorting tool
	add $t8, $0, $0
	add $t8 ,$t1, $0
	add $t1, $t2, $0
	add $t2, $t8, $0
	j first_done_swap_t1_t2
	
	second_swap_t1_t2:	# sorting tool
	add $t8, $0, $0
	add $t8 ,$t1, $0
	add $t1, $t2, $0
	add $t2, $t8, $0
	j second_done_swap_t1_t2
	first_swap_t2_t3:	# sorting tool
	add $t8, $0, $0
	add $t8 ,$t2, $0
	add $t2, $t3, $0
	add $t3, $t8, $0
	j first_done_swap_t2_t3
    # collect number before other checks
    	_collecting_number:
    	lw  $s0, addr_arg1		# s0 = arg1 address    	
    	li $t0, 0	# counter of 1
    	li $t1, 0	# counter of 2
    	li $t2, 0	# counter of 3
    	li $t3, 0 	# counter of 4
    	li $t4, 0	# counter of 5
    	li $t5, 0	# counter of 6
    	li $t6, 0	# counter of 7
    	li $t7, 0	# counter of 8
    	li $t8, 0	# counter of 9
    	li $t9, 0	# counter of 10
    	li $s5, 0	# counter of 11
    	li $s6, 0	# counter of 12
    	li $s7, 0	# counter of 13
    	li $s2,0		# s2 = 0     counter s2 = 0
    	li $s3, 5		# s3 = 4     counter done at 4
    	for_loop_for_checking_number:
    	beq $s2, $s3, done_sorting_number
    	lbu $s1, 0 ($s0)	# s1 = has first card at s0
    	andi $s1, $s1, 0x0F	# s1 = s1 and 15	s1 has card num
    
    	li $s4, 1			#s4 = 1 
    	bne $s4, $s1, not_one		# s4 != s1, branch     num is not one, branch
    	addi $t0, $t0,1			# t0 = t0 + 1 (number is 1, so plus one on 1 counter)
    	addi $s2, $s2,1			# s2 = s2 + 1 (counter + 1)
    	addi $s0, $s0,1			# s0 = s0 + 1 (move to next char)
    	j for_loop_for_checking_number
    	
    	not_one:
    	li $s4, 2			#s4 = 2
    	bne $s4, $s1, not_two		# s4 != s1, branch     num is not two, branch
    	addi $t1, $t1,1			# t1 = t1 + 1 (number is 2, so plus one on 2 counter)
    	addi $s2, $s2,1			# s2 = s2 + 1 (counter + 1)
    	addi $s0, $s0,1			# s0 = s0 + 1 (move to next char)
    	j for_loop_for_checking_number
    	
    	
    	not_two:
    	li $s4, 3			#s4 = 3
    	bne $s4, $s1, not_three		# s4 != s1, branch     num is not three, branch
    	addi $t2, $t2,1			# t2 = t2 + 1 (number is 3, so plus one on 3 counter)
    	addi $s2, $s2,1			# s2 = s2 + 1 (counter + 1)
    	addi $s0, $s0,1			# s0 = s0 + 1 (move to next char)
    	j for_loop_for_checking_number
    	
    	not_three:
    	li $s4, 4			#s4 = 4
    	bne $s4, $s1, not_four		# s4 != s1, branch     num is not four, branch
    	addi $t3, $t3,1			# t3 = t3 + 1 (number is 4, so plus one on 4 counter)
    	addi $s2, $s2,1			# s2 = s2 + 1 (counter + 1)
    	addi $s0, $s0,1			# s0 = s0 + 1 (move to next char)
    	j for_loop_for_checking_number
    	
    	
    	not_four:
    	li $s4, 5			#s4 = 5
    	bne $s4, $s1, not_five		# s4 != s1, branch     num is not five, branch
    	addi $t4, $t4,1			# t4 = t4 + 1 (number is 5, so plus one on 5 counter)
    	addi $s2, $s2,1			# s2 = s2 + 1 (counter + 1)
    	addi $s0, $s0,1			# s0 = s0 + 1 (move to next char)
    	j for_loop_for_checking_number
    	
    	not_five:
    	li $s4, 6			#s4 = 6
    	bne $s4, $s1, not_six		# s4 != s1, branch     num is not six, branch
    	addi $t5, $t5,1			# t5 = t5 + 1 (number is 6, so plus one on 6 counter)
    	addi $s2, $s2,1			# s2 = s2 + 1 (counter + 1)
    	addi $s0, $s0,1			# s0 = s0 + 1 (move to next char)
    	j for_loop_for_checking_number
    	
    	not_six:
    	li $s4, 7			#s4 = 7
    	bne $s4, $s1, not_seven		# s4 != s1, branch     num is not seven, branch
    	addi $t6, $t6,1			# t6 = t6 + 1 (number is 7, so plus one on 7 counter)
    	addi $s2, $s2,1			# s2 = s2 + 1 (counter + 1)
    	addi $s0, $s0,1			# s0 = s0 + 1 (move to next char)
    	j for_loop_for_checking_number
    	
    	
    	not_seven:
    	li $s4, 8			#s4 = 8
    	bne $s4, $s1, not_eight		# s4 != s1, branch     num is not eight, branch
    	addi $t7, $t7,1			# t7 = t7 + 1 (number is 8, so plus one on 8 counter)
    	addi $s2, $s2,1			# s2 = s2 + 1 (counter + 1)
    	addi $s0, $s0,1			# s0 = s0 + 1 (move to next char)
    	j for_loop_for_checking_number
    	
    	
    	not_eight:
    	li $s4, 9			#s4 = 9
    	bne $s4, $s1, not_nine		# s4 != s1, branch     num is not nine, branch
    	addi $t8, $t8,1			# t8 = t8 + 1 (number is 9, so plus one on 9 counter)
    	addi $s2, $s2,1			# s2 = s2 + 1 (counter + 1)
    	addi $s0, $s0,1			# s0 = s0 + 1 (move to next char)
    	j for_loop_for_checking_number
    	
    	not_nine:
    	li $s4, 10			#s4 = 10
    	bne $s4, $s1, not_ten		# s4 != s1, branch     num is not ten, branch
    	addi $t9, $t9,1			# t9 = t9 + 1 (number is 10, so plus one on 10 counter)
    	addi $s2, $s2,1			# s2 = s2 + 1 (counter + 1)
    	addi $s0, $s0,1			# s0 = s0 + 1 (move to next char)
    	j for_loop_for_checking_number
    	
    	
    	not_ten:
    	li $s4, 11			#s4 = 10
    	bne $s4, $s1, not_eleven	# s4 != s1, branch     num is not eleven, branch
    	addi $s5, $s5,1			# s5 = s5 + 1 (number is 11, so plus one on 11 counter)
    	addi $s2, $s2,1			# s2 = s2 + 1 (counter + 1)
    	addi $s0, $s0,1			# s0 = s0 + 1 (move to next char)
    	j for_loop_for_checking_number
    	
    	not_eleven:
    	li $s4, 12			#s4 = 12
    	bne $s4, $s1, not_twelve	# s4 != s1, branch     num is not twelve, branch
    	addi $s6, $s6,1			# s6 = s6 + 1 (number is 12, so plus one on 12 counter)
    	addi $s2, $s2,1			# s2 = s2 + 1 (counter + 1)
    	addi $s0, $s0,1			# s0 = s0 + 1 (move to next char)
    	j for_loop_for_checking_number
    	
    	not_twelve:
    	addi $s7, $s7,1			# s7 = s7 + 1 (number is 13, so plus one on 13 counter)
    	addi $s2, $s2,1			# s2 = s2 + 1 (counter + 1)
    	addi $s0, $s0,1			# s0 = s0 + 1 (move to next char)
    	j for_loop_for_checking_number
    
    	done_sorting_number:
    # check Full house
    	li $s0 ,3	#s0 = 3
    	bne $t0, $s0, Full_house_check_2	#s0 != t0, branch
    	or $s1,$t1,$t2			# s1 = or (all numbers besides t0)
    	or $s1 ,$s1,$t3
    	or $s1 ,$s1,$t4
    	or $s1 ,$s1,$t5
    	or $s1 ,$s1,$t6
    	or $s1 ,$s1,$t7
    	or $s1 ,$s1,$t8
    	or $s1 ,$s1,$t9
    	or $s1 ,$s1,$s5
    	or $s1 ,$s1,$s6
    	or $s1 ,$s1,$s7		
    	li $s3,1			# s3 = 1
    	beq $s1, $s3, five_and_dime	# if s1 == s3, branch    
    	la $a0, full_house_str		# a0 = full house string
	li $v0, 4				# v0 = 4
	syscall					# print 
    	j exit
    	Full_house_check_2:
    	bne $t1, $s0, Full_house_check_3	#s0 != t1, branch
    	or $s1,$t0,$t2			# s1 = or (all numbers besides t0)
    	or $s1 ,$s1,$t3
    	or $s1 ,$s1,$t4
    	or $s1 ,$s1,$t5
    	or $s1 ,$s1,$t6
    	or $s1 ,$s1,$t7
    	or $s1 ,$s1,$t8
    	or $s1 ,$s1,$t9
    	or $s1 ,$s1,$s5
    	or $s1 ,$s1,$s6
    	or $s1 ,$s1,$s7		
    	li $s3,1			# s3 = 1
    	beq $s1, $s3, five_and_dime	# if s1 == s3, branch    
    	la $a0, full_house_str		# a0 = full house string
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
    	Full_house_check_3:
    	bne $t2, $s0, Full_house_check_4	#s0 != t1, branch
    	or $s1,$t0,$t1			# s1 = or (all numbers besides t0)
    	or $s1 ,$s1,$t3
    	or $s1 ,$s1,$t4
    	or $s1 ,$s1,$t5
    	or $s1 ,$s1,$t6
    	or $s1 ,$s1,$t7
    	or $s1 ,$s1,$t8
    	or $s1 ,$s1,$t9
    	or $s1 ,$s1,$s5
    	or $s1 ,$s1,$s6
    	or $s1 ,$s1,$s7		
    	li $s3,1			# s3 = 1
    	beq $s1, $s3, five_and_dime	# if s1 == s3, branch    
    	la $a0, full_house_str		# a0 = full house string
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
    	Full_house_check_4:
    	bne $t3, $s0, Full_house_check_5	#s0 != t1, branch
    	or $s1,$t0,$t1			# s1 = or (all numbers besides t0)
    	or $s1 ,$s1,$t2
    	or $s1 ,$s1,$t4
    	or $s1 ,$s1,$t5
    	or $s1 ,$s1,$t6
    	or $s1 ,$s1,$t7
    	or $s1 ,$s1,$t8
    	or $s1 ,$s1,$t9
    	or $s1 ,$s1,$s5
    	or $s1 ,$s1,$s6
    	or $s1 ,$s1,$s7		
    	li $s3,1			# s3 = 1
    	beq $s1, $s3, five_and_dime	# if s1 == s3, branch    
    	la $a0, full_house_str		# a0 = full house string
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
    	Full_house_check_5:
    	bne $t4, $s0, Full_house_check_6	#s0 != t1, branch
    	or $s1,$t0,$t1			# s1 = or (all numbers besides t0)
    	or $s1 ,$s1,$t2
    	or $s1 ,$s1,$t3
    	or $s1 ,$s1,$t5
    	or $s1 ,$s1,$t6
    	or $s1 ,$s1,$t7
    	or $s1 ,$s1,$t8
    	or $s1 ,$s1,$t9
    	or $s1 ,$s1,$s5
    	or $s1 ,$s1,$s6
    	or $s1 ,$s1,$s7		
    	li $s3,1			# s3 = 1
    	beq $s1, $s3, five_and_dime	# if s1 == s3, branch    
    	la $a0, full_house_str		# a0 = full house string
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
    	Full_house_check_6:
    	bne $t5, $s0, Full_house_check_7	#s0 != t1, branch
    	or $s1,$t0,$t1			# s1 = or (all numbers besides t0)
    	or $s1 ,$s1,$t2
    	or $s1 ,$s1,$t3
    	or $s1 ,$s1,$t4
    	or $s1 ,$s1,$t6
    	or $s1 ,$s1,$t7
    	or $s1 ,$s1,$t8
    	or $s1 ,$s1,$t9
    	or $s1 ,$s1,$s5
    	or $s1 ,$s1,$s6
    	or $s1 ,$s1,$s7		
    	li $s3,1			# s3 = 1
    	beq $s1, $s3, five_and_dime	# if s1 == s3, branch    
    	la $a0, full_house_str		# a0 = full house string
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
    	Full_house_check_7:
    	bne $t6, $s0, Full_house_check_8	#s0 != t1, branch
    	or $s1,$t0,$t1			# s1 = or (all numbers besides t0)
    	or $s1 ,$s1,$t2
    	or $s1 ,$s1,$t3
    	or $s1 ,$s1,$t4
    	or $s1 ,$s1,$t5
    	or $s1 ,$s1,$t7
    	or $s1 ,$s1,$t8
    	or $s1 ,$s1,$t9
    	or $s1 ,$s1,$s5
    	or $s1 ,$s1,$s6
    	or $s1 ,$s1,$s7		
    	li $s3,1			# s3 = 1
    	beq $s1, $s3, five_and_dime	# if s1 == s3, branch    
    	la $a0, full_house_str		# a0 = full house string
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
    	Full_house_check_8:
    	bne $t7, $s0, Full_house_check_9	#s0 != t1, branch
    	or $s1,$t0,$t1			# s1 = or (all numbers besides t0)
    	or $s1 ,$s1,$t2
    	or $s1 ,$s1,$t3
    	or $s1 ,$s1,$t4
    	or $s1 ,$s1,$t5
    	or $s1 ,$s1,$t6
    	or $s1 ,$s1,$t8
    	or $s1 ,$s1,$t9
    	or $s1 ,$s1,$s5
    	or $s1 ,$s1,$s6
    	or $s1 ,$s1,$s7		
    	li $s3,1			# s3 = 1
    	beq $s1, $s3, five_and_dime	# if s1 == s3, branch    
    	la $a0, full_house_str		# a0 = full house string
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
    	Full_house_check_9:
    	bne $t8, $s0, Full_house_check_10	#s0 != t1, branch
    	or $s1,$t0,$t1			# s1 = or (all numbers besides t0)
    	or $s1 ,$s1,$t2
    	or $s1 ,$s1,$t3
    	or $s1 ,$s1,$t4
    	or $s1 ,$s1,$t5
    	or $s1 ,$s1,$t6
    	or $s1 ,$s1,$t7
    	or $s1 ,$s1,$t9
    	or $s1 ,$s1,$s5
    	or $s1 ,$s1,$s6
    	or $s1 ,$s1,$s7		
    	li $s3,1			# s3 = 1
    	beq $s1, $s3, five_and_dime	# if s1 == s3, branch    
    	la $a0, full_house_str		# a0 = full house string
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
    	Full_house_check_10:
    	bne $t9, $s0, Full_house_check_11	#s0 != t1, branch
    	or $s1,$t0,$t1			# s1 = or (all numbers besides t0)
    	or $s1 ,$s1,$t2
    	or $s1 ,$s1,$t3
    	or $s1 ,$s1,$t4
    	or $s1 ,$s1,$t5
    	or $s1 ,$s1,$t6
    	or $s1 ,$s1,$t7
    	or $s1 ,$s1,$t8
    	or $s1 ,$s1,$s5
    	or $s1 ,$s1,$s6
    	or $s1 ,$s1,$s7		
    	li $s3,1			# s3 = 1
    	beq $s1, $s3, five_and_dime	# if s1 == s3, branch    
    	la $a0, full_house_str		# a0 = full house string
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
    	Full_house_check_11:
    	bne $s5, $s0, Full_house_check_12	#s0 != t1, branch
    	or $s1,$t0,$t1			# s1 = or (all numbers besides t0)
    	or $s1 ,$s1,$t2
    	or $s1 ,$s1,$t3
    	or $s1 ,$s1,$t4
    	or $s1 ,$s1,$t5
    	or $s1 ,$s1,$t6
    	or $s1 ,$s1,$t7
    	or $s1 ,$s1,$t8
    	or $s1 ,$s1,$t9
    	or $s1 ,$s1,$s6
    	or $s1 ,$s1,$s7		
    	li $s3,1			# s3 = 1
    	beq $s1, $s3, five_and_dime	# if s1 == s3, branch    
    	la $a0, full_house_str		# a0 = full house string
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
    	Full_house_check_12:
    	bne $s6, $s0, Full_house_check_13	#s0 != t1, branch
    	or $s1,$t0,$t1			# s1 = or (all numbers besides t0)
    	or $s1 ,$s1,$t2
    	or $s1 ,$s1,$t3
    	or $s1 ,$s1,$t4
    	or $s1 ,$s1,$t5
    	or $s1 ,$s1,$t6
    	or $s1 ,$s1,$t7
    	or $s1 ,$s1,$t8
    	or $s1 ,$s1,$t9
    	or $s1 ,$s1,$s5
    	or $s1 ,$s1,$s7		
    	li $s3,1			# s3 = 1
    	beq $s1, $s3, five_and_dime	# if s1 == s3, branch    
    	la $a0, full_house_str		# a0 = full house string
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
    	Full_house_check_13:
    	bne $s7, $s0, five_and_dime	#s0 != t1, branch
    	or $s1,$t0,$t1			# s1 = or (all numbers besides t0)
    	or $s1 ,$s1,$t2
    	or $s1 ,$s1,$t3
    	or $s1 ,$s1,$t4
    	or $s1 ,$s1,$t5
    	or $s1 ,$s1,$t6
    	or $s1 ,$s1,$t7
    	or $s1 ,$s1,$t8
    	or $s1 ,$s1,$t9
    	or $s1 ,$s1,$s5
    	or $s1 ,$s1,$s6		
    	li $s3,1			# s3 = 1
    	beq $s1, $s3, five_and_dime	# if s1 == s3, branch    
    	la $a0, full_house_str		# a0 = full house string
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
   
    	five_and_dime:
    	li $s1,1		# s1 = 1
    	bne $s1, $t4, skeet	# if s1 != t4 , branch
    	bne $s1, $t9, skeet	# if s1 != t9 , branch 
    	add $s3, $t5, $t6	# s3 = t5 + t6
    	add $s3, $s3, $t7	# s3 = s3 + t7
    	add $s3, $s3, $t8	# s3 = s3 + t8
    	li $s4, 3		# s4 = 3
    	bne $s4, $s3, skeet		# if s4 != s3, branch
    	or $s3, $t5, $t6
    	or $s3, $s3, $t7
    	or $s3, $s3, $t8
    	li $s4, 1
    	bne $s3, $s4, skeet
    	la $a0, five_and_dime_str		# a0 = five_and_dime_str	
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
    	
    	skeet:
    	li $s1, 1		# s1 = 1
    	bne $s1, $t1, blaze	# if s1 != t1, branch 
    	bne $s1, $t4, blaze	# if s1 != t4, branch 
    	bne $s1, $t8, blaze	# if s1 != t8, branch
    	add $s3, $t9, $s5	# s3 = t9 + s5
    	add $s3, $s3, $s6	# s3 = s3 + s6
    	add $s3, $s3, $s7	# s3 = s3 + s7
    	li $s1,0		# s1 = 0
    	bne $s1, $s3, blaze	# if s1 != s3, branch
    	or $s3, $t0, $t2
    	or $s3, $s3, $t3
    	or $s3, $s3, $t5
    	or $s3, $s3, $t6
    	or $s3, $s3, $t7
    	li $s1,1
    	bne $s3, $s1, blaze 
    	
    	la $a0, skeet_str		# a0 = skeet_str
	li $v0, 4				# v0 = 4
	syscall				# print 
	j exit
    	blaze:
    	li $s1, 5			#s1 = 5
    	add $s3, $s5, $s6		#s3 = s5 + s6
    	add $s3, $s3, $s7		#s3 = s3 + s7
    	bne $s3, $s1, high_card		# if s3 != s1, branch
    	la $a0, blaze_str		# a0 = blaze_str
	li $v0, 4				# v0 = 4
	syscall				# print 
    	j exit
	high_card:
	la $a0, high_card_str		# a0 = high_card_str
	li $v0, 4				# v0 = 4
	syscall 
    	j exit
    default:   			# if it is none of them, print invalid_operation_error and exit
    	j invalid_operation_error_exit
    	

invalid_args_error_exit:  	# if arguemtns are invalid args error, print invalid args
	la $a0, invalid_args_error
	li $v0, 4
	syscall
	j exit	# jump to exit
	
invalid_operation_error_exit:	# if arguments are invalid operaiton, print operation error
	la $a0, invalid_operation_error
    	li $v0, 4
    	syscall
exit:
    li $v0, 10
    syscall

# Hak Soo Kim
# haksokim
# 111045936

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

.text
memcpy:											# Part 1
	
	blez $a2, not_valid_memcpy
	move $v0, $a2
	loop_for_memcpy:
	beqz $a2, done_memcpu
	addi $a2, $a2, -1
	lbu $t1, 0($a1)
	sb $t1, 0($a0)
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	j loop_for_memcpy	
	not_valid_memcpy:
	li $v0, -1
	done_memcpu:
    jr $ra

strcmp:	
	li $t0, 0									# Part 2
	lbu $t1, 0($a0)
	bne $t0, $t1, first_str_not_empty
	
	li $t2, 0					#  first str = empty
	loop_for_when_first_str_empty:
	lbu $t1, 0($a1)
	beqz $t1, done_loop_for_when_first_str_empty
	addi $t2, $t2, 1
	addi $a1, $a1, 1
	j loop_for_when_first_str_empty
	done_loop_for_when_first_str_empty:
	li $t3, 0
	sub $t2, $t3, $t2
	move $v0, $t2
	j done_strcmp
	
	first_str_not_empty:
	lbu $t1, 0($a1)
	bnez $t1, second_str_not_empty
	
	li $t2, 0					# second str = empty
	loop_for_when_second_str_empty:
	lbu $t1, 0($a0)
	beqz $t1, done_loop_for_when_second_str_empty
	addi $t2, $t2, 1
	addi $a0, $a0, 1
	j loop_for_when_second_str_empty
	done_loop_for_when_second_str_empty:
	move $v0, $t2
	j done_strcmp
	
	second_str_not_empty:		# now both are not empty 
	loop_for_finding_diff:
	lbu $t1, 0($a0)
	lbu $t2, 0($a1)
	sub $t3, $t1, $t2
	beqz $t3, still_same
	move $v0, $t3
	j done_strcmp
	still_same:
	li $t4, 0
	bne $t1, $t4, not_end_of_string
	sub $t3, $t1, $t2
	move $v0, $t3
	j done_strcmp
	not_end_of_string:
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	j loop_for_finding_diff
	done_strcmp:
    jr $ra

initialize_hashtable:	
	li $t0, 1								# Part 3
	bge $a1, $t0, valid_capacity_in_initialize_hashtable
	li $v0, -1
	j done_initialize_hashtable
	valid_capacity_in_initialize_hashtable:
	bge $a2, $t0, valid_element_size_in_initialize_hashtable
	li $v0, -1
	j done_initialize_hashtable
	valid_element_size_in_initialize_hashtable:
	sw $a1, 0($a0)
	li $t0, 0
	sw $t0, 4($a0)
	sw $a2, 8($a0)
	
	move $t4, $a1
	move $t5, $a2
	
	addi $t3, $a0, 12
	li $t1, 0
	mul $t0, $t4, $t5
	loop_for_initialize_hashtable:
	beqz $t0, done_loop_for_initialize_hashtable
	addi $t0, $t0, -1
	sb $t1, 0($t3)
	addi $t3, $t3, 1
	j loop_for_initialize_hashtable
	
	done_loop_for_initialize_hashtable:
	li $v0, 0
	done_initialize_hashtable:
    jr $ra

hash_book:									# Part 4
	li $t0, 0
	loop_in_hash_book:
	lbu $t1, 0($a1)
	beqz $t1, done_loop_in_hash_book
	add $t0, $t0, $t1
	addi $a1, $a1, 1
	j loop_in_hash_book
	done_loop_in_hash_book:
	lw $t2, 0($a0)
	div $t0, $t2
	mfhi $v0
    jr $ra

get_book:									# Part 5
addi $sp, $sp, -24
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $s4, 20($sp)
	
	move $s0, $a0		# start address of hash
	move $s1, $a1		# isbn that looking for
	addi $s2, $a0, 12	# element arr starting 
	jal hash_book
	
	move $s3, $v0		# s3 = hash of str
	li $s4, 1		# counter for searching 
	loop_in_get_book:
		
	
	lw $t0, 8($s0)		# t0 = element size
	mul $t0, $t0, $s3	# t0 = element size * index 
	add $t0, $t0, $s2	# t0 = starting address of element at index
	lbu $t1, 0($t0)
	li $t2, 0
	bne $t1, $t2, not_empty_in_loop_in_get_book
	li $v0, -1
	move $v1, $s4 
	j done_loop_in_get_book
	
	not_empty_in_loop_in_get_book:
	li $t2, -1
	beq $t1, $t2, next_in_loop_in_get_book
	move $a0, $t0
	move $a1, $s1
	jal  strcmp
	li $t2, 0
	bne $v0, $t2, next_in_loop_in_get_book
	move $v0, $s3
	move $v1, $s4
	j done_loop_in_get_book
	next_in_loop_in_get_book:
	addi $s4, $s4, 1
	addi $s3, $s3, 1
	lw $t3, 0($s0) 
	div $s3, $t3
	mfhi $s3
	
	bne $s4, $t3, loop_in_get_book
	li $v0, -1
	move $v1, $s4

	done_loop_in_get_book:
	 

lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
lw $s4, 20($sp)
addi $sp, $sp, 24


    jr $ra

add_book:										# Part 6	
addi $sp, $sp, -36	
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $s4, 20($sp)
sw $s5, 24($sp)
sw $s6, 28($sp)
sw $s7, 32($sp)
	
	move $s0, $a0	# s0 = starting address of table 
	move $s1, $a1	# s1 = isbn
	move $s2, $a2	# s2 = title
	move $s3, $a3	# s3 = author
	
	lbu $t0, 0($a0)		# check if table is full
	lbu $t1, 4($a0)
	bne $t0, $t1, table_not_full_in_add_book
	li $v0, -1
	li $v1, -1
	j done_add_book
	
	table_not_full_in_add_book:	# table is not full
	jal get_book	# check if isbn already exist 
	li $t0, -1
	beq $t0, $v0, not_in_table
	j done_add_book
	
	not_in_table:	# have to add book now
	move $a0, $s0
	move $a1, $s1
	jal hash_book
	
	move $s4, $v0	# s4 =  index ( return of hash_book)
	li $s5, 1	# s5 = counter (counter how many travels)

	loop_in_add_book:

	lw $t0, 8($s0)		# t0 = element size
	mul $t0, $t0, $s4	# t0 = element size * index 
	addi $t1, $s0, 12 
	add $t0, $t0, $t1	# t0 = starting address of element at index in book 
	lbu $t2, 0($t0)	
	li $t3, 57
	beq $t2, $t3, find_next_place_in_add_book
	# have to add a book 
	li $t1, 14
	move $a0, $t0
	move $a1, $s1
	move $a2, $t1
	move $s6, $t0
	jal memcpy
			
	addi $s6, $s6, 14		# current address in book
			# isbn is all set 
	li $t1, 0					#count length of title 
	move $t3, $s2 
	loop_for_counting_len_title:
	lbu $t2, 0($t3)
	beqz $t2, done_loop_for_counting_len_title
	addi $t1, $t1, 1
	addi $t3, $t3, 1
	j loop_for_counting_len_title
	
	done_loop_for_counting_len_title:	# t1 = length of title
	li $t2, 24
	bgt $t1, $t2, title_more_than_24 

	setting_title:
	move $a0, $s6	#s6 = current address at index
	move $a1, $s2	
	move $a2, $t1	
	move $s7, $t1	# s7 = len of title 
	jal memcpy
	
	add $s6, $s6, $s7
	
	li $t0, 25
	sub $t0, $t0, $s7
	li $t1, 0
	loop_for_null_terminator_title:
	beqz $t0, done_loop_for_null_terminator_title
	sb $t1, 0($s6)
	addi $t0, $t0, -1
	addi $s6, $s6, 1
	j loop_for_null_terminator_title
	
	 title_more_than_24:
	 move $a0, $s6
	 move $a1, $s2
	 li $a2, 24
	 jal memcpy
	 addi $s6, $s6,24
	 li $t0, 0
	 sb $t0, 0($s6)
	 addi $s6, $s6, 1
	 
	 done_loop_for_null_terminator_title:
	 
	 ##
	 
	 li $t1, 0					#count length of artist 
	move $t3, $s3 
	loop_for_counting_len_artist:
	lbu $t2, 0($t3)
	beqz $t2, done_loop_for_counting_len_artist
	addi $t1, $t1, 1
	addi $t3, $t3, 1
	j loop_for_counting_len_artist
	
	done_loop_for_counting_len_artist:	# t1 = length of artist
	li $t2, 24
	bgt $t1, $t2, artist_more_than_24 

	setting_artist:
	move $a0, $s6	#s6 = current address at index
	move $a1, $s3	
	move $a2, $t1	
	move $s7, $t1	# s7 = len of artist 
	jal memcpy
	
	add $s6, $s6, $s7
	
	li $t0, 25
	sub $t0, $t0, $s7
	li $t1, 0
	loop_for_null_terminator_artist:
	beqz $t0, done_loop_for_null_terminator_artist
	sb $t1, 0($s6)
	addi $t0, $t0, -1
	addi $s6, $s6, 1
	j loop_for_null_terminator_artist
	
	 artist_more_than_24:
	 move $a0, $s6
	 move $a1, $s3
	 li $a2, 24
	 jal memcpy
	 addi $s6, $s6,24
	 li $t0, 0
	 sb $t0, 0($s6)
	 addi $s6, $s6, 1
	 
	 done_loop_for_null_terminator_artist:
	li $t0, 0
	sw $t0, 0($s6)
	move $v0, $s4
	move $v1, $s5
	lw $t0, 4($s0)
	addi $t0, $t0, 1
	sw $t0, 4($s0)


	j done_add_book
	
	
	
	
	find_next_place_in_add_book:
	addi $s4, $s4, 1
	addi $s5, $s5, 1
	lw $t3, 0($s0) 
	div $s4, $t3
	mfhi $s4
	j loop_in_add_book

 done_add_book:


lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
lw $s4, 20($sp)
lw $s5, 24($sp)
lw $s6, 28($sp)
lw $s7, 32($sp)
addi $sp, $sp, 36	
    jr $ra



delete_book:									# Part 7

addi $sp, $sp, -8
sw $ra, 0($sp)
sw $s0, 4($sp)

move $s0, $a0

jal get_book
li $t0, -1
bne $t0, $v0, exist_in_delete_book
li $v0, -1
j done_delete_book

exist_in_delete_book:
lw $t0, 4($s0)
addi $t0, $t0, -1
sw $t0, 4($s0)
lw $t0, 8($s0)
mul $t0, $t0, $v0
addi $t1, $s0, 12 
add $t0, $t0, $t1
lw $t1, 8($s0)

li $t2, -1
loop_in_delete_book:
beqz $t1, done_delete_book
addi $t1, $t1, -1
sb $t2, 0($t0)
addi $t0, $t0, 1
j loop_in_delete_book

 
   

done_delete_book:

lw $ra, 0($sp)
lw $s0, 4($sp)
addi $sp, $sp, 8
    jr $ra

hash_booksale:									# Part 8
	li $t0, 0
	loop_in_hash_sale_for_isbn:
	lbu $t1, 0($a1)
	beqz $t1, done_loop_in_hash_sale_for_isbn
	add $t0, $t0, $t1
	addi $a1, $a1, 1
	j loop_in_hash_sale_for_isbn
	done_loop_in_hash_sale_for_isbn:
	li $t1, 10000000
	div $a2, $t1
	mflo $t2
	add $t0, $t0, $t2
	mul $t3, $t1, $t2
	sub $a2, $a2, $t3
	
	li $t1, 1000000
	div $a2, $t1
	mflo $t2
	add $t0, $t0, $t2
	mul $t3, $t1, $t2
	sub $a2, $a2, $t3
	
	li $t1, 100000
	div $a2, $t1
	mflo $t2
	add $t0, $t0, $t2
	mul $t3, $t1, $t2
	sub $a2, $a2, $t3
	
	li $t1, 10000
	div $a2, $t1
	mflo $t2
	add $t0, $t0, $t2
	mul $t3, $t1, $t2
	sub $a2, $a2, $t3
	
	li $t1, 1000
	div $a2, $t1
	mflo $t2
	add $t0, $t0, $t2
	mul $t3, $t1, $t2
	sub $a2, $a2, $t3
	
	li $t1, 100
	div $a2, $t1
	mflo $t2
	add $t0, $t0, $t2
	mul $t3, $t1, $t2
	sub $a2, $a2, $t3
	
	li $t1, 10
	div $a2, $t1
	mflo $t2
	add $t0, $t0, $t2
	mul $t3, $t1, $t2
	sub $a2, $a2, $t3
	
	add $t0, $t0, $a2
	
	lw $t1, 0($a0)
	div $t0, $t1 
	mfhi $v0
    jr $ra

is_leap_year:										# Part 9



	li $t1, 1582
	bge $a0, $t1, after_or_1582
	li $v0, 0
	j done_is_leap_year
	
	after_or_1582:

	li $t1, 4 
	div $a0, $t1            	# hi = year mod 4 
	mfhi $t1                	# $t1 = hi, which is the remainder
	beq $t1, $0, maybe_leap_year1   	# if $t1 != 0 go to ordinary_year
		#not leap year
		li $t7, 0
		loop_for_leap_year1:
		addi $t7, $t7, 1
		li $t1, 4 
		addi $a0, $a0, 1
		div $a0, $t1
		mfhi $t1
		bne $t1, $0, loop_for_leap_year1
		li $t1, 100
		div $a0, $t1
		mfhi $t1
		beq $t1, $0, maybe_leap_year_in_loop1
		sub $v0, $0, $t7
		j done_is_leap_year
		maybe_leap_year_in_loop1:
		li $t1, 400
		div $a0, $t1
		mfhi $t1
		bne $t1, $0, loop_for_leap_year1
		sub $v0, $0, $t7
		j done_is_leap_year
		
	maybe_leap_year1:
	li $t1, 100 
        div $a0, $t1            # hi = year % 100 
        mfhi $t1               	# $t1 = hi 
        beq $t1, $0, maybe_leap_year2	# if $t1 != 0 go to leap_year
	li $v0, 1
	j done_is_leap_year

	maybe_leap_year2:
	# if (year % 400 != 0) then go to ordinary_year
	li $t1, 400 
	div $a0, $t1           		# hi = year % 400 
	mfhi $t1               		# $t1 = hi 
	bne $t1, $0, not_leap_year  	# if $t1 != 0 go to ordinary_year
	li $v0, 1
	j done_is_leap_year
	
	not_leap_year:
	li $t7, 0
		loop_for_leap_year2:
		addi $t7, $t7, 1
		li $t1, 4 
		addi $a0, $a0, 1
		div $a0, $t1
		mfhi $t1
		bne $t1, $0, loop_for_leap_year2
		li $t1, 100
		div $a0, $t1
		mfhi $t1
		beq $t1, $0, maybe_leap_year_in_loop2
		sub $v0, $0, $t7
		j done_is_leap_year
		maybe_leap_year_in_loop2:
		li $t1, 400
		div $a0, $t1
		mfhi $t1
		bne $t1, $0, loop_for_leap_year2
		sub $v0, $0, $t7
		j done_is_leap_year


done_is_leap_year:
	jr $ra



datestring_to_num_days:								# Part 10

addi $sp, $sp, -36
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $s4, 20($sp)
sw $s5, 24($sp)
sw $s6, 28($sp)
sw $s7, 32($sp)

lbu $t0, 0($a0)				# getting first arg in number
addi $t0, $t0, -48
li $t1, 1000
mul $s0, $t0, $t1
lbu $t0, 1($a0)
addi $t0, $t0, -48
li $t1, 100
mul $t1, $t0, $t1
add $s0, $s0, $t1
lbu $t0, 2($a0)
addi $t0, $t0, -48
li $t1, 10
mul $t1, $t0, $t1
add $s0, $t1, $s0
lbu $t0, 3($a0)
addi $t0, $t0, -48
add $s0, $t0, $s0

lbu $t0, 5($a0)
li $t1, 10
addi $t0, $t0, -48
mul $s1, $t1, $t0
lbu $t0, 6($a0)
addi $t0, $t0, -48
add $s1, $s1, $t0

lbu $t0, 8($a0)
li $t1, 10
addi $t0, $t0, -48
mul $s2, $t1, $t0
lbu $t0, 9($a0)
addi $t0, $t0, -48
add $s2, $s2, $t0


lbu $t0, 0($a1)				# getting second arg in number
addi $t0, $t0, -48
li $t1, 1000
mul $s3, $t0, $t1
lbu $t0, 1($a1)
addi $t0, $t0, -48
li $t1, 100
mul $t1, $t0, $t1
add $s3, $s3, $t1
lbu $t0, 2($a1)
addi $t0, $t0, -48
li $t1, 10
mul $t1, $t0, $t1
add $s3, $t1, $s3
lbu $t0, 3($a1)
addi $t0, $t0, -48
add $s3, $t0, $s3

lbu $t0, 5($a1)
li $t1, 10
addi $t0, $t0, -48
mul $s4, $t1, $t0
lbu $t0, 6($a1)
addi $t0, $t0, -48
add $s4, $s4, $t0

lbu $t0, 8($a1)
li $t1, 10
addi $t0, $t0, -48
mul $s5, $t1, $t0
lbu $t0, 9($a1)
addi $t0, $t0, -48
add $s5, $s5, $t0

li $s6, 0

## compute
	
li $t0, 2
bne $t0, $s1, not_two_in_first
addi $s6, $s6, 31
j done_this_year_for_first
not_two_in_first:
li $t0, 3
bne $t0, $s1, not_three_in_first
addi $s6, $s6, 59
j done_this_year_for_first
not_three_in_first:
li $t0, 4
bne $t0, $s1, not_four_in_first
addi $s6, $s6, 90
j done_this_year_for_first
not_four_in_first:
li $t0, 5
bne $t0, $s1, not_five_in_first
addi $s6, $s6, 120
j done_this_year_for_first
not_five_in_first:
li $t0, 6
bne $t0, $s1, not_six_in_first
addi $s6,$s6, 151
j done_this_year_for_first
not_six_in_first:
li $t0, 7
bne $t0, $s1, not_seven_in_first
addi $s6, $s6, 181
j done_this_year_for_first
not_seven_in_first:
li $t0, 8
bne $t0, $s1, not_eight_in_first
addi $s6, $s6, 212
j done_this_year_for_first
not_eight_in_first:
li $t0, 9
bne $t0, $s1, not_nine_in_first
addi $s6, $s6, 243
j done_this_year_for_first
not_nine_in_first:
li $t0, 10
bne $t0, $s1, not_ten_in_first
addi $s6, $s6, 273
j done_this_year_for_first
not_ten_in_first:
li $t0, 11
bne $t0, $s1, not_eleven_in_first
addi $s6, $s6, 304
j done_this_year_for_first
not_eleven_in_first:
li $t0, 12
bne $t0, $s1, done_this_year_for_first
addi $s6, $s6, 334

done_this_year_for_first:
li $t0, 1600 

loop_for_first:
beq $t0, $s0, done_except_for_this_year_for_first
move $a0, $t0
addi $sp, $sp, -4
sw $t0, 0($sp)
jal is_leap_year
lw $t0, 0($sp)
addi $sp, $sp, 4
li $t1, 1
bne $t1, $v0, not_leap_year_for_first
addi $s6, $s6, 1
not_leap_year_for_first:
addi $s6, $s6, 365
addi $t0, $t0, 1
j loop_for_first

done_except_for_this_year_for_first:
li $t0, 2
ble $s1, $t0, not_add_one_for_first
move $a0, $s0
jal is_leap_year
li $t0, 1
bne $t0, $v0, not_add_one_for_first
addi $s6, $s6, 1
 not_add_one_for_first:
add $s6, $s6, $s2
addi $s6, $s6, -1


######

li $s7, 0
li $t0, 2
bne $t0, $s4, not_two_in_second
addi $s7, $s7, 31
j done_this_year_for_second
not_two_in_second:
li $t0, 3
bne $t0, $s4, not_three_in_second
addi $s7, $s7, 59
j done_this_year_for_second
not_three_in_second:
li $t0, 4
bne $t0, $s4, not_four_in_second
addi $s7, $s7, 90
j done_this_year_for_second
not_four_in_second:
li $t0, 5
bne $t0, $s4, not_five_in_second
addi $s7, $s7, 120
j done_this_year_for_second
not_five_in_second:
li $t0, 6
bne $t0, $s4, not_six_in_second
addi $s7,$s7, 151
j done_this_year_for_second
not_six_in_second:
li $t0, 7
bne $t0, $s4, not_seven_in_second
addi $s7, $s7, 181
j done_this_year_for_second
not_seven_in_second:
li $t0, 8
bne $t0, $s4, not_eight_in_second
addi $s7, $s7, 212
j done_this_year_for_second
not_eight_in_second:
li $t0, 9
bne $t0, $s4, not_nine_in_second
addi $s7, $s7, 243
j done_this_year_for_second
not_nine_in_second:
li $t0, 10
bne $t0, $s4, not_ten_in_second
addi $s7, $s7, 273
j done_this_year_for_second
not_ten_in_second:
li $t0, 11
bne $t0, $s4, not_eleven_in_second
addi $s7, $s7, 304
j done_this_year_for_second
not_eleven_in_second:
li $t0, 12
bne $t0, $s4, done_this_year_for_second
addi $s7, $s7, 334

done_this_year_for_second:
li $t0, 1600	######


loop_for_second:
beq $t0, $s3, done_except_for_this_year_for_second
move $a0, $t0
addi $sp, $sp, -4
sw $t0, 0($sp)
jal is_leap_year
lw $t0, 0($sp)
addi $sp, $sp, 4
li $t1, 1
bne $t1, $v0, not_leap_year_for_second
addi $s7, $s7, 1
not_leap_year_for_second:
addi $s7, $s7, 365
addi $t0, $t0, 1
j loop_for_second

done_except_for_this_year_for_second:
li $t0, 2
ble $s4, $t0, not_add_one_for_second
move $a0, $s3
jal is_leap_year
li $t0, 1
bne $t0, $v0, not_add_one_for_second
addi $s7, $s7, 1
 not_add_one_for_second:
add $s7, $s7, $s5
addi $s7, $s7, -1

###
bgt $s6, $s7, not_valid_in_datestring
sub $v0, $s7, $s6
j done_datestring_to_num_days



not_valid_in_datestring:
li $v0, -1

done_datestring_to_num_days:

lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
lw $s4, 20($sp)
lw $s5, 24($sp)
lw $s6, 28($sp)
lw $s7, 32($sp)
addi $sp, $sp, 36
    jr $ra

sell_book:							# Part 11
lw $t0, 0($sp)
lw $t1, 4($sp)

addi $sp, $sp, -36
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $s4, 20($sp)
sw $s5, 24($sp)
sw $s6, 28($sp)
sw $s7, 32($sp)

move $s0, $a0	# sale hash
move $s1, $a1	# book hash
move $s2, $a2	# isbn 
move $s3, $a3	# customer id
move $s4, $t0	# sale_date
move $s5, $t1	# sale_price

lw $t0, 0($s0)
lw $t1, 4($s0)
bne $t0, $t1, hashtable_is_not_full_in_sell_book
li $v0, -1
li $v1, -1
j done_sell_book
hashtable_is_not_full_in_sell_book:

move $a0, $s1
move $a1, $s2
jal get_book
li $t0, -1
bne $t0, $v0, isbn_exists_in_books_in_sellbook
li $v0, -2
li $v1, -2
j done_sell_book
isbn_exists_in_books_in_sellbook:
lw $t0, 8($s1)
mul $t1, $t0, $v0
add $t1, $s1, $t1
addi $t1, $t1, 12
lw $t2, 64($t1)
addi $t2, $t2, 1
sw $t2, 64($t1)
move $a0, $s0
move $a1, $s2
move $a2, $s3
jal hash_booksale
move $s6, $v0		#s6 = index 
li $s7, 1 		# s7 = counter 

	loop_in_sell_book:
	lw $t0, 8($s0)		# t0 = element size
	mul $t0, $t0, $s6	# t0 = element size * index 
	add $t0, $t0, $s0	# t0 = starting address of element at index
	addi $t0, $t0, 12
	lbu $t1, 0($t0)
	li $t2, 0
	bne $t1, $t2, next_in_loop_in_sell_book
	##have to insert 
	move $a0, $t0
	move $a1, $s2
	li $a2, 14
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	jal memcpy
	lw $t0, 0($sp)
	addi $sp, $sp, 4
	addi $t0, $t0, 14
	li $t1, 0 
	sb $t1, 0($t0)
	sb $t1, 1($t0)
	addi $t0, $t0, 2
	sw $s3, 0($t0)
	addi $t0, $t0, 4
	move $a1, $s4
	move $s3, $t0
	addi $sp, $sp, -12
	li $t0, '1'
	sb $t0, 0($sp)
	sb $t0, 6($sp)
	sb $t0, 9($sp)
	li $t0, '6'
	sb $t0, 1($sp)
	li $t0, '0'
	sb $t0, 2($sp)
	sb $t0, 3($sp)
	sb $t0, 5($sp)
	sb $t0, 8($sp)
	li $t0, '-'
	sb $t0, 4($sp)
	sb $t0, 7($sp)
	li $t0, 0
	sb $t0, 10($sp)
	move $a0, $sp
	jal datestring_to_num_days
	addi $sp, $sp, 12
	sw $v0, 0($s3)
	addi $s3, $s3, 4
	sw $s5, 0($s3)
	lw $t0, 4($s0)
	addi $t0, $t0, 1
	sw $t0, 4($s0)
	move $v0, $s6
	move $v1, $s7
	
	j done_sell_book

	next_in_loop_in_sell_book:
	addi $s6, $s6, 1
	addi $s7, $s7, 1
	lw $t3, 0($s0) 
	div $s6, $t3
	mfhi $s6
	j loop_in_sell_book


done_sell_book:

lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
lw $s4, 20($sp)
lw $s5, 24($sp)
lw $s6, 28($sp)
lw $s7, 32($sp)
addi $sp, $sp, 36

    jr $ra

compute_scenario_revenue:
# $a0, booksale struct list 
# $a1 no of sales
# a2 scenario 
blez $a1, not_valid_in_compute_scenario
li $t0, 0		# t0 = first index
move $t1, $a1
addi $t1, $t1, -1 	# t1 = end index
li $t2, 1		# counter
li $t4, 0 			# t4 = total price
loop_in_compute_scenario_revenue:
beqz $a1, done_loop_in_compute_scenario_revenue
	addi $t5,$a1,-1 
	li $t6, 1
	sllv $t6,$t6, $t5
	and $t3, $a2, $t6	# t3 result of bitwise 
	beqz $t3, sell_left
	# sell right
	li $t7, 28
	mul $t7 ,$t7, $t1
	add $t7, $a0, $t7
	lw $t7, 24($t7)
	mul $t7, $t7, $t2
	add $t4, $t4, $t7
	addi $t1, $t1, -1
	addi $a1, $a1, -1
	addi $t2, $t2, 1
	j loop_in_compute_scenario_revenue
	sell_left:
	li $t7, 28
	mul $t7 ,$t7, $t0
	add $t7, $a0, $t7
	lw $t7, 24($t7)
	mul $t7, $t7, $t2
	add $t4, $t4, $t7
	addi $t0, $t0, 1
	addi $a1, $a1, -1
	addi $t2, $t2, 1
	j loop_in_compute_scenario_revenue


not_valid_in_compute_scenario:
li $v0, 0
j done_compute_scenario
done_loop_in_compute_scenario_revenue:
move $v0, $t4
done_compute_scenario:
    jr $ra


maximize_revenue:
addi $sp, $sp, -20
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)

move $s0, $a0 
move $s1, $a1


li $t1, 1
sllv $t1, $t1, $a1

addi $s2, $t1, -1
li $s3, 0
loop_for_maximize_revenue:
beqz $s2, done_loop_for_maximize_revenue
move $a0, $s0
move $a1, $s1
move $a2, $s2
jal compute_scenario_revenue
bgt  $s3, $v0, new_val_is_smaller_than_current 
move $s3, $v0
new_val_is_smaller_than_current :

addi $s2, $s2, -1
j loop_for_maximize_revenue
done_loop_for_maximize_revenue:
move $v0, $s3


lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
addi $sp, $sp, 20
    jr $ra

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

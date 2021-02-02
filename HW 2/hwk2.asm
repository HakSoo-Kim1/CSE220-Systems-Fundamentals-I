# Hak Soo Kim
# haksokim
# 111045936

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

############################## Do not .include any files! #############################

.text


strlen:
li $v0, 0
count_letter:
lb $t0, 0($a0)				#t2 = each char of a0
beqz $t0, strlen_done			# if t2 == 0 , done
addi $v0, $v0, 1			# t1 = t1 + 1
addi $a0, $a0, 1			# t0 = t0 + 1
j count_letter
strlen_done:
jr $ra



index_of:
addi $sp, $sp, -16	# save registers on stack
sw $s0, 0($sp)
sw $s1, 4($sp)
sw $s2, 8($sp)
sw $ra, 12($sp)		# save ra 
move $s0, $a0	# s0 has arg 0 string
move $s1, $a1	# s1 has arg 1 letter we are looking for
move $s2, $a2	# s2 has start index
jal strlen	
bge $s2, $v0, not_existing	# if starting index >= length of string
li $t0, 0
blt $s2, $t0, not_existing
move $t0, $v0 		# t0 has length of string
move $t1, $s0		# t1 has starting address of string
add $t1, $s2, $t1	# t1 has starting index + starting address of string
for_loop_for_index_of:
lb $t2, 0($t1)		# t2 = each letter 
beqz $t2, not_existing		# if t2 == 0 , not_existing
beq $s1, $t2, for_loop_index_of_done	# if each letter == given letter , index_of_done
addi $t1,$t1,1			# t1 = t1 +1
j for_loop_for_index_of
not_existing:
li $v0, -1		# v0 = -1
j index_of_done
for_loop_index_of_done:
sub $v0, $t1, $s0		# v0 = index
index_of_done:
lw $s0, 0($sp)
lw $s1, 4($sp)
lw $s2, 8($sp)
lw $ra, 12($sp)		# save ra 
addi $sp, $sp, 16	# sp = sp + 4
jr $ra




to_lowercase:
li $v0, 0 			# t1 = 0
for_loop_for_to_lowercase:
lb $t0, 0($a0)			# t2 = each char
beqz $t0, done_for_loop_for_to_lowercase
li $t1, 65				#t3 = 65
blt $t0, $t1, next_char_lowercase
li $t1, 90			# t3 = 90
bgt $t0, $t1, next_char_lowercase
addi $t0, $t0, 32		# t0 = t0 + 32 ( make lower)
sb $t0, 0($a0)			#change to lower in text
addi $v0, $v0, 1		# t1 = t1 + 1counter + 1
next_char_lowercase:
addi $a0, $a0, 1		# move to next letter
j for_loop_for_to_lowercase
  done_for_loop_for_to_lowercase:
  jr $ra
  

generate_ciphertext_alphabet:
li $v0, 0
li $t1, 0  	# t1 = 0 counter 
li $t2, 63	# t2 = 63 counter stop 
li $t3, 32	# t3 = empty
make_it_empty:
sb $t3,	0($a0)	# a0 = 0 make it empty
addi $a0, $a0, 1	# a0 = a0 + 1
addi $t1, $t1, 1	# t1 = t1 + 1
beq $t1, $t2, done_make_it_empty
j make_it_empty
done_make_it_empty:
addi $a0, $a0, -63	# original a0 address
li $t1, 0		# t1 = 0
sb $t1, 62 ($a0)	# t1[62] = 0, null terminate 
	generate_ciphertext_key_phrase_check:	#exclude space and puntuation mark
	lb $t1, 0($a1)				 # t1 = each char 
	beqz $t1, done_with_key_phrase
	li $t2, 48
	blt $t1, $t2, next_char_key_phrase
	li $t2, 58
	blt $t1, $t2, valid_char_key_phrase
	li $t2, 65
	blt $t1, $t2, next_char_key_phrase
	li $t2, 91
	blt $t1, $t2, valid_char_key_phrase
	li $t2, 97
	blt $t1, $t2, next_char_key_phrase
	li $t2, 123
	blt $t1, $t2, valid_char_key_phrase
	next_char_key_phrase:
	addi $a1, $a1 , 1		# t0 = t0 + 1
	j generate_ciphertext_key_phrase_check
	valid_char_key_phrase :
	move $t3, $a0
	check_ciphertext_alphet:
	lb $t4, 0($t3)
	li $t5, 32
	bne $t4, $t5, keep_going_valid_char_key
	sb $t1, 0($t3)
	addi $v0, $v0, 1
	j next_char_key_phrase
	keep_going_valid_char_key:
	beq $t1, $t4, next_char_key_phrase
	addi $t3, $t3, 1
	j check_ciphertext_alphet
done_with_key_phrase:
	li $t0 , 97
	li $t5, 123
start_lowercase_ciphertext:
	move $t3, $a0
add_lowercase_ciphertext:
lb $t4, 0($t3)
beq $t0, $t5, done_add_lowercase_ciphertext
bne $t0, $t4, keep_going_add_lowercase1
addi $t0, $t0, 1
j start_lowercase_ciphertext
keep_going_add_lowercase1:
li $t6, 32
bne $t4, $t6, keep_going_add_lowercase2
sb $t0, 0($t3)
addi $t0, $t0, 1
j start_lowercase_ciphertext
keep_going_add_lowercase2:
addi $t3,$t3, 1
j add_lowercase_ciphertext
done_add_lowercase_ciphertext:
li $t0 , 65
	li $t5, 91
start_capital_ciphertext:
	move $t3, $a0
add_capital_ciphertext:
lb $t4, 0($t3)
beq $t0, $t5, done_add_capital_ciphertext
bne $t0, $t4, keep_going_add_capital1
addi $t0, $t0, 1
j start_capital_ciphertext
keep_going_add_capital1:
li $t6, 32
bne $t4, $t6, keep_going_add_capital2
sb $t0, 0($t3)
addi $t0, $t0, 1
j start_capital_ciphertext
keep_going_add_capital2:
addi $t3,$t3, 1
j add_capital_ciphertext
done_add_capital_ciphertext:
li $t0 , 48
	li $t5, 58
start_digit_ciphertext:
	move $t3, $a0
add_digit_ciphertext:
lb $t4, 0($t3)
beq $t0, $t5, done_add_digit_ciphertext
bne $t0, $t4, keep_going_add_digit1
addi $t0, $t0, 1
j start_digit_ciphertext
keep_going_add_digit1:
li $t6, 32
bne $t4, $t6, keep_going_add_digit2
sb $t0, 0($t3)
addi $t0, $t0, 1
j start_digit_ciphertext
keep_going_add_digit2:
addi $t3,$t3, 1
j add_digit_ciphertext
done_add_digit_ciphertext:
  jr $ra



count_lowercase_letters:
li $v0 , 0
li $t0 , 0		#t0 = 0 
li $t1 , 0		#t1 = 0 counter
li $t2 , 26		#t2 = 26 
move $t3 , $a0		# t3 = arg 0 
make_counts_empty:
beq $t1, $t2, done_make_counts_empty  # if t1 = t2 ( done loop) , done with making empty
sw $t0 , 0 ($t3) 	# make it empty 
addi $t3 , $t3 , 4 	# t3 = t3 + 4 move to next word
addi $t1, $t1, 1	# t1 = t1 + 1 (counter + 1)
j make_counts_empty
done_make_counts_empty:
move $t0, $a1 		# t0 = arg 1

for_loop_counting_lower_case:
move $t3, $a0
lb $t1, 0($t0)		# t1 = each char of arg 1 
beqz $t1, done_counting_lower_case
li $t2, 97
blt $t1, $t2, next_lower_letter
li $t2, 122
bgt $t1, $t2, next_lower_letter 
addi $v0, $v0, 1
addi $t1, $t1, -97
li $t5, 4
mul $t1, $t5, $t1
add $t3, $t3, $t1
lw $t4, 0 ($t3)
addi $t4, $t4, 1
sw $t4, 0 ($t3)
next_lower_letter:
addi $t0, $t0,1
j for_loop_counting_lower_case
done_counting_lower_case:
    jr $ra


sort_alphabet_by_count:
addi $sp, $sp, -16	# save registers on stack
sw $s0, 0($sp)		# keep s0
sw $s1, 4($sp)		# keep s1
sw $s3, 8($sp)		# keep s7
sw $s4, 12($sp)		# keep ra 
move $s0, $a0		#s0 = address of sorted_alphabet 
move $t3, $a1		# t3 = address of counts
li $t6, 0
li $t7, 26
outter_for_loop_for_sort_alphabet:
beq $t6,$t7, done_outter_for_loop_for_sort_alphabet
li $t4, 0
li $t5, 26
lw $t2, 0 ($a1)		#t2 = first num of a1 
move $t0, $a1
move $t3, $a1
for_loop_for_sort_alphabet:
beq $t4, $t5, done_inner_for_loop_for_sort_alhpabet
lw $t1, 0($t0)	# t1 = each word of a0 
bge $t2, $t1, next_lower_letter_counts	# if max >= char at position, move next 
move $t2, $t1		# if position char is bigger than max, max = position char
move $t3, $t0		# t3 = address of max num
 next_lower_letter_counts:
 addi $t0, $t0, 4	
 addi $t4, $t4, 1
 j for_loop_for_sort_alphabet
 
 done_inner_for_loop_for_sort_alhpabet:
 sub $s1, $t3, $a1
 li $s3, 4
 div $s1, $s3
 mflo $s1
 addi $s1, $s1, 97
 sb $s1, 0 ($s0)
 addi $s0, $s0, 1
 addi $t6 , $t6, 1
 li $s4, -1
 sw $s4, 0 ($t3)
 j outter_for_loop_for_sort_alphabet
 done_outter_for_loop_for_sort_alphabet:
 li $t0 , 0
 sb $t0, 26 ($a0) 
	lw $s0, 0($sp)		# restore registers
	lw $s1, 4($sp)
	lw $s3, 8($sp)
	lw $s4, 12($sp)
	addi $sp, $sp, 16
    jr $ra


generate_plaintext_alphabet:
addi $sp, $sp, -16	# save registers on stack
sw $s0, 0($sp)		# keep s0
sw $s1, 4($sp)		# keep s1
sw $s2, 8($sp)
sw $ra, 12($sp)		# keep ra
li $t0, 0
sb $t0, 62($a0)
move $s2, $a1
move $s0, $a0
move $a0, $a1
move $a2, $t0
li $t0, 97
find_index_in_sorted_alphabet: 
li $t2, 123
beq $t0, $t2, done_generate_plain_alphabet
move $a0, $s2
move $s1, $t0
move $a1, $t0
jal index_of
move $t0, $s1
li $t1,0
beq $t1, $v0, add_9
li $t1,1
beq $t1, $v0, add_8
li $t1,2
beq $t1, $v0, add_7
li $t1,3
beq $t1, $v0, add_6
li $t1,4
beq $t1, $v0, add_5
li $t1,5
beq $t1, $v0, add_4
li $t1,6
beq $t1, $v0, add_3
li $t1,7
beq $t1, $v0, add_2
sb $t0, 0($s0)
addi $t0, $t0, 1
addi $s0, $s0, 1 
j find_index_in_sorted_alphabet

add_9:
li $t3, 0
li $t4, 9
add_9_loop:
beq $t3, $t4,  done_add_9_loop
sb $t0, 0($s0)
addi $s0,$s0,1
addi $t3, $t3, 1
j add_9_loop
done_add_9_loop:
addi $t0, $t0, 1
j  find_index_in_sorted_alphabet

add_8:
li $t3, 0
li $t4, 8
add_8_loop:
beq $t3, $t4,  done_add_8_loop
sb $t0, 0($s0)
addi $s0,$s0,1
addi $t3, $t3, 1
j add_8_loop
done_add_8_loop:
addi $t0, $t0, 1
j  find_index_in_sorted_alphabet

add_7:
li $t3, 0
li $t4, 7
add_7_loop:
beq $t3, $t4,  done_add_7_loop
sb $t0, 0($s0)
addi $s0,$s0,1
addi $t3, $t3, 1
j add_7_loop
done_add_7_loop:
addi $t0, $t0, 1
j  find_index_in_sorted_alphabet

add_6:
li $t3, 0
li $t4, 6
add_6_loop:
beq $t3, $t4,  done_add_6_loop
sb $t0, 0($s0)
addi $s0,$s0,1
addi $t3, $t3, 1
j add_6_loop
done_add_6_loop:
addi $t0, $t0, 1
j  find_index_in_sorted_alphabet

add_5:
li $t3, 0
li $t4, 5
add_5_loop:
beq $t3, $t4,  done_add_5_loop
sb $t0, 0($s0)
addi $s0,$s0,1
addi $t3, $t3, 1
j add_5_loop
done_add_5_loop:
addi $t0, $t0, 1
j  find_index_in_sorted_alphabet

add_4:
li $t3, 0
li $t4, 4
add_4_loop:
beq $t3, $t4,  done_add_4_loop
sb $t0, 0($s0)
addi $s0,$s0,1
addi $t3, $t3, 1
j add_4_loop
done_add_4_loop:
addi $t0, $t0, 1
j  find_index_in_sorted_alphabet

add_3:
li $t3, 0
li $t4, 3
add_3_loop:
beq $t3, $t4,  done_add_3_loop
sb $t0, 0($s0)
addi $s0,$s0,1
addi $t3, $t3, 1
j add_3_loop
done_add_3_loop:
addi $t0, $t0, 1
j  find_index_in_sorted_alphabet

add_2:
li $t3, 0
li $t4, 2
add_2_loop:
beq $t3, $t4,  done_add_2_loop
sb $t0, 0($s0)
addi $s0,$s0,1
addi $t3, $t3, 1
j add_2_loop
done_add_2_loop:
addi $t0, $t0, 1
j  find_index_in_sorted_alphabet

done_generate_plain_alphabet:
lw $s0, 0($sp)		# restore registers
lw $s1, 4($sp)
lw $s2, 8($sp)
lw $ra, 12($sp)
addi $sp, $sp, 16
    jr $ra
   

encrypt_letter:
li $t0, 97
blt $a0, $t0, not_valid_plaintext_letter
li $t0, 122
bgt $a0, $t0, not_valid_plaintext_letter
move $t6, $a0 
move $t7, $a1
move $t8, $a2

addi $sp, $sp, -16	# save registers on stack
sw $s0, 0($sp)		# keep s0
sw $s1, 4($sp)		# keep s1
sw $s2, 8($sp)		# keep s7
sw $ra, 12($sp)		# keep ra 
move $s0 , $a0		# s0 = arg 0
move $s1, $a1		# s1 = arg 1
move $s2, $a2		# s2 = arg 2
    move $a0, $s2	# a0 = s2 ( arg 2)
    move $a1, $s0	# a1 = s0 ( arg 0)
    li $a2, 0
    jal index_of
    move $t5, $v0	# v0 = index of first appear of char  t5 = v0
    add $s2, $s2, $v0	# s2 = address of first appear 
    li $t1, 0
    for_loop_for_how_many_char_:
    lb $t2, 0($s2)
    bne $t2, $s0 ,done_for_loop_for_how_many_char
    addi $t1, $t1 , 1
    addi $s2, $s2, 1
    j for_loop_for_how_many_char_
    done_for_loop_for_how_many_char:
    div $s1, $t1
    mfhi $t3
    add $t3,$t5,$t3
    add $t3, $a3, $t3
    lb $t4, 0($t3)
    move $v0, $t4
   	lw $s0, 0($sp)		# restore registers
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	j skip_not_valid_plaintext_letter
	not_valid_plaintext_letter:
	li $v0, -1
    skip_not_valid_plaintext_letter:
    jr $ra









encrypt:	# a0 ciphertext storage, a1 plaintext to be conveted , a2 keyphrase , a3 corpus
addi $sp, $sp, -36	# save registers on stack
sw $s0, 0($sp)			#save s0 
sw $s1, 4($sp)
sw $s2, 8($sp)
sw $s3, 12($sp)
sw $s4, 16($sp)
sw $s5, 20($sp)
sw $s6, 24($sp)
sw $fp, 28 ($sp)
sw $ra, 32($sp)			#save ra 

move $s0, $a0
move $s1, $a1
move $s2, $a2
move $s3, $a3

move $a0, $a1		# make plain yext lower 
jal to_lowercase
move $a0, $s1
jal strlen
move $s6, $v0
move $a0, $s3		# make corpus lower
jal to_lowercase

addi $sp, $sp, -112		# make a space 112 bytes for count
move $a0, $sp 			
move $a1, $s3
jal count_lowercase_letters
move $a1, $sp
addi $sp, $sp, -28
move $a0,$sp
jal sort_alphabet_by_count

move $a1, $sp
addi $sp, $sp, -64
move $a0, $sp
jal generate_plaintext_alphabet

move $fp ,$sp
addi $sp, $sp, -64
move $a0, $sp
move $a1, $s2
jal generate_ciphertext_alphabet
li $s4, 0
li $s5, 0
loop_for_ciphertext: 
lb $t2, 0($s1)
beqz $t2, done_loop_for_ciphertext
li $t1, 97
blt $t2, $t1, should_not_be_encrypted
li $t1, 122
bgt $t2, $t1, should_not_be_encrypted
move $a0, $t2
move $a1, $s4
move $a2, $fp
move $a3, $sp
addi $s5, $s5, 1
jal encrypt_letter
move $t2, $v0
should_not_be_encrypted:
sb $t2, 0($s0)
addi $s1, $s1, 1
addi $s0, $s0, 1
addi $s4, $s4, 1
j loop_for_ciphertext

done_loop_for_ciphertext:
li $t0,0
sb $t0, 0($s0)
move $v0,$s5 
sub $v1, $s6, $s5
addi $sp, $sp, 268
		# save registers on stack
lw $s0, 0($sp)			#save s0 
lw $s1, 4($sp)
lw $s2, 8($sp)
lw $s3, 12($sp)
lw $s4, 16($sp)
lw $s5, 20($sp)
lw $s6, 24($sp)
lw $fp, 28 ($sp)
lw $ra, 32($sp)			#save ra 
addi $sp, $sp, 36
jr $ra 





decrypt:

addi $sp, $sp, -32	# save registers on stack
sw $s0, 0($sp)			#save s0 
sw $s1, 4($sp)
sw $s2, 8($sp)
sw $s3, 12($sp)
sw $s4,	16($sp) 
sw $s5, 20($sp)
sw $fp, 24($sp)
sw $ra, 28($sp)

move $s0, $a0
move $s1, $a1
move $s2, $a2
move $s3, $a3

move $a0, $a3

jal to_lowercase

move $a0, $s1
jal strlen
move $s4, $v0

addi $sp, $sp, -112		# make a space 112 bytes for count
move $a0, $sp 			
move $a1, $s3
jal count_lowercase_letters

move $a1, $sp
addi $sp, $sp, -28
move $a0, $sp
jal sort_alphabet_by_count

move $a1, $sp
addi $sp, $sp, -64
move $a0, $sp
jal generate_plaintext_alphabet

move $fp ,$sp
addi $sp, $sp, -64
move $a0, $sp
move $a1, $s2
jal generate_ciphertext_alphabet

li $s5, 0
decrypt_for_loop:
lb $t0, 0($s1)
beqz $t0, done_decrypt_for_loop
li $t1, 48
blt $t0, $t1, should_not_be_decrypted
li $t1, 58
blt $t0, $t1, should_be_decrypted
li $t1, 65
blt $t0, $t1, should_not_be_decrypted
li $t1, 91
blt $t0, $t1, should_be_decrypted
li $t1, 97
blt $t0, $t1, should_not_be_decrypted
li $t1, 123
blt $t0, $t1, should_be_decrypted
j should_not_be_decrypted
should_be_decrypted:
move $a0, $sp
move $a1, $t0
jal index_of
move $t0, $v0
add $t0, $fp, $t0
lb $t0, 0($t0)
addi $s5, $s5, 1
should_not_be_decrypted:
sb $t0, 0($s0)
addi $s0, $s0, 1
addi $s1, $s1, 1
j decrypt_for_loop
done_decrypt_for_loop:
li $t0, 0
sb $t0, 0($s0)

addi $sp, $sp, 268
move $v0,$s5
sub $v1, $s4, $s5

lw $s0, 0($sp)			#save s0 
lw $s1, 4($sp)
lw $s2, 8($sp)
lw $s3, 12($sp)
lw $s4,	16($sp) 
lw $s5, 20($sp)
lw $fp, 24($sp)
lw $ra, 28($sp)
addi $sp, $sp, 32	# save registers on stack
    jr $ra
    
    

############################## Do not .include any files! #############################

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

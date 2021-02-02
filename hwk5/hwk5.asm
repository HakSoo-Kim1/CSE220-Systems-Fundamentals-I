# Hak Soo Kim
# haksokim
# 111045936

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

.text

init_list:							# Part 1
li $t0, 0
sw $t0, 0($a0)
sw $t0, 4($a0)

   jr $ra

append_card:							# Part 2
addi $sp, $sp, -8
sw $s0, 0($sp)
sw $s1, 4($sp)

move $s0, $a0
move $s1, $a1

li $a0, 8
li $v0, 9
syscall
sw $s1, 0($v0)
li $t0, 0
sw $t0, 4($v0)

lw $t1, 4($s0)
bnez $t1, not_empty_in_append_card 
sw $v0, 4($s0)
j done_append_card

not_empty_in_append_card :
loop_for_finding_last_card_in_append_card:
lw $t3, 4($t1)
beqz $t3, done_loop_for_finding_last_card_in_append_card
lw $t1, 4($t1)
j loop_for_finding_last_card_in_append_card		
								
done_loop_for_finding_last_card_in_append_card:
sw $v0, 4($t1) 

done_append_card:
lw $t0, 0($s0)
addi $t0, $t0, 1
sw $t0, 0($s0)
move $v0, $t0

lw $s0, 0($sp)
lw $s1, 4($sp)
addi $sp, $sp, 8

   jr $ra

create_deck:								# Part 3
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
 


li $a0, 8
li $v0, 9
syscall

move $s0, $v0
move $a0, $s0
jal init_list

li $s1, 8
loop_for_create_deck:
beqz $s1, done_loop_for_create_deck

li $a1, 0x00645330
move $a0, $s0
jal append_card

li $a1, 0x00645331
move $a0, $s0
jal append_card

li $a1, 0x00645332
move $a0, $s0
jal append_card

li $a1, 0x00645333
move $a0, $s0
jal append_card

li $a1, 0x00645334
move $a0, $s0
jal append_card

li $a1, 0x00645335
move $a0, $s0
jal append_card

li $a1, 0x00645336
move $a0, $s0
jal append_card

li $a1, 0x00645337
move $a0, $s0
jal append_card

li $a1, 0x00645338
move $a0, $s0
jal append_card

li $a1, 0x00645339
move $a0, $s0
jal append_card

addi $s1, $s1, -1

j loop_for_create_deck


done_loop_for_create_deck:

move $v0, $s0


lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
addi $sp, $sp, 12

   jr $ra


draw_card_from_deck: 						# helper for Part 4 
# deck is given, return card (remove one card)
lw $t0, 4($a0)	# t0 = address of head card 
lw $v0, 0($t0)	# v0 = int of head card
lw $t0, 4($t0) 	# t0 = address of second card 
sw $t0, 4($a0)	# new deck head = second card 
lw $t0, 0($a0)	
addi $t0, $t0, -1
sw $t0, 0($a0)	# decrease one 
	jr $ra

deal_starting_cards:						# Part 4
addi $sp, $sp, -28
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $s4, 20($sp)
sw $s5, 24($sp)

move $s0, $a0		# s0 = list of empty boards
move $s1, $a1 		# s1 = deck 

li $s2, 0		# counter for num of cards
li $s3, 35		# counter max

li $s4, 9		# s4 = 9
li $s5, 4		# s5 = 4


loop_for_first_35d_in_deal_starting_cards:
beq $s2, $s3, done_loop_for_first_35d_in_deal_starting_cards		# branch if done 35 cards

move $a0, $s1		# fraw one card 
jal draw_card_from_deck
# v0 = int of card withdraw

div $s2, $s4	
mfhi $t0		
mul $t0, $s5, $t0	# t0 = index of empty card list 
add $t0, $s0, $t0	# address of card list that we need to put the card
lw $a0, 0($t0)
move $a1, $v0
jal append_card

addi $s2, $s2, 1 

j loop_for_first_35d_in_deal_starting_cards

done_loop_for_first_35d_in_deal_starting_cards:

move $a0, $s1
jal draw_card_from_deck
li $t0, 0x110000
add $v0, $v0, $t0

addi $t0, $s0, 32 # address of 8th empty link
lw $a0, 0($t0)
move $a1, $v0
jal append_card


move $a0, $s1
jal draw_card_from_deck
li $t0, 0x110000
add $v0, $v0, $t0

addi $t0, $s0, 0 # address of 0th empty link
lw $a0, 0($t0)
move $a1, $v0
jal append_card

move $a0, $s1
jal draw_card_from_deck
li $t0, 0x110000
add $v0, $v0, $t0

addi $t0, $s0, 4 # address of 1th empty link
lw $a0, 0($t0)
move $a1, $v0
jal append_card

move $a0, $s1
jal draw_card_from_deck
li $t0, 0x110000
add $v0, $v0, $t0

addi $t0, $s0, 8 # address of 2th empty link
lw $a0, 0($t0)
move $a1, $v0
jal append_card

move $a0, $s1
jal draw_card_from_deck
li $t0, 0x110000
add $v0, $v0, $t0

addi $t0, $s0, 12 # address of 3rd empty link
lw $a0, 0($t0)
move $a1, $v0
jal append_card

move $a0, $s1
jal draw_card_from_deck
li $t0, 0x110000
add $v0, $v0, $t0

addi $t0, $s0, 16 # address of 4th empty link
lw $a0, 0($t0)
move $a1, $v0
jal append_card

move $a0, $s1
jal draw_card_from_deck
li $t0, 0x110000
add $v0, $v0, $t0

addi $t0, $s0, 20 # address of 5th empty link
lw $a0, 0($t0)
move $a1, $v0
jal append_card

move $a0, $s1
jal draw_card_from_deck
li $t0, 0x110000
add $v0, $v0, $t0

addi $t0, $s0, 24 # address of 6th empty link
lw $a0, 0($t0)
move $a1, $v0
jal append_card

move $a0, $s1
jal draw_card_from_deck
li $t0, 0x110000
add $v0, $v0, $t0

addi $t0, $s0, 28 # address of 7th empty link
lw $a0, 0($t0)
move $a1, $v0
jal append_card



lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
lw $s4, 20($sp)
lw $s5, 24($sp)
addi $sp, $sp, 28


   jr $ra

get_card:						 	# Part 5

bgez $a1, index_greater_or_equal_zero 
li $v0, -1
li $v1, -1
j done_get_card
index_greater_or_equal_zero :
lw $t0, 0($a0)
blt $a1, $t0, valid_index_in_get_card
li $v0, -1
li $v1, -1
j done_get_card
valid_index_in_get_card:

lw $t0, 4($a0)
loop_in_get_card:
beqz $a1, done_loop_in_get_card
lw $t0, 4($t0)
addi $a1, $a1, -1

j loop_in_get_card

done_loop_in_get_card:
lw $v1, 0($t0)
li $t0, 0x00750000
and $t1, $v1, $t0
beq $t0, $t1, face_up_in_get_card
li $v0, 1
j done_get_card
face_up_in_get_card:
li $v0, 2



done_get_card:
    jr $ra

check_move:
addi $sp, $sp, -36							# Part 6
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $s4, 20($sp)
sw $s5, 24($sp)
sw $s6, 28($sp)
sw $s7, 32($sp)


move $s4, $a0
move $s5, $a1
li $t0, 0xFF000000
and $s3, $t0, $a2
srl $s3, $s3, 24
li $t0, 0x00FF0000
and $s2, $t0, $a2
srl $s2, $s2, 16
li $t0, 0x0000FF00
and $s1, $t0, $a2
srl $s1, $s1, 8
li $t0, 0x000000FF
and $s0, $t0, $a2

li $t0, 0						
beq $t0, $s3, not_deal_move_in_check_move	# branch if byte 3 is 0 meaning not deal move
li $t0, 1		# possibly deal move
beq $t0, $s3, byte_3_is_1_check_move	# branch if byte 3 is 1
li $v0, -1	# byte 3 is neither 0 nor 1
j done_check_move
														##### maybe better way
byte_3_is_1_check_move:	# byte 3 is 1
li $t0, 0
beq $t0, $s0, byte_0_is_0	# branch if byte 0 is 0
li $v0, -1	# byte 0 is not 0
j done_check_move

byte_0_is_0:	# 1 X X 0
beq $t0, $s1, byte_1_is_0	# branch if byte 1 is 0
li $v0, -1
j done_check_move

byte_1_is_0:	# 1 X 0 0
beq $t0, $s2, byte_2_is_0
li $v0, -1
j done_check_move

byte_2_is_0: # 1 0 0 0
lw $t1, 0($s5)
bgt $t1, $t0, deck_not_empty_in_check_move
li $v0, -2
j done_check_move

deck_not_empty_in_check_move:	# deck not empty, # check if any column is empty
lw $t1, 0($s4) 		 
lw $t1, 0($t1)	# t1 = first column size 
bgt $t1, $t0, first_coulmn_not_empty
li $v0, -2
j done_check_move

first_coulmn_not_empty:
lw $t1, 4($s4) 		 
lw $t1, 0($t1)	# t1 = second column size 
bgt $t1, $t0, second_coulmn_not_empty
li $v0, -2
j done_check_move

second_coulmn_not_empty:
lw $t1, 8($s4) 		 
lw $t1, 0($t1)	# t1 = third column size 
bgt $t1, $t0, thrid_coulmn_not_empty
li $v0, -2
j done_check_move

thrid_coulmn_not_empty:
lw $t1, 12($s4) 		 
lw $t1, 0($t1)	# t1 =  fourth column size 
bgt $t1, $t0, fourth_coulmn_not_empty
li $v0, -2
j done_check_move

fourth_coulmn_not_empty:
lw $t1, 16($s4) 		 
lw $t1, 0($t1)	# t1 =  fifth column size 
bgt $t1, $t0, fifth_coulmn_not_empty
li $v0, -2
j done_check_move

fifth_coulmn_not_empty:
lw $t1, 20($s4) 		 
lw $t1, 0($t1)	# t1 =  sixth column size 
bgt $t1, $t0, sixth_coulmn_not_empty
li $v0, -2
j done_check_move

sixth_coulmn_not_empty:
lw $t1, 24($s4) 		 
lw $t1, 0($t1)	# t1 =  seventh column size 
bgt $t1, $t0, seventh_coulmn_not_empty
li $v0, -2
j done_check_move

seventh_coulmn_not_empty:
lw $t1, 28($s4) 		 
lw $t1, 0($t1)	# t1 =  eigth column size 
bgt $t1, $t0, eigth_coulmn_not_empty
li $v0, -2
j done_check_move

eigth_coulmn_not_empty:
lw $t1, 32($s4) 		 
lw $t1, 0($t1)	# t1 =  ninth column size 
bgt $t1, $t0, valid_legal_deal_move
li $v0, -2
j done_check_move

valid_legal_deal_move:
li $v0, 1
j done_check_move



not_deal_move_in_check_move:	#byte 3 is 0 meaning regular move
bgez $s0, donor_column_greater_zero
li $v0, -3
j done_check_move

donor_column_greater_zero:
bgez $s2, recipient_column_greater_zero
li $v0, -3
j done_check_move

recipient_column_greater_zero:	# recipient and donor greater or equal than zero, now have to check if it's smaller than 9 
li $t0, 9
blt $s0, $t0, donor_column_less_9
li $v0, -3
j done_check_move

donor_column_less_9:
blt $s2, $t0, recipient_column_less_9
li $v0, -3
j done_check_move

recipient_column_less_9:	# recipient and donor is in valid range, now have to check if row is in valid range
bgez $s1, row_greater_zero
li $v0, -4
j done_check_move

row_greater_zero:
li $t0, 4
mul $t0, $s0, $t0	# s0 = index of column     so t0 = where the card list in board
add $t0, $t0, $s4	# t0 = address of card list column
lw $t1, 0($t0) 	# t1 = address of card list
lw $t2, 0($t1)	# t2 =   x th column size 
blt $s1, $t2, valid_row_range 
li $v0, -4
j done_check_move

valid_row_range :
bne $s0, $s2, different_recipient_donor_column
li $v0, -5
j done_check_move

different_recipient_donor_column:
move $a0, $t1	# currently t1 = address of given index coulmn
move $s6, $t1	# s6 = t1 (address of given index column)
move $a1, $s1	# a1 = row index
jal get_card
li $t0, 2
beq $t0, $v0, given_row_card_face_up
li $v0, -6
j done_check_move

given_row_card_face_up:
lw $t0, 4($s6)	# t0 = head of column 
move $t1, $s1  # t1 = index of row
loop_in_given_row_card_face_up:	# now lets check if donor column under row is descending
beqz $t1, done_loop_in_given_row_card_face_up
lw $t0, 4($t0)
addi $t1, $t1, -1
j loop_in_given_row_card_face_up
done_loop_in_given_row_card_face_up:
# now t0 = card at given row
lbu $s7, 0($t0)			# s7 = card number at index
loop_for_checking_descending:
lw $t1, 4($t0) 
beqz $t1, done_loop_for_checking_descending
lbu $t2, 0($t0)	# t2 = digit of index at row
lbu $t3, 0($t1)	# t3 = next row digit
addi $t2, $t2, -1
beq $t2, $t3, checking_next_row_in_for_cecking_descending
li $v0, -7
j done_check_move
 checking_next_row_in_for_cecking_descending:
lw $t0, 4($t0)
j loop_for_checking_descending

 done_loop_for_checking_descending:	# now donor column is all set and valid
 li $t0, 4					# have to check if receipient is valid
 mul $t0, $s2, $t0
 add $t0, $t0, $s4
 lw $t1, 0($t0)		#t1 = address of recipient column 
lw $t2, 0($t1)		# t2 = size of recipient column
bnez $t2, recipient_column_not_empty
li $v0, 2
j done_check_move
recipient_column_not_empty:
addi $t2, $t2, -1
move $a0, $t1
move $a1, $t2
jal get_card
li $t1, 0x000000FF
and $t0, $t1, $v1
# lbu $t0, 0($v1)
addi $t0, $t0, -1
beq $t0, $s7, valid_recipient_column
li $v0, -8
j done_check_move
valid_recipient_column:
li $v0, 3
j done_check_move

 

done_check_move:

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


clear_full_straight:				# Part 7
addi $sp, $sp, -24
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $s4, 20($sp)

bgez $a1, column_greater_equal_zero_in_clear_full
li $v0, -1
j done_clear_full_straight

column_greater_equal_zero_in_clear_full:
li $t0, 9
blt $a1, $t0, valid_column_range_in_clear_full
li $v0, -1
j done_clear_full_straight

valid_column_range_in_clear_full:
sll $t0, $a1, 2
add $t0, $t0, $a0
lw $t0, 0($t0)		# t0 = starting address of board[column]
lw $t1, 0($t0)		# t1 = size of board[column]
li $t3, 10
bge $t1, $t3, board_has_more_10_in_clear_full
li $v0, -2 
j done_clear_full_straight



board_has_more_10_in_clear_full:	#now find 10 first 
move $s0, $a0	# s0 = board
move $s1, $t0	# s1 = starting address of board[column]
li $s2, 0	# s2 = 0   (counter)
move $s3, $t1	# s3 = size of board[column]
li $s4, 0x00755339

loop_for_finding_face_up_10:
bne $s2, $s3, keep_looping_to_find_face_up_10
li $v0, -3
j done_clear_full_straight

keep_looping_to_find_face_up_10:
move $a0, $s1	# a0 = address of board[column]
move $a1, $s2	# a1 = index from 0 to going over
jal get_card
beq $v1, $s4, done_loop_for_finding_face_up_10
addi $s2, $s2, 1
j loop_for_finding_face_up_10

done_loop_for_finding_face_up_10:	#s2 = index of where 10 face up start 
move $t0, $s2	# t0 = index of 10 face up
lw $t1, 4($s1)	# t1 = head address of bpard[column] 
loop_for_getting_address_of_face_up_10:
beqz $t0, done_loop_for_getting_address_of_face_up_10
lw $t1, 4($t1)
addi $t0, $t0, -1
j loop_for_getting_address_of_face_up_10


done_loop_for_getting_address_of_face_up_10:	# t1 = address of 10 face up in column
move $t0, $t1
li $t4, 9
loop_for_checking_decreasing:
beqz $t4, done_loop_for_checking_decreasing
lw $t1, 4($t0)			# t1 = next address
bnez $t1, keep_moving_in_checking_decreasing
li $v0, -3
j done_clear_full_straight
keep_moving_in_checking_decreasing:
lw $t2, 0($t0)	# card num at current address
lw $t3, 0($t1)	# card num at next address				###########
bne $t3, $s4, keep_goin_for_checking_decreasing	# if there is one more 10 u 
li $t5, 9
sub $t7,$t5, $t4
add $s2, $s2, $t7
addi $s2, $s2, 1
li $t4, 9
move $t0, $t1
j loop_for_checking_decreasing
keep_goin_for_checking_decreasing:
addi $t2, $t2, -1
beq $t2, $t3, check_next_card_in_loop_for_checking_decreasing
li $v0, -3
j done_clear_full_straight
check_next_card_in_loop_for_checking_decreasing:
lw $t0, 4($t0)
addi $t4, $t4, -1
j loop_for_checking_decreasing

done_loop_for_checking_decreasing:
lw $t0, 4($t0)
beqz $t0, no_card_after_full_straight
li $v0, -3
j done_clear_full_straight

no_card_after_full_straight:
beqz $s2, leaving_the_column_empty_in_clear_full
li $v0, 1
lw $t0, 0($s1)
addi $t0, $t0, -10
sw $t0, 0($s1)
addi $s2, $s2, -1
lw $t0, 4($s1)	# t0 = head address
loop_for_finding_previous_card_of_face_up_10:
beqz $s2, done_loop_for_finding_previous_card_of_face_up_10
lw $t0, 4($t0)
addi $s2, $s2, -1
j loop_for_finding_previous_card_of_face_up_10
done_loop_for_finding_previous_card_of_face_up_10:
li $t1 , 0
sw $t1, 4($t0)
lw $t1, 0($t0)
li $t2, 0x00750000
and $t1, $t2, $t1	# if previous card is up, 0x0075 , not 0x0065
beq $t2, $t1, already_face_up
lw $t1, 0($t0)
li $t2,  0x00110000
add $t1, $t2, $t1
sw $t1, 0($t0)
already_face_up:	


j done_clear_full_straight


 leaving_the_column_empty_in_clear_full:
li $t0, 0			 # s1 = starting address of board[column]
sw $t0, 0($s1)
sw $t0, 4($s1)
 
 li $v0, 2


done_clear_full_straight:


lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
lw $s4, 20($sp)
addi $sp, $sp, 24
    jr $ra

deal_move:

addi $sp, $sp, -16
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)

move $s0, $a0
move $s1, $a1
li $s2, 9


loop_for_deal_move:
beqz $s2, done_deal_move
move $a0, $s1
jal draw_card_from_deck
li $t0, 0x110000
add $v0, $v0, $t0

lw $a0, 0($s0)
move $a1, $v0
jal append_card

addi $s0, $s0, 4
addi $s2, $s2, -1
j loop_for_deal_move


done_deal_move:
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
addi $sp, $sp, 16
    jr $ra

move_card:							# Part 9 
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

move $s0, $a0
move $s1, $a1
move $s2, $a2

li $t0, 0x00FF0000
and $s5, $t0, $a2
srl $s5, $s5, 16
li $t0, 0x0000FF00
and $s4, $t0, $a2
srl $s4, $s4, 8
li $t0, 0x000000FF
and $s3, $t0, $a2


jal check_move

li $t0, 1
bne $t0, $v0, not_deal_move_in_move_card
move $a0, $s0	# deal move 
move $a1, $s1	
jal deal_move	#execute dealmove 

li $s3, 8
loop_for_clear_full_in_deal_move:	# check if any full straight on every column
bltz $s3, done_loop_for_clear_full_in_deal_move
move $a0, $s0
move $a1, $s3
jal clear_full_straight
addi $s3, $s3, -1
j loop_for_clear_full_in_deal_move

done_loop_for_clear_full_in_deal_move:
li $v0, 1
j done_move_card


not_deal_move_in_move_card:
li $t0, 2
bne $v0, $t0, legal_move_recipient_non_empty_	
bnez $s4, move_some_of_donor_to_empty		#  from here legal move recipient empty 
# now legal move recipient empty and move all of donor
sll $t0, $s3, 2	
add $t0, $t0, $s0	
lw $t0, 0($t0)	# t0 = starting address of donor column 
lw $t1, 0($t0)	# t1 = size of donor column
lw $t2, 4($t0)	# t2 = first head address of donor column
		
sll $t3, $s5, 2
add $t3, $t3, $s0
lw $t3, 0($t3)	# t3 = starting address of recipient column
sw $t1, 0($t3)	###	
sw $t2, 4($t3)  ###

li $t1, 0	# make donor empty 
sw $t1, 0($t0)
sw $t1, 4($t0)



li $t0, 0x00FF0000
and $s5, $t0, $s2
srl $s5, $s5, 16
move $a0, $s0
move $a1, $s5
jal clear_full_straight



li $v0, 1
j done_move_card

move_some_of_donor_to_empty:

sll $t0, $s3, 2	
add $t0, $t0, $s0	
lw $t0, 0($t0)	# t0 = starting address of  donor column 
move $s7, $t0	
lw $s6, 0($t0)	# s6 = size of donor column
lw $t1, 4($t0)	# t1 = head address of donor column

addi $t2, $s4, -1  # t1= index of one previous card of row 

loop_for_finding_previous_card_in_move_some_of_donor_to_empty:
beqz $t2, done_loop_for_finding_previous_card_in_move_some_of_donor_to_empty
lw $t1, 4($t1)
addi $t2, $t2, -1
j loop_for_finding_previous_card_in_move_some_of_donor_to_empty

done_loop_for_finding_previous_card_in_move_some_of_donor_to_empty:
li $t6, 0x00750000
lw $t7, 0($t1)	# t7 = number of previous card
and $t7, $t6, $t7	# if previous card is up, 0x0075 , not 0x0065
beq $t6, $t7, already_face_up_in_move_some_of_donor_to_empty
lw $t7, 0($t1)
li $t6,  0x00110000
add $t7, $t6, $t7
sw $t7, 0($t1)
already_face_up_in_move_some_of_donor_to_empty:	
sll $t2, $s5, 2		# now t1 has addess of previous card of row  in donor clumn
add $t2, $t2, $s0	
lw $t2, 0($t2)	# t2 = starting address of recipient column 
lw $t3, 4($t1)	# t3 = row card address of donor column
sw $t3, 4($t2)	# now empty column start pointing row 
li $t4, 0
sw $t4, 4($t1)
sub $s6, $s6, $s4	# s7 = donor column size - row
sw $s6, 0($t2)
sw $s4, 0($s7)



li $t0, 0x00FF0000
and $s5, $t0, $s2
srl $s5, $s5, 16
move $a0, $s0
move $a1, $s5
jal clear_full_straight


li $v0, 1
j done_move_card



legal_move_recipient_non_empty_:
li $t0, 3	
bne $v0, $t0, errors_in_move_card	# branch if any error ( not 1 , 2 ,3 )
bnez $s4, move_some_of_donor_to_nonempty		#  from here legal move and recipient nonempty 

# now legal move recipient non empty and move all of donor
sll $t0, $s3, 2	
add $t0, $t0, $s0	
lw $t0, 0($t0)	# t0 = starting address of donor column 
lw $t1, 0($t0)	# t1 = size of donor column
lw $t2, 4($t0)	# t2 = first head address of donor column
		
sll $t3, $s5, 2
add $t3, $t3, $s0
lw $t3, 0($t3)	# t3 = starting address of recipient column
lw $t4, 4($t3)	# t4 = head address of recipipie
lw $t5, 0($t3)  # t5 = size of recipient column
addi $t6, $t5 ,-1

loop_for_finding_last_card_in_move_all_of_donor_to_non_empty:
beqz $t6, done_loop_for_finding_last_card_in_move_all_of_donor_to_non_empty
lw $t4, 4($t4)
addi $t6, $t6, -1
j loop_for_finding_last_card_in_move_all_of_donor_to_non_empty
done_loop_for_finding_last_card_in_move_all_of_donor_to_non_empty:
sw $t2, 4($t4)			#now t4 has last card on recipient column , connect last card to head of donor column 
add $t5, $t5, $t1 	# add each column size
sw $t5, 0($t3)	# adjust recipient column size
li $t1, 0
sw $t1, 0($t0)	# donor empty
sw $t1, 4($t0)	# donor empty



li $t0, 0x00FF0000
and $s5, $t0, $s2
srl $s5, $s5, 16

move $a0, $s0
move $a1, $s5
jal clear_full_straight



li $v0, 1
j done_move_card

move_some_of_donor_to_nonempty:

sll $t0, $s3, 2	
add $t0, $t0, $s0	
lw $t0, 0($t0)	# t0 = starting address of  donor column 
move $s7, $t0	# keep s7 to starting address of donor column
lw $s6, 0($t0)	# s6 = size of donor column
lw $t1, 4($t0)	# t1 = head address of donor column

addi $t2, $s4, -1  # t1= index of one previous card of row 

loop_for_finding_previous_card_in_move_some_of_donor_to_non_empty:
beqz $t2, done_loop_for_finding_previous_card_in_move_some_of_donor_to_non_empty
lw $t1, 4($t1)
addi $t2, $t2, -1
j loop_for_finding_previous_card_in_move_some_of_donor_to_non_empty

done_loop_for_finding_previous_card_in_move_some_of_donor_to_non_empty:
li $t6, 0x00750000
lw $t7, 0($t1)	# t7 = number of previous card
and $t7, $t6, $t7	# if previous card is up, 0x0075 , not 0x0065
beq $t6, $t7, already_face_up_in_move_some_of_donor_to_non_empty
lw $t7, 0($t1)
li $t6,  0x00110000
add $t7, $t6, $t7
sw $t7, 0($t1)
already_face_up_in_move_some_of_donor_to_non_empty:	
sll $t2, $s5, 2		# now t1 has addess of previous card of row  in donor clumn
add $t2, $t2, $s0	
lw $t2, 0($t2)	# t2 = starting address of recipient column 
move $t8, $t2
lw $t3, 4($t2) 	# t3 = head address of recipient column
lw $t4, 0($t2)	# t4 = size of recipient column 
addi $t5, $t4 ,-1

loop_for_finding_last_card_in_move_some_of_donor_to_non_empty:
beqz $t5, done_loop_for_finding_last_card_in_move_some_of_donor_to_non_empty
lw $t3, 4($t3)
addi $t5, $t5, -1
j loop_for_finding_last_card_in_move_some_of_donor_to_non_empty
done_loop_for_finding_last_card_in_move_some_of_donor_to_non_empty: 
lw $t5, 4($t1) 		# t5 = address of row card in donor column  //#now t3 has last card on recipient column 
sw $t5, 4($t3)			
li $t0, 0
sw $t0, 4($t1)	# delink the previous card of row  in donor clumn
sub $s6, $s6, $s4
sw $s4, 0($s7)
lw $t0, 0($t8)	# t0 = size of recipient column
add $t0, $s6, $t0
sw $t0, 0($t8)



li $t0, 0x00FF0000
and $s5, $t0, $s2
srl $s5, $s5, 16

move $a0, $s0
move $a1, $s5
jal clear_full_straight



li $v0, 1
j done_move_card




errors_in_move_card:
li $v0, -1

done_move_card:
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

load_game:
addi $sp, $sp, -32
sw $ra, 0($sp)
sw $s1, 4($sp)
sw $s2, 8($sp)
sw $s3, 12($sp)
sw $s4, 16($sp)
sw $s5, 20($sp)
sw $s6, 24($sp)
sw $s7, 28($sp)



move $s1, $a1	# s1 = board
move $s2, $a2	# s2 = deck
move $s3, $a3 	# moves

li $v0, 13	# v0 open file
li $a1,0	# a1 = 0,  read only 
li $a2,0 	# mode is ignored
syscall 
move $s4, $v0	# s4 = descriptor 
bgez $v0, file_exist
li $v0, -1
li $v1, -1
j done_load_game

file_exist:
move $a0, $s2
jal init_list

addi $sp, $sp, -4	# save 1 bytes in stack
loop_for_deck:
move $a0, $s4	# a0 = file descriptor 
move $a1, $sp	# a1 = stack 
li $a2,1	# read one letter
li $v0, 14	# read 
syscall 

li $t0, 10
lbu $s5, 0($sp)		# s5 = first letter 
beq $t0, $s5, done_loop_for_deck

move $a0, $s4	# a0 = file descriptor 
move $a1, $sp	# a1 = stack 
li $a2,1	# read one letter
li $v0, 14	# read 
syscall 

lbu $s6, 0($sp)		# s6 = second letter
li $t0, 10
beq $t0, $s6,done_loop_for_deck

li $t0, 0x00005300
sll $s6, $s6, 16
or $t0, $s6, $t0
or $t0, $t0, $s5

move $a0, $s2
move $a1, $t0
jal append_card

j loop_for_deck



done_loop_for_deck:	# deck is all set, now time to get moves 
addi $sp, $sp, 4
li $s7, 0       # s7= counter

loop_for_moves:
addi $sp, $sp, -1
move $a0, $s4	# a0 = file descriptor 
move $a1, $sp	# a1 = stack 
li $a2,1	# read one letter
li $v0, 14	# read 
syscall 

addi $sp, $sp, -1
move $a0, $s4	# a0 = file descriptor 
move $a1, $sp	# a1 = stack 
li $a2,1	# read one letter
li $v0, 14	# read 
syscall 

addi $sp, $sp, -1
move $a0, $s4	# a0 = file descriptor 
move $a1, $sp	# a1 = stack 
li $a2,1	# read one letter
li $v0, 14	# read 
syscall 

addi $sp, $sp, -1
move $a0, $s4	# a0 = file descriptor 
move $a1, $sp	# a1 = stack 
li $a2,1	# read one letter
li $v0, 14	# read 
syscall 

lbu $t0, 0($sp)
addi $t0, $t0, -48
sll $t0, $t0,  24
lbu $t1, 1($sp)
addi $t1, $t1, -48
sll $t1, $t1, 16
lbu $t2, 2($sp)
addi $t2, $t2, -48
sll $t2, $t2, 8
lbu $t3, 3($sp)
addi $t3, $t3, -48
or $t0, $t0, $t1
or $t2, $t2, $t3
or $t0, $t0, $t2

sll $t1, $s7, 2		# t1 = 4 * index of arr
add $t1, $t1, $s3
sw $t0, 0($t1)

move $a0, $s4	# a0 = file descriptor 
move $a1, $sp	# a1 = stack 
li $a2,1	# read one letter
li $v0, 14	# read 
syscall 

lbu $t0, 0($sp)
li $t1, 10
beq $t0, $t1, done_done_loop_for_deck

addi $s7,$s7, 1
addi $sp, $sp, 4

j loop_for_moves


done_done_loop_for_deck:
addi $sp, $sp, 4
addi $v1, $s7, 1		# v1 = moves size 
# time to work on board
li $s7, 8
loop_for_init_board:
bltz $s7, done_loop_for_init_board
sll $t0, $s7, 2
add $t0, $t0, $s1
lw $a0, 0($t0)	 	# t0 = starting address of each board
jal init_list
addi $s7, $s7, -1
j loop_for_init_board	#######
done_loop_for_init_board:

li $s7, 0 
loading_board:

addi $sp, $sp, -4	# save 1 bytes in stack
loop_for_board:

move $a0, $s4	# a0 = file descriptor 
move $a1, $sp	# a1 = stack 
li $a2,1	# read one letter
li $v0, 14	# read 
syscall 
beqz $v0, done_loop_for_board

lbu $t0, 0($sp)		# t0 = first letter 
li $t1, 10
bne $t0, $t1, keep_going_in_loop_for_deck
li $s7, 0
#addi $sp, $sp, 4
j loop_for_board
keep_going_in_loop_for_deck:


li $v0, 14	# read 
syscall 		#

lbu $t1, 0($sp)		# t1 = second letter

li $t2, 0x00005300
sll $t1, $t1, 16
or $t0, $t0, $t1
or $t0, $t0, $t2
li $t1, 0x00205320					# t0 = card
beq $t1, $t0, no_card_at_place
sll $t1, $s7, 2
add $t1, $t1, $s1
lw $a0, 0($t1)
move $a1, $t0
jal append_card

no_card_at_place:
addi $s7, $s7, 1

j loop_for_board

done_loop_for_board:
addi $sp, $sp, 4
li $v0, 1







done_load_game:

lw $ra, 0($sp)
lw $s1, 4($sp)
lw $s2, 8($sp)
lw $s3, 12($sp)
lw $s4, 16($sp)
lw $s5, 20($sp)
lw $s6, 24($sp)
lw $s7, 28($sp)
addi $sp, $sp, 32


    jr $ra

simulate_game:
addi $sp, $sp, -24
sw $ra, 0($sp)
sw $s1, 4($sp)
sw $s2, 8($sp)
sw $s3, 12($sp)
sw $s4, 16($sp)
sw $s5, 20($sp)

move $s1, $a1
move $s2, $a2
move $s3, $a3

jal load_game
bgez $v0, load_game_successfully
li $v0, -1
li $v1, -1
j done_simulate_game

load_game_successfully:

move $s4, $v1		# s4 size of move
li $s5, 0 		# no of valid moves excuted 

loop_for_simulating:
beqz $s4, done_loop_for_simulating
move $a0, $s1
move $a1, $s2
lw $a2, 0($s3)
jal move_card
bltz $v0, was_not_valid
addi $s5, $s5, 1
lw $t0, 0($s2)
bnez $t0, was_not_valid

li $t0, 9
move $t1, $s1
loop_for_checking_board_empty:
beqz $t0, done_loop_for_checking_board_empty
lw $t2, 0($t1)
lw $t2, 0($t2)
bnez $t2, was_not_valid
addi $t0, $t0, -1
addi $t1, $t1, 4
j loop_for_checking_board_empty

done_loop_for_checking_board_empty:
li $v1, 1 
move $v0, $s5
j done_simulate_game
was_not_valid:

addi $s3, $s3, 4
addi $s4, $s4, -1

j loop_for_simulating

done_loop_for_simulating:
li $v1, -2
move $v0, $s5



done_simulate_game:

lw $ra, 0($sp)
lw $s1, 4($sp)
lw $s2, 8($sp)
lw $s3, 12($sp)
lw $s4, 16($sp)
lw $s5, 20($sp)
addi $sp, $sp, 24

    jr $ra

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

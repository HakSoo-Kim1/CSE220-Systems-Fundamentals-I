# Hak Soo Kim
# haksokim
# 111045936

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

.text
load_game:
addi $sp, $sp, -12	# save registers on stack
sw $s0, 0($sp)
sw $s2, 4($sp)
sw $s3, 8($sp)

move $s3, $a0		# s3 = starting address of first 5 byte
addi $s0, $a0, 5 	# s0 = starting address of string



move $a0, $a1	#a0 = file name
li $v0, 13	# v0 open file
li $a1,0	# a1 = 0,  read only 
li $a2,0 	# mode is ignored
syscall 

move $s2, $v0		# save file descriptor 
bltz $v0, file_not_existing	# if v0 is negative, file not existing

addi $sp, $sp, -1	# save 1 bytes in stack

move $a0, $s2	# a0 = file descriptor 
move $a1, $sp	# a1 = stack 
li $a2,1	# read one letter
li $v0, 14	# read 
syscall 

lbu $t0, 0($sp)		# t0 = first letter
addi $t0, $t0, -48	# t0 = first letter int 

move $a0, $s2		# a0 = file descriptor 
move $a1, $sp		# a1 = stack 
li $a2, 1		# read one letter
li $v0, 14		# read from file
syscall 

lbu $t1, 0($sp)		# t1 has unit
li $t2, 48		# t1 = 38
li $t5, 10
beq $t1, $t5, done_rows

blt $t1, $t2, row_is_not_tenth		# branch if row is not tenth
addi $t1, $t1, -48	# t1 = int of unit of row
li $t6, 10
mul $t0, $t0, $t6
add $t0, $t1, $t0	# t0 has row number

row_is_not_tenth:
loop_for_rows:
move $a0, $s2
move $a1, $sp
li $a2, 1
li $v0, 14	# read from file
syscall 
lbu $t3, 0($sp)
li $t2, '\n'
beq $t2, $t3, done_loop_for_rows
j loop_for_rows

done_rows:
done_loop_for_rows:
move $a0, $s2	# a0 = file descriptor 
move $a1, $sp	# a1 = stack 
li $a2,1	# read one letter
li $v0, 14	# read 
syscall 

lbu $t1, 0($sp)
addi $t1, $t1, -48

move $a0, $s2	# a0 = file descriptor 
move $a1, $sp	# a1 = stack 
li $a2,1	# read one letter
li $v0, 14	# read 
syscall 

li $t3, 48
lbu $t2, 0($sp)		# t0 = first letter
li $t5, 10
beq $t2, $t5, done_column_and_rows

blt $t2, $t3, column_is_not_tenth		# branch if row is not tenth
addi $t2, $t2, -48	# t1 = int of unit of row
li $t6, 10
mul $t1, $t1, $t6
add $t1, $t1, $t2	# t0 has row number

column_is_not_tenth:
loop_for_cloumns:
move $a0, $s2
move $a1, $sp
li $a2, 1
li $v0, 14	# read from file
syscall 
lbu $t3, 0($sp)
li $t2, '\n'
beq $t2, $t3, done_loop_for_cloumns
j loop_for_cloumns
 
done_loop_for_cloumns:
done_column_and_rows:
mul $t2, $t0, $t1	# row * column
move $t7, $t1
sb $t0, 0($s3)
sb $t1, 1($s3)
li $t0, 0	# number of apple
li $t1, 0 	# number of walls
li $t4, 0	# counter
li $t6, 0 	# length of snake 
 
loop_for_making_grid:
beq $t2, $t4, done_making_grid
move $a0, $s2
move $a1, $sp 
li $a2, 1
li $v0, 14	# read from file
syscall 

lbu $t3, 0($sp)
li $t5, 32
bge $t3, $t5, not_r_and_n
j loop_for_making_grid
not_r_and_n:
addi $t4, $t4, 1
li $t5, 97
bne $t3, $t5, not_apple
li $t0, 1	

not_apple:
li $t5, 35
bne $t3, $t5, not_wall
addi $t1, $t1, 1
not_wall:
li $t5, 49
bne $t3, $t5, not_head
div $t4, $t7
mfhi $t5
addi $t5, $t5, -1
sb $t5, 3($s3)
mflo $t5
sb $t5, 2($s3)
not_head:
li $t5, 49
blt $t3, $t5, not_snake_body
li $t5, 97
beq $t3, $t5, not_snake_body
addi $t6, $t6, 1
not_snake_body:
sb $t3, 0($s0)
addi $s0,$s0,1
j loop_for_making_grid

done_making_grid:
li $t5, 0
sb $t5, 0($s0)
move $a0, $s2
li $v0, 16
syscall
sb $t6, 4($s3)
move $v0, $t0
move $v1, $t1
addi $sp, $sp, 1
j done_making_grid_without_error

file_not_existing:
move $a0, $s2
li $v0, 16
syscall
li $v0, -1
li $v1, -1
done_making_grid_without_error:

lw $s0, 0($sp)
lw $s2, 4($sp)
lw $s3, 8($sp)
addi $sp, $sp, 12	# restore registers on stack
    jr $ra

get_slot:
bltz $a1, not_valid_range_get_slot	#if row < 0, not valid
bltz $a2, not_valid_range_get_slot	#if column <0, not valid

lbu $t0, 0($a0)	#t0 = row
lbu $t1, 1($a0) #t1 = column

bge $a1, $t0, not_valid_range_get_slot
bge $a2, $t1, not_valid_range_get_slot
addi $a0, $a0, 5
mul $t3, $a1, $t1
add $t3, $t3, $a2
add $t3, $t3, $a0
lbu $v0, 0($t3)
j valid_get_slot


not_valid_range_get_slot:
li $v0, -1
valid_get_slot:
    jr $ra


set_slot:
bltz $a1,  not_valid_range_set_slot	#if row < 0, not valid
bltz $a2,  not_valid_range_set_slot	#if column <0, not valid
lbu $t0, 0($a0)	#t0 = row
lbu $t1, 1($a0) #t1 = column
bge $a1, $t0, not_valid_range_set_slot
bge $a2, $t1,  not_valid_range_set_slot
addi $a0, $a0, 5
mul $t3, $a1, $t1
add $t3, $t3, $a2
add $t3, $t3, $a0
sb $a3, 0($t3)
move $v0,$a3
j valid_set_slot
 not_valid_range_set_slot:
 li $v0, -1
 valid_set_slot:
    jr $ra

place_next_apple:
addi $sp, $sp, -28	# save registers on stack
sw $ra 0($sp)
sw $s2, 4($sp)
sw $s3, 8($sp)
sw $s4, 12($sp)
sw $s5, 16($sp)
sw $s6, 20($sp)
sw $s7, 24($sp)

move $s2, $a0	# s2 = starting address of state
move $s3, $a1	# s3 = apples array
move $s4, $a2	# apples length
li $s5, 0	# counter

# move $t1, 
loop_for_place_next_apple:
beq $s5, $s4, cannot_find_space
lb $s6, 0($s3)	#s6 row of apple
lb $s7, 1($s3)	#s7 column of apple
li $t0, -1
bne $s6, $t0, maybe_valid_place
bne $s7, $t0, maybe_valid_place
addi $s5,$s5,1
addi $s3,$s3,2
j loop_for_place_next_apple

maybe_valid_place:
move $a0, $s2	# a0 = state 
move $a1, $s6	
move $a2, $s7
jal get_slot
li $t0, 46
bne $t0, $v0, empty_space_not_found_yet
move $a0, $s2
move $a1, $s6
move $a2, $s7
li $a3, 97
jal set_slot 
li $t0, -1
sb $t0, 0($s3)
sb $t0, 1($s3)
j found_empty_space_for_apple_and_updated
empty_space_not_found_yet:
addi $s5, $s5, 1
addi $s3, $s3, 2
j loop_for_place_next_apple

cannot_find_space:
found_empty_space_for_apple_and_updated:
move $v0, $s6
move $v1, $s7


lw $ra 0($sp)
lw $s2, 4($sp)
lw $s3, 8($sp)
lw $s4, 12($sp)
lw $s5, 16($sp)
lw $s6, 20($sp)
lw $s7, 24($sp)

addi $sp, $sp, 28
    jr $ra

find_next_body_part:
bltz $a1,  not_valid_range_set_slot_find_next_body_part	#if row < 0, not valid
bltz $a2,  not_valid_range_set_slot_find_next_body_part	#if column <0, not valid
lbu $t0, 0($a0)	#t0 = row
lbu $t1, 1($a0) #t1 = column
bge $a1, $t0, not_valid_range_set_slot_find_next_body_part
bge $a2, $t1,  not_valid_range_set_slot_find_next_body_part
j valid_range_set_slot_find_next_body_part

 not_valid_range_set_slot_find_next_body_part:
 li $v0, -1
 li $v1, -1
 j not_valid_range_find_next_body_part_done


valid_range_set_slot_find_next_body_part:
addi $sp, $sp, -28	# save registers on stack
sw $ra 0($sp)
sw $s0, 4($sp)
sw $s3, 8($sp)
sw $s4, 12($sp)
sw $s5, 16($sp)
sw $s6, 20($sp)
sw $s7, 24($sp)

move $s0, $a0	# s0 = state
move $s3, $a1	# s3 = point row 
move $s4, $a2	# s4 = point column 
move $s5, $a3 	# s5 = target part

# up
addi $t0, $s3, -1
move $a0, $s0
move $a1, $t0
move $a2, $s4
move $s6, $a1
move $s7, $a2
jal get_slot

beq $v0, $s5, body_part_found

# down
addi $t0, $s3, 1
move $a0, $s0
move $a1, $t0
move $a2, $s4
move $s6, $a1
move $s7, $a2
jal get_slot
beq $v0, $s5, body_part_found

# right
move $a0, $s0
move $a1, $s3
addi $t0, $s4, 1
move $a2, $t0
move $s6, $a1
move $s7, $a2
jal get_slot
beq $v0, $s5, body_part_found

# left
move $a0, $s0
move $a1, $s3
addi $t0, $s4, -1
move $a2, $t0
move $s6, $a1
move $s7, $a2
jal get_slot
beq $v0, $s5, body_part_found

# not found
li $v0, -1
li $v1, -1
j not_found
 
body_part_found:
move $v0, $s6
move $v1, $s7
not_found:
lw $ra 0($sp)
lw $s0, 4($sp)
lw $s3, 8($sp)
lw $s4, 12($sp)
lw $s5, 16($sp)
lw $s6, 20($sp)
lw $s7, 24($sp)
addi $sp, $sp, 28	
not_valid_range_find_next_body_part_done:
    jr $ra





slide_body:
lw $t0, 0($sp)	

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


move $s0, $a0		# s0 = struc
lbu $s5, 2($a0)		# s1 = head row
lbu $s6, 3($a0)		# s2 = head column
move $s3,$a3		# s3 = apples array
move $s4, $t0		# s4 = apple length

add $s1, $s5, $a1	# new head row
add $s2, $s6, $a2	# new head coloumn

move $a0, $s0
move $a1, $s1
move $a2, $s2
jal get_slot 

li $t0, 97
bne $v0, $t0, apple_not_there
move $a0, $s0
move $a1, $s3
move $a2, $s4
jal place_next_apple
li $s4, -1
j done_placing_new_apple

apple_not_there:
li $t0, 46
bne $v0, $t0, cannot_move
done_placing_new_apple:
sb $s1, 2($s0)
sb $s2, 3($s0)
move $a0, $s0
move $a1, $s1
move $a2, $s2
li $a3, 49
jal set_slot

li $s7, 50
slide_body_loop1:

move $a0, $s0
move $a1, $s5
move $a2, $s6
move $a3, $s7
jal find_next_body_part
li $t0, -1
beq $v0, $t0, done_slide_body_loop
move $s1, $v0
move $s2, $v1
move $a0, $s0
move $a1, $s5
move $a2, $s6
move $a3, $s7
jal set_slot
move $s5, $s1
move $s6, $s2
li $t0, 57
beq $s7, $t0, only_number_done
addi $s7, $s7,1
j slide_body_loop1



only_number_done:
li $s7, 65
slide_body_loop2:
move $a0, $s0
move $a1, $s5
move $a2, $s6
move $a3, $s7
jal find_next_body_part
li $t0, -1
beq $v0, $t0, done_slide_body_loop
move $s1, $v0
move $s2, $v1
move $a0, $s0
move $a1, $s5
move $a2, $s6
move $a3, $s7
jal set_slot
move $s5, $s1
move $s6, $s2
addi $s7, $s7,1
j slide_body_loop2


done_slide_body_loop:
move $a0, $s0
move $a1, $s5
move $a2, $s6
li $a3, 46
jal set_slot



li $t0, -1
beq $t0, $s4, _snake_ate_apple
li $v0, 0
j done_body_move_
_snake_ate_apple:
li $v0, 1
j done_body_move_

    cannot_move:
	li $v0, -1
	j done_body_move_
	

done_body_move_:
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
    
    

add_tail_segment:
addi $sp, $sp, -20
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s2, 8($sp)
sw $s3, 12($sp)
sw $s4, 16($sp) 

move $s0, $a0	#s0 = state
move $s2, $a2	#s2 = tail row
move $s3, $a3	#s3 = tail col




li $t0, 68	#D
beq $a1, $t0, D_given_add_tail
li $t0, 85 	#U
beq $a1, $t0, U_given_add_tail
li $t0, 76	#L
beq $a1, $t0, L_given_add_tail
li $t0, 82	#R
beq $a1, $t0, R_given_add_tail

j tail_can_not_be_placed_in_add_tail

D_given_add_tail:
move $a0, $s0
move $a1, $s2
move $a2, $s3
jal get_slot
li $t0, 90
beq $v0, $t0, tail_can_not_be_placed_in_add_tail
li $t0, 57
beq $v0, $t0, tail_is_9_for_D
addi $t1, $v0, 1
j figured_out_next_body_for_D
tail_is_9_for_D:
li $t1, 65
figured_out_next_body_for_D:
move $s4,$t1	# s4 has next body part digit

move $a0, $s0
addi $s2, $s2, 1
move $a1, $s2
move $a2, $s3
jal get_slot
li $t0, 46
bne $t0, $v0,  tail_can_not_be_placed_in_add_tail

move $a0, $s0
move $a1, $s2
move $a2, $s3
move $a3, $s4
jal set_slot

j new_tail_added_in_add_tail

U_given_add_tail:
move $a0, $s0
move $a1, $s2
move $a2, $s3
jal get_slot
li $t0, 90
beq $v0, $t0, tail_can_not_be_placed_in_add_tail
li $t0, 57
beq $v0, $t0, tail_is_9_for_U
addi $t1, $v0, 1
j figured_out_next_body_for_U
tail_is_9_for_U:
li $t1, 65
figured_out_next_body_for_U:
move $s4,$t1	# s4 has next body part digit

move $a0, $s0
addi $s2, $s2, -1
move $a1, $s2
move $a2, $s3
jal get_slot
li $t0, 46
bne $t0, $v0,  tail_can_not_be_placed_in_add_tail

move $a0, $s0
move $a1, $s2
move $a2, $s3
move $a3, $s4
jal set_slot
j new_tail_added_in_add_tail
L_given_add_tail:
move $a0, $s0
move $a1, $s2
move $a2, $s3
jal get_slot
li $t0, 90
beq $v0, $t0, tail_can_not_be_placed_in_add_tail
li $t0, 57
beq $v0, $t0, tail_is_9_for_L
addi $t1, $v0, 1
j figured_out_next_body_for_L
tail_is_9_for_L:
li $t1, 65
figured_out_next_body_for_L:
move $s4,$t1	# s4 has next body part digit
move $a0, $s0
move $a1, $s2
addi $s3, $s3, -1
move $a2, $s3
jal get_slot
li $t0, 46
bne $t0, $v0,  tail_can_not_be_placed_in_add_tail
move $a0, $s0
move $a1, $s2
move $a2, $s3
move $a3, $s4
jal set_slot
j new_tail_added_in_add_tail
R_given_add_tail:
move $a0, $s0
move $a1, $s2
move $a2, $s3
jal get_slot
li $t0, 90
beq $v0, $t0, tail_can_not_be_placed_in_add_tail
li $t0, 57
beq $v0, $t0, tail_is_9_for_R
addi $t1, $v0, 1
j figured_out_next_body_for_R
tail_is_9_for_R:
li $t1, 65
figured_out_next_body_for_R:
move $s4,$t1	# s4 has next body part digit
move $a0, $s0
move $a1, $s2
addi $s3, $s3, 1
move $a2, $s3
jal get_slot
li $t0, 46
bne $t0, $v0,  tail_can_not_be_placed_in_add_tail
move $a0, $s0
move $a1, $s2
move $a2, $s3
move $a3, $s4
jal set_slot
j new_tail_added_in_add_tail
new_tail_added_in_add_tail:
lbu $t0, 4($s0)
addi $t0, $t0, 1
sb $t0, 4($s0)
move $v0, $t0
j new_tail_added_in_add_tail_done
tail_can_not_be_placed_in_add_tail:
li $v0, -1
new_tail_added_in_add_tail_done:
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s2, 8($sp)
lw $s3, 12($sp)
lw $s4, 16($sp)
addi $sp, $sp, 20
    jr $ra







increase_snake_length:
addi $sp, $sp, -24
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $s4, 20($sp)


move $s0, $a0 	#s0 = state
move $s1, $a1 	#s1 = direction
lbu $s2, 2($s0)
lbu $s3, 3($s0)


#find_the_tail
li $s4, 50
find_the_tail_loop_in_incre_snake_length:
move $a0, $s0 
move $a1, $s2
move $a2, $s3
li $t0, 58
bne $t0, $s4, keep_going_find_the_tail
li $s4, 65
keep_going_find_the_tail:
move $a3, $s4
jal find_next_body_part
li $t0, -1
beq $t0, $v0, tail_found_in_incre_snake_length
addi $s4, $s4, 1
move $s2, $v0
move $s3, $v1
j find_the_tail_loop_in_incre_snake_length

#tail found
tail_found_in_incre_snake_length:

li $t0, 68 								# D
bne $s1, $t0, not_D_in_incre_snake_length

move $a0, $s0
li $a1, 85  #U
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

move $a0, $s0
li $a1, 76  #L
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

move $a0, $s0
li $a1, 68  #D
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

move $a0, $s0
li $a1, 82  #R
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

j fail_to_add_in_incre_snake_length

not_D_in_incre_snake_length:

li $t0, 85 									#U
bne $s1, $t0, not_U_in_incre_snake_length

move $a0, $s0
li $a1, 68  #D
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake


move $a0, $s0
li $a1, 82  #R
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake


move $a0, $s0
li $a1, 85  #U
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

move $a0, $s0
li $a1, 76  #L
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

j fail_to_add_in_incre_snake_length

not_U_in_incre_snake_length:

li $t0, 76									#L
bne $s1, $t0, not_L_in_incre_snake_length

move $a0, $s0
li $a1, 82  #R
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

move $a0, $s0
li $a1, 85  #U
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

move $a0, $s0
li $a1, 76  #L
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

move $a0, $s0
li $a1, 68  #D
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

j fail_to_add_in_incre_snake_length

not_L_in_incre_snake_length:
li $t0, 82									#R
bne $s1, $t0, fail_to_add_in_incre_snake_length

move $a0, $s0
li $a1, 76  #L
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

move $a0, $s0
li $a1, 68  #D
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

move $a0, $s0
li $a1, 82  #R
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

move $a0, $s0
li $a1, 85  #U
move $a2, $s2
move $a3, $s3
jal add_tail_segment
li $t0, -1
bne $v0, $t0, successfully_new_tail_added_in_incre_snake

fail_to_add_in_incre_snake_length:
li $v0, -1
j done_fail_to_add_in_incre_snake_length
successfully_new_tail_added_in_incre_snake:
lbu $v0, 4($s0)
done_fail_to_add_in_incre_snake_length:

lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
lw $s4, 20($sp)
addi $sp, $sp, 24

    jr $ra

move_snake:
addi $sp, $sp, -20
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)

move $s0, $a0 	# s0 = state
move $s1, $a1 	# s1 = dir
move $s2, $a2 	# s2 = apple arr
move $s3, $a3 	# s3 = apple length 

li $t0, 85	#U
bne $s1, $t0, not_U_in_move_snake
move $a0, $s0
li $a1, -1
li $a2, 0
move $a3, $s2
addi $sp, $sp, -4
sw $s3, 0($sp)
jal slide_body
addi $sp, $sp, 4
li $t0, -1
beq $v0, $t0, return_with_negative_1
li $t0, 1
bne $v0, $t0, slide_body_returned_0
move $a0, $s0
move $a1, $s1			# slide body returned 1, now increase snake length
jal increase_snake_length
li $t0, -1
beq $v0, $t0, return_with_negative_1
j got_100_point_after_ate_apple

not_U_in_move_snake:
li $t0, 76	#L
bne $s1, $t0, not_L_in_move_snake
move $a0, $s0
li $a1, 0
li $a2, -1
move $a3, $s2
addi $sp, $sp, -4
sw $s3, 0($sp)
jal slide_body
addi $sp, $sp, 4
li $t0, -1
beq $v0, $t0, return_with_negative_1
li $t0, 1
bne $v0, $t0, slide_body_returned_0
move $a0, $s0
move $a1, $s1			# slide body returned 1, now increase snake length
jal increase_snake_length
li $t0, -1
beq $v0, $t0, return_with_negative_1
j got_100_point_after_ate_apple


not_L_in_move_snake:
li $t0, 82	#R
bne $s1, $t0, not_R_in_move_snake
move $a0, $s0
li $a1, 0
li $a2, 1
move $a3, $s2
addi $sp, $sp, -4
sw $s3, 0($sp)
jal slide_body
addi $sp, $sp, 4
li $t0, -1
beq $v0, $t0, return_with_negative_1
li $t0, 1
bne $v0, $t0, slide_body_returned_0
move $a0, $s0
move $a1, $s1			# slide body returned 1, now increase snake length
jal increase_snake_length
li $t0, -1
beq $v0, $t0, return_with_negative_1
j got_100_point_after_ate_apple

not_R_in_move_snake:
li $t0, 68	#D
bne $s1, $t0, return_with_negative_1
move $a0, $s0
li $a1, 1
li $a2, 0
move $a3, $s2
addi $sp, $sp, -4
sw $s3, 0($sp)
jal slide_body
addi $sp, $sp, 4
li $t0, -1
beq $v0, $t0, return_with_negative_1
li $t0, 1
bne $v0, $t0, slide_body_returned_0
move $a0, $s0
move $a1, $s1			# slide body returned 1, now increase snake length
jal increase_snake_length
li $t0, -1
beq $v0, $t0, return_with_negative_1
j got_100_point_after_ate_apple

got_100_point_after_ate_apple:
li $v0, 100
li $v1, 1
j done_move_snake
slide_body_returned_0:
li $v0, 0
li $v1, 1
j done_move_snake
return_with_negative_1:
li $v0, 0
li $v1, -1

done_move_snake:
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
addi $sp, $sp, 20

    jr $ra



simulate_game:
lw $t0, 0($sp) #apple arr
lw $t1, 4($sp) # apple length 
addi $sp, $sp, -32
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $s4, 20($sp)
sw $s5, 24($sp)
sw $s7,	28($sp)

move $s0, $a0 	# state
move $s1, $a2	# direction
move $s2, $a3	# num_moves_toexcute
move $s3, $t0 	# apple arr
move $s4, $t1	# apple length 
move $s7, $a3

jal load_game
li $t0, -1
beq $v0, $t0, file_not_found
li $t0, 0
bne $v0, $t0, apple_found_in_load_game 
move $a0, $s0
move $a1, $s3
move $a2, $s4
jal place_next_apple
apple_found_in_load_game :
li $s5, 0	# score

simulating:
li $t0, 0
beq $s2, $t0, done_simulating 	# check num_moves_toexcute
li $t0, 35
lbu $t1, 4($s0)			
bge $t1, $t0, done_simulating	# check length of snake
lbu $t0, 0($s1)
beqz $t0, done_simulating	# check letter

move $a0, $s0
move $a1, $t0
move $a2, $s3
move $a3, $s4
jal move_snake

li $t0, -1
beq $v1, $t0, done_simulating
li $t0, 100
bne $t0, $v0, not_add_100
lbu $t1, 4($s0)
addi $t1, $t1, -1
mul $t3, $t0, $t1
add $s5, $s5, $t3
not_add_100:
addi $s1, $s1, 1
addi $s2, $s2, -1
j simulating

done_simulating:
sub $v0, $s7, $s2
move $v1, $s5
j done_simulating_without_problem
file_not_found:
li $v0, -1
li $v1, -1
done_simulating_without_problem:


lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
lw $s4, 20($sp)
lw $s5, 24($sp)
lw $s7,	28($sp)
addi $sp, $sp, 32

    jr $ra

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

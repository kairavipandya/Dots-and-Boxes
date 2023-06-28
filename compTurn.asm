.globl compTurn

.text
#computer randomly generates a number to represent the col, row, and orientation and stores it in the variables to be checked
compTurn:
	li $a1, 9  
   	li $v0, 42  
    	syscall
    	
    	sw $a0, colEntered
    	
    	#display the computer's selected column as one plus the random number to deal with 0-based indexing
    	add $a0, $a0, 1  
   	li $v0, 1  
  	syscall	
  	
  	lbu $a0, newline
  	li $v0, 11
  	syscall
  	
  	li $a1, 7  
   	li $v0, 42  
    	syscall
    	
    	sw $a0, rowEntered
    	
    	#display the computer's selected column as one plus the random number to deal with 0-based indexing
    	add $a0, $a0, 1  
   	li $v0, 1  
  	syscall	
  	
    	lbu $a0, newline
  	li $v0, 11
  	syscall
  	
	#display the selected number for the computer's orientation (either 0 or 1) for Up or Right
   	li $v0, 42  
   	li $a1, 2
    	syscall
    	li $v0, 1
    	syscall
	sw $a0, oriEntered	
	

    	lbu $a0, newline
  	li $v0, 11
  	syscall
	
	#validate the computer's move
	addiu $sp, $sp, -4	
	sw $ra, 0($sp)		
	
	lw $a0, colEntered
	lw $a1, rowEntered
	lw $a2, oriEntered
	lw $a3, turn
	jal validation
	beq $v0, 1, game 
	
	#display the updated board after the computer's move has been validated
	jal boardDisp

	#update the turn to be the user's turn
	lw $t0, turn
	addi $t0, $t0, -1
	sw $t0, turn
	
	#update the turn counter to be one greater
	lw $t0, turnCount
	addi $t0, $t0, 1
	sw $t0, turnCount
	
	#jump back to the main game loop
	j game

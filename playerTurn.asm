.globl playerTurn

.text
#If it's the players turn, they enter the row, column, and orientation they want to play
playerTurn:
	li $v0, 4
	la $a0, colPrompt
	syscall
	
	li $v0, 5
	syscall
	
	addi $v0, $v0, -1
	sw $v0, colEntered
	
	li $v0, 4
	la $a0, rowPrompt
	syscall
	
	li $v0, 5
	syscall
	
	addi $v0, $v0, -1 
	sw $v0, rowEntered

#entered orientation is compared to possible orientations and jumps to the one it is. throws error if invalid orientation is entered
OriFind:	
	li $v0, 4
	la $a0, oriPrompt
	syscall
	
	li $v0, 8	
	la $a0, oriEntered	
	li $a1, 4	
	syscall
	lbu $t0, 0($a0)
	lbu $t1, Up

	lbu $t3, Right
	beq $t0, $t1, Upper
	beq $t0, $t3, Righter
	
	li $v0, 4
	la $a0, oriError
	syscall
	
	j OriFind

#entered orientation was Up and it will be stored to proper variable
Upper:
	addi $t1, $zero, 0
  	sw $t1, oriEntered
	j playerEnding

#entered orientation was Up and it will be stored to proper variable
Righter:
	addi $t1, $zero, 1
  	sw $t1, oriEntered
	j playerEnding
	
#at the end of the player's turn, validate the players code using the validate.asm file functions, update the turn counter and change the turn to the computers	
playerEnding:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)		
	
	#validate the user's move
	lw $a0, colEntered
	lw $a1, rowEntered
	lw $a2, oriEntered
	lw $a3, turn
	jal validation
	beq $v0, 1, game 
	
	#make it the computer's turn
	lw $t0, turn
	addi $t0, $t0, 1
	sw $t0, turn
	
	#update count of total turns by 1
	lw $t0, turnCount
	addi $t0, $t0, 1
	sw $t0, turnCount
	
	jal boardDisp
	
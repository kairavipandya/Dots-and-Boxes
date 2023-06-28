.data	
	#Prompts
	colPrompt:			.asciiz "Column Selection (1-9): "
	rowPrompt:			.asciiz "\nRow Selection (1-7): "
	oriPrompt:			.asciiz "\nOrientation Selection of Up or Right (in upper case as U or R): "
	error:				.asciiz "Wrong Input\n"
	oriError:			.asciiz "Orientation input error \n"
	ColSmall: 			.asciiz "\nThe column value is too small \n"
	ColBig: 			.asciiz "\nThe column value is too big\n"
	RowSmall: 			.asciiz "\nThe Row value is too small\n"
	RowBig: 			.asciiz "\nThe Row value is too big\n"
	lineExists: 			.asciiz "\nYou tried to put a line where it already exists, try again\n"
	gameEnd:			.asciiz "Game end"
	gameStart: 			.asciiz "Welcome to Dots and Boxes by: Kairavi, Kapil, Brody, and Aditya\n"
	
	#ASCII chars
	dot: 				.byte '.'		
	hori: 				.byte '-'	
	vert: 				.byte '|'	
	space: 				.byte ' '
	newline: 			.byte '\n'
	Up: 	.byte 'U'
	Right: 	.byte 'R'
	
	#Array size initialization
	hArr: 				.space 56  
	vArr: 				.space 54	                         
	
	#Important values to track
	turn:				.word 1
	turnCount:			.word 0
	colEntered:			.word 0
	rowEntered:			.word 0
	oriEntered:			.word 0

#global labels in the main.asm file
.globl colPrompt
.globl rowPrompt
.globl oriPrompt
.globl error
.globl ColSmall
.globl ColBig
.globl RowBig
.globl RowSmall
.globl lineExists
.globl gameEnd
.globl oriError
.globl dot
.globl hori
.globl vert
.globl space
.globl newline
.globl Up
.globl Right
.globl hArr
.globl vArr
.globl turn
.globl turnCount
.globl colEntered
.globl rowEntered
.globl oriEntered
.globl game
.globl main
.globl boardDisp


.text
#display the initial blank board and run the game function
main:
	li $v0, 4
	la $a0, gameStart
	syscall
	
	jal boardDisp	
	jal game

#After 110 turns, display the end of game message and terminate the program
gameOver:
	li $v0, 4
	la $a0, gameEnd
	syscall

	li $v0, 10
	syscall

#display the board through using the start function of the boardDisplay.asm file
boardDisp:
	move $s1, $ra	
	jal startDisplay
	jr $s1			

#game function checks if its been 110 turns, sees whos turn it is, and jumps to that turn's function
game:
	lw $t0, turnCount
	beq $t0, 110, gameOver
	
	lw $t0, turn
	beq $t0, 1, playerTurn
	beq $t0, 2, compTurn

#other files from this folder that are needed for the code
.include "playerTurn.asm"
.include "compTurn.asm"
.include "validate.asm"
.include "boardDisplay.asm"



	

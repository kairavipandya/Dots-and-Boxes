.globl validation

.text
#validation function checks if the row/column entered was too big or small 
validation:
	move $t0, $a0 
	move $t1, $a1 
	move $t2, $a2 	
	blt $t0, 0, colS
	bgt $t0, 8, colB
	blt $t1, 0, rowS
	bgt $t1, 6, rowB
	
	#orientation is Right
	beq $t2, 1, drawHori
	
	#if we are in Row 1, we can not draw a vertical line
	beq $t1, 0, rowS 
	
	#find the index value of the part of the array that we are in and draw a space or vertical line based on the value in the index
	addi $t3, $t1, -1
	mul $t3, $t3, 9
	add $t3, $t3, $t0
	lbu $t4, vArr($t3)
	bne $t4, 0, lineHereAlready	
	li $t4, 1
	sb $t4, vArr($t3)
	
	#return to main
	li $v0, 0
	jr $ra
	
#draw a horizontal line if we are not in the last column and that location has been captured
drawHori:
	beq $t0, 8, colB 

	
	sll $t3, $t1, 3
	add $t3, $t3, $t0
	lbu $t4, hArr($t3)
	bne $t4, 0, lineHereAlready	
	li $t4, 1
	sb $t4, hArr($t3)
	
	
	li $v0, 0
	jr $ra

#based on what error was received, display the message for that error and have the player enter a new number by jumping back to main
colS:
	la $a0, ColSmall
	j displayFailure
	
colB:
	la $a0, ColBig
	j displayFailure
	
rowS:
	la $a0, RowSmall
	j displayFailure
	
rowB:
	la $a0, RowBig
	j displayFailure

#if there is a line already in the selected value, have the player pick a new location or orientation
lineHereAlready:
	la $a0, lineExists
	j displayFailure
	
displayFailure:
	li $v0, 4
	syscall
	
	li $v0, 1
	jr $ra
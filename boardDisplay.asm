.globl startDisplay

.text
#create increment for going through the array of columns and array of rows
startDisplay:
	li $v0, 11
	li $a0, 10  
	syscall
	
	addi $t0, $zero, 1	
	
#print the columns 
printCs:
	li $v0, 1
	move $a0, $t0	#column number
	syscall
	
	li $v0, 11
	lbu $a0, space	
	syscall
	syscall
	syscall
	
	addi $t0, $t0, 1
	bne $t0, 10, printCs	
	
	lbu $a0, newline	
	syscall
	
	move $t0, $zero	#row index is 0
	move $t1, $zero #col index is 0

#print the rows
printRs:
	beq $t1, 8, printRClose	#end the loop if we've done all 8 columns
	
	lbu $a0, dot	
	li $v0, 11
	syscall
	
	sll $t2, $t0, 3		
	add $t2, $t2, $t1	
	
	lbu $t3, hArr($t2)	
	beq $t3, 0, spacePrint	#if the value of the array index is 0, print three spaces, else print 3 horizontal lines
	
	lbu $a0, hori	
	syscall
	syscall
	syscall
	
	j pass	

#print 3 spaces
spacePrint: 
	lbu $a0, space 
	syscall
	syscall
	syscall

#do not print 3 spaces here and increment the col counter by 1
pass:
	
	addi $t1, $t1, 1	
	j printRs	

#last Row has a final dot that needs to be added and a new line added after it
printRClose: 

	move $t1, $zero	
	lbu $a0, dot	
	syscall
	lbu $a0, space
	syscall
	syscall
	li $v0, 1	
	addi $a0, $t0, 1	
	syscall
	li $v0, 11
	lbu $a0, newline	
	syscall

#print the columns
printCClose:
	beq $t1, 9, printCEnd	#check if end of arrays	
	beq $t0, 6, printCEnd		
	
	mul $t2, $t0, 9		
	add $t2, $t2, $t1	
	
	lbu $t3, vArr($t2)	
	beq $t3, 0, spacePrint2	#if vArr has no value for the current index, print space. Else, print a vertical line
	
	lbu $a0, vert	
	syscall
	j skipped	
	
#print spaces
spacePrint2: lbu $a0, space	
	syscall

#if we arent in the last column, print 3 spaces
skipped:
	beq $t1, 8, shiftLastC	

	lbu $a0, space 
	syscall
	syscall
	syscall

#if we are in the last column, increment column loop and make a new line
shiftLastC:
	addi $t1, $t1, 1
	j printCClose	

#if end of the loop, print a new line and jump back to main
printCEnd: move $t1, $zero	
	addi $t0, $t0, 1	
	
	lbu $a0, newline	
	syscall
	bne $t0, 7, printRs	
	
	jr $ra
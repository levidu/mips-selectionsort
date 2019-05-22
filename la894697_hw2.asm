.data 
#Enter the size of the array
sizeArray: .word 9

#The array list, make sure the sizeArray is correctly input
intArray: .word 7 9 4 3 8 1 6 2 5

prompt_Message1: .asciiz "Enter 0 to sort in descending order.\n"
prompt_Message2: .asciiz "Any number different than 0 will sort in ascending order.\n"
space: .asciiz " "
newLine: .asciiz "\n"

title: .asciiz "The Original List: "
DsortTitle: .asciiz "DESCENDING List: "
AsortTitle: .asciiz "ASCENDING List: "

.text

main: 

#Prompt user the message1

li $v0, 4
la $a0 , prompt_Message1
syscall


#Prompt user the message2

li $v0, 4
la $a0 , prompt_Message2
syscall

#Get user input message
li $v0, 5
syscall

move $t9, $v0

#Jump and link to the function if user input is 0 funcAscending or else funcDescending

beq $t9, $zero, funcDescending
jal funcAscending


#Code block to output the ascending list
funcAscending:

la $a0, title
li $v0,4
syscall 

la $a0, intArray 
la $t0, sizeArray
lw $t0, ($t0)
sll $t0, $t0, 2
addi $t0, $t0, -4
add $a1, $a0, $t0 
jal AscendingshowResult

la $a0, newLine 
li $v0, 4
syscall

la $a0, intArray
jal AscendingSecSort 

la $a0, AsortTitle 
li $v0,4
syscall 

la $a0, intArray 
jal AscendingshowResult

li $v0, 10 
syscall


AscendingshowResult:move $t0, $a0
AscendingoutterLoop: blt $a1, $t0, AscendingExit 

lw $a0,($t0)
li $v0,1
syscall

la $a0, space 
li $v0,4
syscall

addi $t0, $t0, 4 
j AscendingoutterLoop

AscendingExit: jr $ra


AscendingSelect:
move $t0, $a0
move $t4, $a0
Ascendingloop:
addi $t4, $t4, 4
blt $a1, $t4, AscendingDone
lw $t2, ($t0)
lw $t1, ($t4)
slt $t5, $t2, $t1
bne $t5, $zero, Ascendingloop
move $t0, $t4
j Ascendingloop
AscendingDone: lw $t2, ($a0)
lw $t1, ($t0)
sw $t2, ($t0)
sw $t1, ($a0)
jr $ra



AscendingSecSort: 
move $s1, $a0
AscendingInnerLoop:
beq $a1, $s1, AscendingExitInnerLoop 
addi $sp, $sp, -8
sw $ra, ($sp) 
sw $a0, 4 ($sp) 
move $a0, $s1 
jal AscendingSelect
lw $ra, ($sp) 
lw $a0, 4 ($sp)
addi $sp, $sp, 8
addi $s1, $s1, 4
j AscendingInnerLoop

AscendingExitInnerLoop: jr $ra

la $v0, 10
syscall

#code block to output the descending 
funcDescending:
la $a0, title
li $v0,4
syscall 

la $a0, intArray 
la $t0, sizeArray
lw $t0, ($t0)
sll $t0, $t0, 2
addi $t0, $t0, -4
add $a1, $a0, $t0 
jal showResult

la $a0, newLine 
li $v0, 4
syscall

la $a0, intArray
jal secsort 

la $a0, DsortTitle 
li $v0,4
syscall 

la $a0, intArray 
jal showResult

li $v0, 10 
syscall


showResult:move $t0, $a0
outterLoop: blt $a1, $t0, exit 

lw $a0,($t0)
li $v0,1
syscall

la $a0, space 
li $v0,4
syscall

addi $t0, $t0, 4 
j outterLoop

exit: jr $ra


pick:
move $t0, $a0
move $t4, $a0

loop:
addi $t4, $t4, 4
blt $a1, $t4, done
lw $t2, ($t0)
lw $t1, ($t4)
slt $t5, $t2, $t1
beq $t5, $zero, loop
move $t0, $t4
j loop
done: lw $t2, ($a0)
lw $t1, ($t0)
sw $t2, ($t0)
sw $t1, ($a0)
jr $ra


secsort: 
move $s1, $a0
innerLoop:
beq $a1, $s1, exitInnerLoop 
addi $sp, $sp, -8
sw $ra, ($sp) 
sw $a0, 4 ($sp) 
move $a0, $s1 
jal pick
lw $ra, ($sp) 
lw $a0, 4 ($sp)
addi $sp, $sp, 8
addi $s1, $s1, 4
j innerLoop

exitInnerLoop: jr $ra

la $v0, 10
syscall

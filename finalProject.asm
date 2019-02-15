# Jiao Huang
# CS 3340.502
# Dr.Karen Mazidi
# Jxh170330
# Final Project: in this project, i write a mini game station that user can play 3 games including 
#  rock paper scissors game, guess the number game, and dice game.
.data"
Jiao: 		.asciiz "Author: Jiao Huang\n"
Welcome:		 .asciiz "Welcome to the mini game station!\nIn this mini game station, we have two small games available here:\n"
getName:		.asciiz "May I have your name please? "
userChoice:	.asciiz "Please choose the game you want to play by enter 1, 2, 3 or 4: "
warning1:	.asciiz "Please enter a valid number!\n"
menu:		.asciiz "1. Rock-paper-sciessors\n2. Guess the Number\n3.Dice Game\n4. Quit\n"
rps_user:	.asciiz "Welcome to the rock-paper-scissor game!\nPlease enter 1 for rock, 2 for paper, and 3 for scissors: "
user_rock:	.asciiz "You choose rock\n"
user_paper:	.asciiz "You choose paper\n"
user_scissors:	.asciiz "You choose scissors\n"
pc_rock:		.asciiz "The Computer choose rock\n"
pc_paper:	.asciiz "The Computer choose paper\n"
pc_scissors:	.asciiz "The Computer choose scissors\n"
win:		.asciiz "\nCongratulation! You win the game!\n"
draw:		.asciiz "\nThe game has draw!\n"
lost:		.asciiz "\nYou lose D:\nBut it's okay to lose, because failure is the mother of success:)\n"
tryAgain:	.asciiz "\nDo you want to try again? Enter 1 for yes and 0 for no: "
goBackMenu:	.asciiz "Want to go back to the main menu? Press 1 for yes and 0 to quit: "
menu_gn:		.asciiz "Welcome to the guess number game!\nIn this game, system will randomly generate a number ranging from 1 to 100.\nYou need to try to guess the correct number.\nDon't worry, we will give you hint!\n"
getGuessNum:	.asciiz "Please try to guess a number ranging from 1 to 100: "
gn_error:	.asciiz "Please enter the number ranging from 1-100!\n"
test_generate:	.asciiz "The computer is generating a random number....\n"
highGuess:	.asciiz "High guess, please try again.\n"
lowGuess:	.asciiz "Low guess, please try again.\n"
guess_right:	.asciiz "Yeah! You get the right number!\n"
menu_dg:		.asciiz "Wecome to the dice game!\nIn this game, the computer will help you roll two dices,\nif the sum of the two dices is greater than or equals to 10, then you win.\n"
dg_generate1:	.asciiz "\nI am rolling dice A for you...\n"
dg_generate2:	.asciiz "\nNow I am rolling dice B for you...\n"
diceA:		.asciiz "The number on the dice A is: "
diceB:		.asciiz "The number on the dice B is: "
sum_dg:		.asciiz	"\nThe sum of two dices is: "
quit_msg:	.asciiz "\nLeaving the game station...\nBye! Have a good day!"
new_line:	.asciiz "\n"
rps_loseTimeMsg:	.asciiz "In the rock-paper-scissors game, your score is: "
rps_winTimeMsg:	.asciiz	" (lose) - "
rps_drawTimeMsg:	.asciiz " (win) - "
draw2Msg:	.asciiz " (draw).\n"
gn_countTimeMsg:	.asciiz "In the guess number game, you guessed: "
gn_times:	.asciiz " times to get the right number.\n"
dg_winTimeMsg:	.asciiz "In the dice game, your score is: "
dg_loseTimeMsg:	.asciiz " (win) - "
dg_time:		.asciiz " (lose).\n"
helloUser:	.asciiz "Hi, "
loseTime_rps:	.word	0
winCount_rps:	.word	0
drawCount:	.word	0
countTime_gn:	.word	0
loseTime_dg:	.word	0
winCount_dg:	.word	0
name:		.word	0
	
.text
main:
	# print author's name
	la	$a0	Jiao 
	li	$v0	4
	syscall
	
	#  print message aks for player's name
	la	$a0	getName 
	li	$v0	4
	syscall
	
	# get user's name input
	li	$v0	8
	la	$a0	name
	li	$a1	20
	syscall

	# print welcome message
	la	$a0	Welcome
	li	$v0	4
	syscall

	# go to menuLoop
	b	menuLoop

menuLoop:
	# print the munu
	la	$a0	menu
	li	$v0	4
	syscall

	# ask user to select one game
	la	$a0	userChoice
	li	$v0	4
	syscall

	# get user's choice for the game selection
	li	$v0	5
	syscall
	
	# if user select 1, then go to rock_paper_scissor game;
	# if user select 2, then go to guess number game
	# if user select 3, then go to dice game
	# if user select 4, then quit
	# if user enter something other than 1,2,3 and 4, then print error message
	move	$t0	$v0
	move	$a0	$t0
	beq	$t0	1	rock_paper_scissor
	beq	$t0	2	gn_menu
	beq	$t0	3	dg_menu
	beq	$t0	4	quit
	b	error_Input_menu
	
rock_paper_scissor:
	# print rock-paper-scissors game rule and ask user to choose rock, paper, or scissors
	la	$a0	rps_user
	li	$v0	4
	syscall
	
	li	$v0	5
	syscall
	
	move	$t1	$v0
	
	# if user enter 1, then he or she choose rock
	# if user enter 2, then he or she choose paper
	# if user enter 3, then he or she choose scissors
	# if user enter something rather than 1, 2 or 3, then print error message
	beq	$t1	1	rock
	beq	$t1	2	paper
	beq	$t1	3	scissors
	jal	error_Input_rps

rock:
	# tell user he or she chooses rock
	la	$a0	user_rock
	li	$v0	4
	syscall
	
	# jump to random_rps
	jal	random_rps
	
scissors:
	# tell user he or she chooses scissors
	la	$a0	user_scissors
	li	$v0	4
	syscall
	
	# jump to random_rps
	jal	random_rps
	
paper:
	# tell user he or she chooses paper
	la	$a0	user_paper
	li	$v0	4
	syscall
	
	# jump to random_rps
	b	random_rps

random_rps:
	# generate a random number from 1 to 3
	li	$a1	3
	li	$v0	42
	syscall
	
	addi	$a0	$a0	1
	move	$t2	$a0
	
	# if the computer generates the random number 1, then go to computer_rock
	# if the computer generates the random number 2, then go to computer_paper
	# if the computer generates the random number 3, then go to computer_scissors
	beq	$t2	1	computer_rock
	beq	$t2	2	computer_paper
	beq	$t2	3	computer_scissors
	
computer_rock:
	# print the message show computer choose rock
	la	$a0	pc_rock
	li	$v0	4
	syscall
	
	# if user's choice is scissors, then user lose
	# if user's choice is rock, then draw
	# if user's choice is paper, then user win
	beq	$t1	2	print_win_rps
	beq	$t1	$t2	print_draw
	beq	$t1	3	print_lose_rps
	
	li	$v0	10
	syscall
	
computer_scissors:
	# print the message show computer choose scissors
	la	$a0	pc_scissors
	li	$v0	4
	syscall
	
	# if user's choice is scissors, then draw
	# if user's choice is rock, then user win
	# if user's choice is paper, then user lose
	beq	$t1	1	print_win_rps
	beq	$t1	$t2	print_draw
	beq	$t1	2	print_lose_rps
	
	li	$v0	10
	syscall
	
computer_paper:	
	#  print the message show computer choose paper
	la	$a0	pc_paper
	li	$v0	4
	syscall
	
	# if user's choice is scissors, then user win
	# if user's choice is rock, then lose
	# if user's choice is paper, then draw
	beq	$t1	3	print_win_rps
	beq	$t1	$t2	print_draw
	beq	$t1	1	print_lose_rps
	
	li	$v0	10
	syscall
	
print_lose_rps:
	# print the lose message to the user
	la	$a0	lost
	li	$v0	4
	syscall
	
	# counter, add 1 each time when user lose
	lw	$t9	loseTime_rps($zero)
	addi	$t9	$t9	1
	sw	$t9	loseTime_rps($zero)
	add	$a0	$t9	$zero
	
	# ask the user if they want to try again or not
	la	$a0	tryAgain
	li	$v0	4
	syscall
	
	# get the user's input
	li	$v0	5
	syscall
	
	# if user choose 0, then quit
	# if user choose 1, then go back to rock_paper_scissor
	# if user enter integer rather than 0 and 1, then print error message
	move	$t3	$v0
	beq	$t3	0	quit
	beq	$t3	1	rock_paper_scissor
	b	error_Input_try_rps

print_lose_dg:	
	# print lose message if the user lose the dice game
	la	$a0	lost
	li	$v0	4
	syscall
	
	# counter
	lw	$t9	loseTime_dg($zero)
	addi	$t9	$t9	1
	sw	$t9	loseTime_dg($zero)
	add	$a0	$t9	$zero
	
	# ask if the user want to try again
	la	$a0	tryAgain
	li	$v0	4
	syscall
	
	# get user's input
	li	$v0	5
	syscall
	
	# if user choose 0, then quit
	# if user choose 1, then go back to dg_menu
	# if user enter integer other than 0 and 1, then print error message
	move	$t3	$v0
	beq	$t3	0	quit
	beq	$t3	1	dg_menu
	b 	error_Input_try_dg
	
print_win_rps:
	# print win message to the user if he or she win the rock-paper-scissor game
	la	$a0	win
	li	$v0	4
	syscall
	
	# counter, +1 if user win for one round
	lw	$t9	winCount_rps($zero)
	addi	$t9	$t9	1
	sw	$t9	winCount_rps($zero)
	add	$a0	$t9	$zero
	
	# print the message to ask user if he or she want to go back to menu
	la	$a0	goBackMenu
	li	$v0	4
	syscall
	
	# get user's input
	li	$v0	5
	syscall
	
	# if user enter 0, then quit
	# if user enter 1, then go back to menuLoop
	# if user enter integer other than 0 and 1, then print error message
	move	$t6	$v0
	beq	$t6	0	quit
	beq	$t6	1	menuLoop
	b	error_Input_rps_gbm

print_win_gn:
	# print win message to the user if he or she win the guess number game
	la	$a0	win
	li	$v0	4
	syscall
	
	# print the message to ask user if he or she want to go back to menu
	la	$a0	goBackMenu
	li	$v0	4
	syscall
	
	# get user's input
	li	$v0	5
	syscall
	
	# if user enter 0, then quit
	# if user enter 1, then go back to menuLoop
	# if user enter integer other than 0 and 1, then print error message
	move	$t6	$v0
	beq	$t6	0	quit
	beq	$t6	1	menuLoop
	b	error_Input_gn_gbm
	
print_win_dg:
	# print win message to the user if he or she win the dice game
	la	$a0	win
	li	$v0	4
	syscall
	
	# counter, +1 each time if user win one round
	lw	$t9	winCount_dg($zero)
	addi	$t9	$t9	1
	sw	$t9	winCount_dg($zero)
	add	$a0	$t9	$zero
	
	# print the message to ask user if he or she want to go back to menu
	la	$a0	goBackMenu
	li	$v0	4
	syscall
	
	# get user's input
	li	$v0	5
	syscall
	
	# if user enter 0, then quit
	# if user enter 1, then go back to menuLoop
	# if user enter integer other than 0 and 1, then print error message
	move	$t6	$v0
	beq	$t6	0	quit
	beq	$t6	1	menuLoop
	b	error_Input_dg_gbm
	
print_draw:
	# print the message to tell user he or she draw the game
	la	$a0	draw
	li	$v0	4
	syscall
	
	# counter, +1 each time if user draw
	lw	$t9	drawCount($zero)
	addi	$t9	$t9	1
	sw	$t9	drawCount($zero)
	add	$a0	$t9	$zero
	
	# print the message to ask user if he or she want to go back to menu
	la	$a0	goBackMenu
	li	$v0	4
	syscall
	
	# get user's input
	li	$v0	5
	syscall
	
	# if user enter 0, then quit
	# if user enter 1, then go back to menuLoop
	# if user enter integer other than 0 and 1, then print error message
	move	$t6	$v0
	beq	$t6	0	quit
	beq	$t6	1	menuLoop
	b	error_Input_drawrps_gbm
	
gn_menu:
	# print out the menu of the guess number
	la	$a0	menu_gn
	li	$v0	4
	syscall
	
	# jump to rand_num
	jal	rand_num
	
rand_num:
	# print that the computer is generating the random number
	la	$a0	test_generate
	li	$v0	4
	syscall
	
	# generate random number from 1 to 100
	li	$a1	100
	li	$v0	42
	syscall
	
	addi	$a0	$a0	1
	move	$t5	$a0
	
	la	$a0	new_line
	li	$v0	4
	syscall
	
	# jump to guess_number
	jal	guess_number
	
guess_number:
	# ask user to guess a number
	la	$a0	getGuessNum
	li	$v0	4
	syscall
	
	# get user's input
	li	$v0	5
	syscall
	
	move	$t4	$v0
	
	# jump to compare_gn
	jal	compare_gn
	
compare_gn:
	# if user input integer greater than 100 or less than or equals to 0, then print error message
	# go to gn_highGuess if user's guess greater than the computer generated number
	# go to gn_low guess if user's guess lower than the computer generated number
	# go to gn_right if user's guess equals to the computer generated number
	bgt	$t4	100	error_Input_gn
	ble	$t4	0	error_Input_gn
	bgt	$t4	$t5	gn_highGuess
	beq	$t4	$t5	gn_right
	b	gn_lowGuess
	
gn_highGuess:
	# print high guess message to the user
	la	$a0	highGuess
	li	$v0	4
	syscall
	
	# counter, +1 each time if the user guess the number too high
	lw	$t9	countTime_gn($zero)
	addi	$t9	$t9	1
	sw	$t9	countTime_gn($zero)
	add	$a0	$t9	$zero
	
	# jump to guess_number
	jal	guess_number
gn_right:
	# print the message to the user that he or she guess the number right
	la	$a0	guess_right
	li	$v0	4
	syscall
	
	# jump to print_win_gn
	jal	print_win_gn
	
gn_lowGuess:
	# print the low guess message to the user
	la	$a0	lowGuess
	li	$v0	4
	syscall
	
	# counter, +1 each time if user guess the number low
	lw	$t9	countTime_gn($zero)
	addi	$t9	$t9	1
	sw	$t9	countTime_gn($zero)
	add	$a0	$t9	$zero
	
	# jump to guess_number
	jal	guess_number
	
dg_menu:
	# print the menu for dice game
	la	$a0	menu_dg
	li	$v0	4
	syscall
	
	# jump to random_diceA
	jal	random_diceA

random_diceA:
	# print the message to the user that computer is rolling one dice A for the user
	la	$a0	dg_generate1
	li	$v0	4
	syscall
	# tell user the number on the dice A
	la	$a0	diceA
	li	$v0	4
	syscall
	
	# generate a random number for dice A from 1 to 6
	li	$a1	6
	li	$v0	42
	syscall
	
	addi	$a0	$a0	1
	li	$v0	1
	syscall
	
	move	$t6	$a0
	
	la	$a0	new_line
	li	$v0	4
	syscall
	
	# jump to random_diceB
	jal	random_diceB
	
random_diceB:
	# print message to show user the computer is rolling dice B
	la	$a0	dg_generate2
	li	$v0	4
	syscall
	
	# tell user the number on the dice B
	la	$a0	diceB
	li	$v0	4
	syscall
	
	# generating a random number from 1 to 6
	li	$a1	6
	li	$v0	42
	syscall
	
	addi	$a0	$a0	1
	li	$v0	1
	syscall
	
	move	$t7	$a0
	
	la	$a0	new_line
	li	$v0	4
	syscall
	
	# jump to sum_dice
	jal	sum_dice
	
sum_dice:
	# print the message to show the sum of the two dice
	la	$a0	sum_dg
	li	$v0	4
	syscall
	
	# addition for the sum of number on the two dices
	add	$t7	$t7	$t6
	move	$a0	$t7
	li	$v0	1
	syscall
	
	la	$a0	new_line
	li	$v0	4
	syscall
	
	# jump to compare_dg
	jal	compare_dg
	
compare_dg:
	# if the sum is greater than 10, then go to print_win_dg
	# else, go to print_lose_dg
	bge	$t7	10	print_win_dg
	b	print_lose_dg

quit:
	# print hello message to the user
	la	$a0	helloUser
	li	$v0	4
	syscall
	
	# print the name of the user
	la	$a0	name
	li	$v0	4
	syscall
	
	# print how many time the user lose for rock paper scissors game
	la	$a0	rps_loseTimeMsg
	li	$v0	4
	syscall
	
	lw	$a0	loseTime_rps
	li	$v0	1
	syscall
	
	# print how many time the user win for rock paper scissors game
	la	$a0	rps_winTimeMsg
	li	$v0	4
	syscall
	
	lw	$a0	winCount_rps
	li	$v0	1
	syscall
	
	# print how many time the user draw for rock paper scissors game
	la	$a0	rps_drawTimeMsg
	li	$v0	4
	syscall
	
	lw	$a0	drawCount
	li	$v0	1
	syscall
	
	la	$a0	draw2Msg
	li	$v0	4
	syscall
	
	# print how many time the user guess the right number
	la	$a0	gn_countTimeMsg
	li	$v0	4
	syscall
	
	lw	$a0	countTime_gn
	li	$v0	1
	syscall
	
	la	$a0	gn_times
	li	$v0	4
	syscall
	
	# print how many time the user win the dice game
	la	$a0	dg_winTimeMsg
	li	$v0	4
	syscall
	
	lw	$a0	winCount_dg
	li	$v0	1
	syscall
	
	# print how many time the user lose the guess number game
	la	$a0	dg_loseTimeMsg
	li	$v0	4
	syscall
	
	lw	$a0	loseTime_dg
	li	$v0	1
	syscall
	
	la	$a0	dg_time
	li	$v0	4
	syscall
	
	# print the leaving message
	la	$a0	quit_msg
	li	$v0	4
	syscall
	
	li	$v0	10
	syscall


	
error_Input_menu:
	# print error message
	la	$a0	warning1
	li	$v0	4
	syscall
	
	# jump back to menuLoop
	jal	menuLoop
	
error_Input_rps_gbm:
	# print the error message
	la	$a0	warning1
	li	$v0	4
	syscall
	
	# jump back to rock_paper_scissor
	jal	print_win_rps

error_Input_gn_gbm:
	# print the error message
	la	$a0	warning1
	li	$v0	4
	syscall
	
	# jump back to rock_paper_scissor
	jal	print_win_gn
	
error_Input_dg_gbm:
	# print the error message
	la	$a0	warning1
	li	$v0	4
	syscall
	
	# jump back to rock_paper_scissor
	jal	print_win_dg
	
error_Input_drawrps_gbm:
	# print the error message
	la	$a0	warning1
	li	$v0	4
	syscall
	
	# jump back to rock_paper_scissor
	jal	print_draw
		
error_Input_rps:
	# print the error message
	la	$a0	warning1
	li	$v0	4
	syscall
	
	# jump back to rock_paper_scissor
	jal	rock_paper_scissor
	
error_Input_gn:
	# print the error message
	la	$a0	warning1
	li	$v0	4
	syscall
	
	# jump back to guess_number
	jal	guess_number
	
error_Input_try_dg:
	# print the error message
	la	$a0	warning1
	li	$v0	4
	syscall
	
	# jump back to print_lose_dg
	jal	print_lose_dg

error_Input_try_rps:
	# print the error message
	la	$a0	warning1
	li	$v0	4
	syscall
	
	# jump back to print_lose_rps
	jal	print_lose_rps

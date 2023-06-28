# Dots-and-Boxes using MIPS

Program Summary:

This program implements the Dots and Boxes game into MIPS assembly
language using MARS. The game is played on a 6x8 grid (6 rows and 8 columns). The
dots and boxes are represented through ASCII symbols, and the game board is
updated every turn. The user will always start the game. The objective of the game is to
finish more boxes than the computer can in the set 110 turns of the game. The “winner”
of the game is decided by whoever finishes the most boxes on their turns. After the user
or computer finishes their turn, it will become the next player’s turn. If the user or
computer attempts to enter an invalid input, an error will be thrown and the player will be
asked to enter a valid input for their turn.

Correct Use:

1. Open an IDE that can support asm code.
2. Open the main.asm file in the DandB2023 directory. This will be the file that is
assembled and executed.
3. Ensure that the necessary modules (playerTurn.asm, compTurn.asm,
validate.asm, and boardDisplay.asm) are in the same directory as the main.asm
file
4. Once main.asm is opened, click assemble project

5. Run the project.
6. The user will see a welcome message and a blank 6x8 grid of dots. The user will
be prompted with a message asking to enter a row number from 1-7. You should
enter a valid number and press enter
7. The user will be prompted to enter a valid column number from 1-9. You should
enter a valid number and press enter.
8. The user will be prompted to enter a valid orientation (either Up or Right) for the
direction of their line. Enter “U” for Up or “R” for Right.
9. The user’s inputs will be validated, and if there is an error with the user’s input,
the program will prompt the user for valid input (go back to step 6)
10. If the user’s input was valid, the board will be updated. It will become the
computer’s turn
11. The computer will randomly generate possible column, row, and orientation
combinations until it gets a combination that is successfully validated.
12. The board is updated to account for the computer’s move. It will become the
user’s turn
13. This process (from 6 to 12) repeats itself 55 times until all legal moves have been
correctly executed
14. After 110 total turns have been completed. The game displays an end of game
message and terminates the program.
15. If the user would like to play another round, go back to step 4

Limitations:

As a version 1.0 project of dots and boxes on MIPS asm, the program has some
limitations. To better the playing experience, the user should be aware of these potential
issues. The only two limitations of the game are invalid input for the row and columns
that are larger than 1 byte. Entering such an input will crash the program since the
assigned value for these data structures is a byte. The only other important limitation is
not a feature that will crash the program. Rather, the program does not have a feature
to track box completion or scoring, so at the end of the game, the program will say
“Game over” and terminate. If the user would like to keep score, they will have to do so
manually.

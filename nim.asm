;Max Dauber
;mjd3375
;EE306 Programming Assignment 3

	.orig x3000
	AND R0, R0, #0
	AND R1, R1, #0
	AND R2, R2, #0
	AND R3, R3, #0
	AND R4, R4, #0
	AND R5, R5, #0
	AND R6, R6, #0
	AND R7, R7, #0
	ADD R0, R0, #3
	ST R0, A
	ADD R0, R0, #2
	ST R0, B
	ADD R0, R0, #3
	ST R0, C
	AND R0, R0, #0
IN_LOOP	JSR O_STATE
	JSR G_IN
	LEA R0, NL
	PUTS 
	AND R1, R1, #0
	LD R0, A
	ADD R1, R1, R0
	LD R0, B
	ADD R1, R1, R0
	LD R0, C
	ADD R1, R1, R0
	BRnp IN_LOOP
	LD R4, STATUS
	BRz P1
	LEA R0, P2W
	PUTS
	BR END
P1	LEA R0, P1W
	PUTS
END	HALT

O_STATE	ST R7, T7
	LEA R0, AO
	PUTS
	LEA R0, o
	LD R1, A
OA_LOOP	BRnz B_L 
	PUTS
	ADD R1, R1, #-1
	BR OA_LOOP
B_L	LEA R0, NL
	PUTS 
	LEA R0, BO
	PUTS
	AND R0, R0, #0
	AND R1, R1, #0
	LEA R0, o
	LD R1, B
OB_LOOP	BRnz C_L 
	PUTS
	ADD R1, R1, #-1
	BR OB_LOOP
C_L	LEA R0, NL
	PUTS 
	LEA R0, CO
	PUTS
	AND R0, R0, #0
	AND R1, R1, #0
	LEA R0, o
	LD R1, C
OC_LOOP	BRnz END_S 
	LEA R0, o
	PUTS
	ADD R1, R1, #-1
	BR OC_LOOP
END_S	LEA R0, NL
	PUTS 
	AND R0, R0, #0
	AND R1, R1, #0
	LD R7, T7
	RET


A	.BLKW 1
B	.BLKW 1
C	.BLKW 1
o	.STRINGZ "o"
AO	.STRINGZ "ROW A: "
BO	.STRINGZ "ROW B: "
CO	.STRINGZ "ROW C: "
NL	.STRINGZ "\n"
P1I	.STRINGZ "Player 1, choose a row and number of rocks: "
P2I	.STRINGZ "Player 2, choose a row and number of rocks: "
INV	.STRINGZ "Invalid move. Try again.\n"
P1W	.STRINGZ "Player 1 wins."
P2W	.STRINGZ "Player 2 wins."
big_a	.fill #-65
offset	.fill x-30
T7	.BLKW 1
STATUS	.BLKW 1


G_IN	ST R7, T7
	LD R4, STATUS
	NOT R4, R4
	BRz P2LOOP
P1LOOP	LEA R0, P1I
	PUTS
	BR INPUT
P2LOOP	LEA R0, P2I
	PUTS
INPUT	AND R2, R2, #0
	AND R3, R3, #0
	GETC
	OUT
	ADD R2, R2, R0
	GETC
	OUT
	ADD R3, R3, R0
	LD R0, offset
	ADD R3, R3, R0
	LEA R0, NL
	PUTS 
	LD R5, big_a
	ADD R2, R2, R5
	BRz inputA
	ADD R2, R2, #-1
	BRz inputB
	ADD R2, R2, #-1
	BRz inputC
ERROR	LEA R0, INV
	PUTS
	ADD R4, R4 #0
	BRz P2LOOP
	BR P1LOOP
inputA	LD R1, A
	NOT R3, R3
	ADD R3, R3, #1
	BRp ERROR
	ADD R1, R1, R3
	BRn ERROR
	ST R1, A
	BR IN_END
inputB	LD R1, B
	NOT R3, R3
	ADD R3, R3, #1
	BRp ERROR
	ADD R1, R1, R3
	BRn ERROR
	ST R1, B
	BR IN_END
inputC	LD R1, C
	NOT R3, R3
	ADD R3, R3, #1
	BRp ERROR
	ADD R1, R1, R3
	BRn ERROR
	ST R1, C
IN_END	ST R4, STATUS
	LD R7, T7
	RET
	.END


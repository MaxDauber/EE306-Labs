;Max Dauber
;mjd3375
;Programming Assignment 5 - Patt EE306
;user_program.asm

	.ORIG x3000
	AND R0, R0, #0
	AND R1, R1, #0
	AND R2, R2, #0
	AND R3, R3, #0
	AND R4, R4, #0
	AND R5, R5, #0
	AND R6, R6, #0
	AND R7, R7, #0
	LD R6, empty

	LD R0, lf
	OUT

	LD R0, st_int
	STI R0, vector

	LDI R0, kbsr
	LD R1, enable
	ADD R0, R0, R1
	STI R0, kbsr
	
in_loop	LEA R0, output
	PUTS
	LD R0, lf
	OUT
	ST  R1, SaveR1
        LD  R1, COUNT
REP     ADD R1,R1,#-1
        BRnp REP
        LD  R1, SaveR1
	BR in_loop

COUNT   .FILL #40000
SaveR1  .BLKW 1
empty	.FILL x3000
lf	.FILL #10
vector	.FILL x180
st_int	.FILL x1500
enable	.FILL x4000
kbsr	.FILL xFE00
output	.STRINGZ "Input a capital letter from the English alphabet:"


	.END


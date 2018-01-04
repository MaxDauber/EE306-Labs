;Max Dauber
;mjd3375
;Programming Assignment 5 - Patt EE306
;interrupt_service_routine.asm

	.ORIG x1500
	ST R7, loc7
	ST R0, T0
	ST R1, T1
	ST R2, T2
	
	LDI R1, kbdr
	AND R0, R0, #0
	ADD R0, R0, R1
	LD R2, Z
	ADD R2, R2, R0
	BRp not_1
	LD R2, A
	ADD R2, R2, R0
	BRn not_1
	BR PRINT1
not_1	LD R2, z
	ADD R2, R2, R0
	BRp not_2
	LD R2, a
	ADD R2, R2, R0
	BRn not_2
	BR PRINT2
not_2	BR PRINT3
	
PRINT1	AND R0, R0, #0
	ADD R0, R0, x0A
back	LDI R2, dsr
	BRzp back
	STI R0, ddr
	LD R0, T0
	LD R1, T1
	LD R2, T2
	LD R7, loc7
	RTI

PRINT2	AND R0, R0, #0
	ADD R0, R0, x0A
back2	LDI R2, dsr
	BRzp back2
	STI R0, ddr

	LEA R0, lower
back4	LDR R1, R0, #0
	BRz done2
back3	LDI R2, dsr
	BRzp back3
	STI R1, ddr
	ADD R0, R0, #1
	BR back4

done2	LDI R0, kbdr 
	LD R2, diff
	ADD R0, R0, R2
back5	LDI R2, dsr
	BRzp back5
	STI R0, ddr

	LD R0, sp
backs	LDI R2, dsr
	BRzp backs
	STI R0, ddr

	LD R0, i
back6	LDI R2, dsr
	BRzp back10
	STI R0, ddr

	LD R0, s
back7	LDI R2, dsr
	BRzp back7
	STI R0, ddr
	
	LD R0, sp
backp	LDI R2, dsr
	BRzp backp
	STI R0, ddr

	LDI R0, kbdr
back8	LDI R2, dsr
	BRzp back8
	STI R0, ddr

	LD R0, period
back9	LDI R2, dsr
	BRzp back9
	STI R0, ddr

	AND R0, R0, #0
	ADD R0, R0, x0A
backt	LDI R2, dsr
	BRzp backt
	STI R0, ddr

	LD R0, T0
	LD R1, T1
	LD R2, T2
	LD R7, loc7
	RTI

PRINT3	AND R0, R0, #0
	ADD R0, R0, x0A
back10	LDI R2, dsr
	BRzp back10
	STI R0, ddr
	
	LDI R0, kbdr
back11	LDI R2, dsr
	BRzp back11
	STI R0, ddr

	LEA R0, no_let
back13	LDR R1, R0, #0
	BRz done3
back12	LDI R2, dsr
	BRzp back12
	STI R1, ddr
	ADD R0, R0, #1
	BR back13
done3	AND R0, R0, #0
	ADD R0, R0, x0A
back14	LDI R2, dsr
	BRzp back14
	STI R0, ddr
	LD R0, T0
	LD R1, T1
	LD R2, T2
	LD R7, loc7
	RTI



kbdr	.FILL xFE02
T0	.BLKW 1
T1	.BLKW 1
T2	.BLKW 1
A	.FILL #-65
Z	.FILL #-90
a	.FILL #-97
z	.FILL #-122
diff	.FILL #-32
ddr	.FILL xFE06
dsr	.FILL xFE04
loc7	.BLKW 1
loc0	.BLKW 1
loc1	.BLKW 1
loc2	.BLKW 1
lower	.STRINGZ "The lower case character of "
i	.FILL #105
s	.FILL #115
sp	.FILL #32
period	.FILL #46
no_let	.STRINGZ " is not a capital letter in the English alphabet."
	.END
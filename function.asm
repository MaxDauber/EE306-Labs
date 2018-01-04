;Programming Lab 2
;Max Dauber mjd3375
;11/5/17
;Patt EE306
	.orig x5000
	ST R1, t1      ;temp register storage
	ST R2, t2
	ST R3, t3
	ST R5, t5
	AND R1, R1, #0 ;resetting registers
	AND R2, R2, #0
	AND R3, R3, #0
	AND R4, R4, #0
	AND R5, R5, #0
	LD R2, coef  ;address of first coef
	LDR R3, R2, #0 ;value of first coef
	LDI R1, degree  ;overall degree
	BRnz H_END     ;branch if degree is <=0
	ST R0, x_VALUE
	AND R0, R0, #0 ;set R0 to 0
	ADD R4, R4, R3 ;add first coef to 0
B_LOOP	ADD R1, R1, #-1
	BRn S_END
	AND R0, R0, #0 ;set R0 to 0
	LD R0, x_VALUE ;load x into R0 for multiplication
	ADD R0, R0, #-1;decrement x
	AND R5, R5, #0
	ADD R5, R5, R4
L_MULT	ADD R4, R4, R5;step of multiplication
	ADD R0, R0, #-1;decrement x
	BRp L_MULT
	ADD R2, R2, #1 ;increment coef address
	LDR R3, R2, #0 ;load new coef
	ADD R4, R4, R3
	BR B_LOOP
H_END	LDR R4, R3, #0
S_END	LDI R1, t1
	LDI R2, t2
	.END
	LDI R3, t3
	LDI R5, t5
	RET
t1	.BLKW 1
t2	.BLKW 1
t3	.BLKW 1
t5	.BLKW 1
x_VALUE	.BLKW 1
degree	.FILL x4003
coef	.FILL x4004
	.END
.orig x3000
G_IN	AND R0, R0, #0
	AND R1, R1, #0
	AND R2, R2, #0
	AND R3, R3, #0
	AND R4, R4, #0
	AND R5, R5, #0
	AND R6, R6, #0
	AND R7, R7, #0
	LEA R0, in_name
	PUTS
IN_LOOP	GETC
	OUT
	ST R0, name
	LD R2, minus_d
	ADD R2, R0, R2
	BRnp not_d
	AND R1, R1, #0;if its d resets to 1
	ADD R1, R1, #1
not_d	ADD R0, R0, #-10
	BRnp loop       ;if its enter
	ADD R1, R1, #0
	BRnz search
	AND R1, R1, #0
loop	BRnp IN_LOOP
	ADD R1, R1, #-1
	BRnz f_loop
search	LD R0, tree
	LD R6, stack
	JSR FIND
	ADD R4, R4, #0
	BRnz p_f
	LEA R0, n_entry
	PUTS
f_loop	BR G_IN
END	HALT
p_f	JSR PRINT_NUM
	BR f_loop





FIND	ADD R6, R6, #-1
	ADD R0, R0, #1
	STR R0, R6, #0
	ADD R6, R6, #-1
	ADD R0, R0, #1
	STR R0, R6, #0
	ADD R0, R0, #0
	BRz RESTORE
	LDR R2, R0, #1;
	ST R7, TEMP
	JSR CHECK ;r1 has to be pointer to starting location of name
	LD R7, TEMP
	ADD R4, R4, #0
	BRp cont
	LDR R0, R0, #2
	RET
cont	ADD R2, R0, #0
	LDR R0, R2, #0
	JSR FIND
	LDR R0, R2, #1
	JSR FIND
	ADD R0, R2, #0
RESTORE	LDR R2, R6, #0
	ADD R6, R6, #1
	LDR R7, R6, #0
	ADD R6, R6, #1
	RET









PUSH	ADD R6, R6, #-1;
	STR R0, R6, #0;
	RET

POP 	LDR R0, R6, #0
	ADD R6, R6, #1
	RET

ISEMPTY	LD R0 , empty
	ADD R0 , R6 , R0
	BRz IS
	ADD R0 , R0 , #0
	RET
IS 	AND R0 , R0 , #0
	ADD R0 , R0 , #1
	RET

in_name	.STRINGZ "Type a professor's name and then press Enter:"
n_entry	.STRINGZ "No Entry"
name	.BLKW 21
enter	.FILL #-10
d	.FILL #100
minus_d	.FILL #-100
tree	.FILL x4000
stack	.FILL xFE00
empty	.FILL x0200
T0	.BLKW 1
T1	.BLKW 1
T2	.BLKW 1
T3	.BLKW 1
T4	.BLKW 1
TEMP	.BLKW 1

CHECK	ST R1, T1
	ST R2, T2
	ST R3, T3
	ST R4, T4
	LD R2, name
C_LOOP	LDR R3, R1, #0
	BRnz FIN
	LDR R4, R2, #0
	ADD R1, R1, #1
	ADD R2, R2, #1
	NOT R4, R4
	ADD R4, R4, R3
	BRz C_LOOP
	AND R5, R5 #0
	BR FIN1
FIN	AND R5, R5, #0
	ADD R5, R5, #1
FIN1	LD R1, T1
	LD R2, T2
	LD R3, T3
	LD R4, T4
	RET

PRINT_NUM        ST   R0, PRINT_NUM_SAVER0
                 ST   R1, PRINT_NUM_SAVER1
                 ST   R6, PRINT_NUM_SAVER6
                 ST   R7, PRINT_NUM_SAVER7
                 LEA  R6, PRINT_NUM_LF
PRINT_NUM_AGAIN  JSR  DIV10            
                 ADD  R6, R6, #-1
                 LD   R7, PRINT_NUM_HEX30
                 ADD  R0, R0, R7       
                 STR  R0, R6, #0       
                 ADD  R1, R1, #0
                 BRz  PRINT_NUM_DONE   
                 ADD  R0, R1, #0
                 BR   PRINT_NUM_AGAIN
PRINT_NUM_DONE   ADD  R0, R6, #0
                 TRAP x22
                 LD   R0, PRINT_NUM_SAVER0
                 LD   R1, PRINT_NUM_SAVER1
                 LD   R6, PRINT_NUM_SAVER6
                 LD   R7, PRINT_NUM_SAVER7
                 RET
PRINT_NUM_STACK  .BLKW 5
PRINT_NUM_LF     .FILL x000A  
PRINT_NUM_NULL   .FILL x0000
PRINT_NUM_HEX30  .FILL x0030
PRINT_NUM_SAVER0 .BLKW 1
PRINT_NUM_SAVER1 .BLKW 1
PRINT_NUM_SAVER6 .BLKW 1
PRINT_NUM_SAVER7 .BLKW 1
DIV10            AND  R1, R1, #0
DIV10_AGAIN      ADD  R0, R0, #-10
                 BRn  DIV10_DONE
                 ADD  R1, R1, #1
                 BR   DIV10_AGAIN
DIV10_DONE       ADD  R0, R0, #10
                 RET

	.END
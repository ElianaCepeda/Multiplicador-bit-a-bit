variableA: 0b0 
Q: 0b10000001 ; Multiplicador
Q_1: 0b0
M: 0b11111101; Multiplicando
count: 0x8
QMSB: 0x00
N:0x00

inicio:

	MOV ACC, Q
	MOV DPTR, ACC
	MOV ACC, [DPTR]
	MOV A, ACC
	MOV ACC, 0x01
	AND ACC, A
	MOV A, ACC

	MOV ACC, variableA
	MOV DPTR, ACC
	MOV ACC, A
	MOV [DPTR], ACC
	
	MOV ACC, Q_1
	MOV DPTR, ACC
	MOV ACC, [DPTR]
	MOV A, ACC
	MOV ACC, 0x01
	AND ACC, A
	JZ VER00			;VERIFICAMOS SI ES 00	

	MOV ACC, variableA
	MOV DPTR, ACC
	MOV ACC, [DPTR]
	INV ACC
	JZ SHIFTRIGHT 		; si el valor al momento de hacer INV ACC y JZ ve que Q = 0, eso dice que Q si es 1
        ; por lo tanto Q y Q-1 = 11
	JMP VER10_01


VER00:
	MOV ACC, variableA;
        MOV DPTR, ACC
        MOV ACC, [DPTR] 
        JZ SHIFTRIGHT ; Si Q es tambien 0 osea Q y Q-1 = 00
        JMP VER10_01 ; Si Q no es 0, entonces Q y Q-1 podrian ser 10 o 01
	
VER10_01:
	MOV ACC, variableA
	MOV DPTR, ACC
	MOV ACC, [DPTR]
	JZ add   ; Si Q es 0, entonces Q y Q-1 SON 01, por lo que salta a Add

	MOV ACC, Q_1
	MOV DPTR, ACC
	MOV ACC, [DPTR]
	MOV A, ACC
	MOV ACC, 0x01
	AND ACC, A
	INV ACC
	JZ SUBB ; si Q-1 = 0, entoces Q  Q-1 son 10 por lo tanto salta a subtract


SHIFTRIGHT:
	MOV ACC, Q
	MOV DPTR, ACC
	MOV ACC, [DPTR]
	MOV A, ACC
	MOV ACC, 0x01
	AND ACC, A
	MOV A, ACC
	MOV ACC, Q_1
	MOV DPTR, ACC
	MOV ACC, A
	MOV [DPTR], ACC
	MOV ACC, N
	MOV DPTR, ACC
	MOV ACC, [DPTR]
	MOV A, ACC
	MOV ACC, 0x01
	AND ACC, A
	MOV ACC, QMSB
	MOV DPTR, ACC
	MOV ACC, 0x80
	MOV [DPTR], ACC

	
	
	

SUBB:
	
	MOV ACC, M
	MOV DPTR, ACC
	MOV ACC, [DPTR]
	INV ACC
	MOV A, ACC
	MOV ACC, 0x01
	ADD ACC, A
	MOV A, ACC
	MOV ACC, variableA
	MOV DPTR, ACC
	ADD ACC, A ;variableA-M EN ACC
	MOV [DPTR], ACC ;variableA-M =variableA
	JMP SHIFTRIGHT


	
add:
	
		MOV ACC, M
		MOV DPTR, ACC
		MOV ACC, [DPTR]
		MOV A, ACC
		MOV ACC, variableA
		MOV DPTR, ACC
		MOV ACC, [DPTR]
		ADD ACC, A
		MOV [DPTR], ACC ;variableA=variableA+M
		JMP SHIFTRIGHT




FINALIZAR:

	hlt ; Se detiene la ejecucion

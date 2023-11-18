
; Multiplicador Eliana Cepeda, Laura Garzón, Liseth Lozano

variableA: 0b0 
Q: 0b10000001 ; Multiplicador
Q_1: 0b0
M: 0b11111101; Multiplicando
count: 0x8
inicio:
	; Cargar count
	mov ACC, count 
	mov DPTR, ACC
	mov ACC, [DPTR]
	jz fin		; se termina el programa
	jmp fnd_Q0_0

load_M:
	mov ACC, M 
	mov DPTR, ACC
	mov ACC, [DPTR]
	ret
load_A:
	mov ACC, variableA 
	mov DPTR, ACC
	mov ACC, [DPTR]
	ret
load_Q: 		;Cargar Q que será el multiplicador
	mov ACC, Q 
	mov DPTR, ACC
	mov ACC, [DPTR] 
	ret
load_Q_1:
	mov ACC, Q_1
	mov DPTR, ACC
	mov ACC, [DPTR] 
	ret
act_Q_0:
	jmp load_Q	
	mov A, ACC	; Q queda guardado en A
	mov ACC, Q_1	; Cargamos al DPTR Q_0
	mov DPTR, ACC
	mov ACC, 0b0001	;Cargar 1 para hallar el Q0
	and ACC, A	; And para determinar si el bit menos significacito es 1 o 0
	mov [DPTR], ACC	;queda actualizado Q_0 en Q1
	ret
act_A_0:
	jmp load_A	
	mov A, ACC	; variableA queda guardado en A
	mov ACC, Q_1	; Cargamos al DPTR A_0
	mov DPTR, ACC
	mov ACC, 0b0001	;Cargar 1 para hallar el A0
	and ACC, A	; And para determinar si el bit menos significacito es 1 o 0
	mov [DPTR], ACC	;queda actualizado A_0 
	ret
fnd_Q0_0: 
	jmp load_Q	
	mov A, ACC	; Q queda guardado en A
	mov ACC, 0b0001	;Cargar 1 para hallar el Q0
	and ACC, A	; And para determinar si el bit menos significacito es 1 o 0	
	jz fnd_Q_1_1
	jmp fnd_Q_1_0
fnd_Q_1_1:
	jmp load_Q_1
	jz AritSh		; evalua si q1 es 0 y ya hemos verificado de q0 es 0, si q1 es 0 se deben hacer los shift rigth de lo contrario se hace A+M
	jmp A+M
fnd_Q_1_0:
	jmp load_Q_1
	jz A-M		; evalua si q1 es 0 y ya hemos verificado de q0 es 1, si es 0 se debe hacer A-M de lo contrario se hacen los shift rigth
	jmp AritSh
A+M:
	jmp load_M
	mov A, ACC
	jmp load_A
	add ACC, A	
	mov [DPTR], ACC	;A=A+M
	jmp AritSh
A-M:
	jmp load_M
	inv ACC
	mov A, ACC
	mov ACC, 0b0001
	add ACC, A	;C2 de M en Acc
	mov A, ACC	;C2 de M en registro A
	jmp load_A
	add ACC, A	
	mov [DPTR], ACC	;A=A-M
	jmp AritSh
addf:
	jmp load_Q_1
	lsh ACC, 0X7
	mov A, ACC
	jmp load_Q
	add ACC, A
	mov [DPTR], ACC
	ret
fand:
	jmp load_Q_1
	lsh ACC, 0X7
	mov A, ACC
	jmp load_Q
	and ACC, A
	mov [DPTR], ACC
	ret	
AritSh:
	jmp act_A_0	;en Q_1 queda guardado A_0 temporalmente
	jmp load_A
	mov ACC, 0b1000
	mov A, ACC
	jmp load_A
	rsh ACC, 0x1
	add ACC, A
	mov [DPTR], ACC	;Arithmetic Right Shift de A queda guardado en A

	jmp load_Q
	rsh ACC, 0X1
	mov A, ACC
	mov ACC, 0b1000
	and ACC, A
	jz addf
	jmp fand

	jmp act_Q_0	;Q0 queda guardado en q1

	jmp load_Q
	mov ACC, 0b1000
	mov A, ACC
	jmp load_Q
	rsh ACC, 0x1
	add ACC, A
	mov [DPTR], ACC	;Arithmetic Right Shift de A queda guardado en A

	jmp inicio	
fin: 
	jmp load_A
	hlt

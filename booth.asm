
; Multiplicador Eliana Cepeda, Laura Garzón, Liseth Lozano

variableA: 0b0 
Q: 0b10000001 ; Multiplicador
Q_1: 0b0
M: 0b11111101; Multiplicando
count: 0x8
Q_0: 0b0
A_0: 0b0
inicio:
	; Cargar count
	mov ACC, count 
	mov DPTR, ACC
	mov ACC, [DPTR]
	jz 0Xff		; se mueve al hlt
	jmp fnd_Q0_0

load_M:
	mov ACC, M 
	mov DPTR, ACC
	mov ACC, [DPTR]
	ret
load_A:
	mov ACC, varaibleA 
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
load_Q_0:
	mov ACC, Q_0
	mov DPTR, ACC
	mov ACC, [DPTR] 
	ret
load_A_0:
	mov ACC, A_0
	mov DPTR, ACC
	mov ACC, [DPTR] 
	ret
act_Q_0:
	jmp load_Q	
	mov A,ACC	; Q queda guardado en A
	mov ACC, Q_0	; Cargamos al DPTR Q_0
	mov DPTR, ACC
	mov ACC, 0b0001	;Cargar 1 para hallar el Q0
	and ACC, A	; And para determinar si el bit menos significacito es 1 o 0
	mov [DPTR],ACC	;queda actualizado Q_0 
	ret
act_A_0:
	jmp load_A	
	mov A,ACC	; variableA queda guardado en A
	mov ACC, A_0	; Cargamos al DPTR A_0
	mov DPTR, ACC
	mov ACC, 0b0001	;Cargar 1 para hallar el A0
	and ACC, A	; And para determinar si el bit menos significacito es 1 o 0
	mov [DPTR],ACC	;queda actualizado A_0 
	ret
fnd_Q0_0: 
	jmp act_Q_0	
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
	mov A,ACC
	jmp load_A
	add ACC,A	
	mov [DPTR],ACC	;A=A+M
	jmp AritSh
A-M:
	jmp load_M
	inv ACC
	mov A,ACC
	mov ACC, 0b0001
	add ACC,A	;C2 de M en Acc
	mov A,ACC	;C2 de M en registro A
	jmp load_A
	add ACC,A	
	mov [DPTR],ACC	;A=A-M
	jmp AritSh
AritSh:
	jmp act_A_0
	mov A,ACC
	jmp load_A
	rsh ACC, 0b0001
	and ACC,A
	mov [DPTR],ACC	;Arithmetic Right Shift de A queda guardado en A
	jmp act_Q_0
	mov A,ACC
	jmp load_Q_1
	mov ACC,A
	mov [DPTR],ACC	;Queda cargado Q0 en Q-1
	jmp load_A_0
	lsh ACC, 0x3
	mov A,ACC
	jmp load_Q
	rsh ACC,0b0001	;se hace el logical rigth shift de Q
	and ACC,A	;A Q se le pone como bit mas significativo A0
	mov [DPTR],ACC	;Q tiene guardado el nuevo Q con el right shift modificado
	jmp inicio	

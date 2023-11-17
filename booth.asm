inicio:
; Evalúa sí Acc es cero
	jz load_a
ind_1:
	; Se carga la variable Q a registro A
	mov ACC, Q
    mov DPTR, ACC
	mov ACC, [DPTR]
	mov A, ACC
	call fn_1 

	hlt ; Se detiene la ejecucion


load_a:
	; Se carga Variable A a Acc
	mov ACC, variableA
    mov DPTR, ACC
	mov ACC, [DPTR]
	jz ind_1
	hlt

fn_1:
	; Se carga Variable count a Acc
	mov ACC, count
    mov DPTR, ACC
	mov ACC, [DPTR]
	ret ;retorna al punto donde se ejecutó CALL CTE

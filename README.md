# Multiplicador-bit-a-bit
Se genera un codigo que hace una multiplicación bit a bit en una modificación de del procesador PDUA
## Set de instrucciones
ISA:

  NOP: 0X00
  MOV ACC, A: 0X01
  MOV A, ACC: 0X02
  MOV ACC, CTE: 0X03
  MOV ACC, [DPTR]: 0X04
  MOV DPTR, ACC: 0X05
  MOV [DPTR], ACC: 0X06
  INV ACC : 0X07
  AND ACC, A : 0X08
  ADD ACC, A : 0X09
  JMP CTE : 0X0A
  JZ CTE: 0X0B
  JN CTE : 0X0C
  JC CTE : 0X0D
  CALL CTE: 0X0E
  RET: 0X0F
  RSH ACC CTE : 0x10 
  LSH ACC CTE : 0x11
  HLT : 0Xff

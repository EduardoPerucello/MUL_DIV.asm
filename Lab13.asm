.model small
.STACK
.data
    msg DB 10,13, "Digite os numeros: $"
    msg2 DB 10,13, "Numero lido: $"
.code
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX  
    MOV AH,09
    LEA DX,msg
    INT 21H
    CALL ENTRADA
    CALL SAIDA
FIM:
    MOV AH,4CH
    INT 21H
MAIN ENDP
ENTRADA PROC
INICIO:
    XOR BX,BX
    XOR CX,CX
    MOV AH,01
    INT 21H
    CMP AL,'-'
    JE NEGA
    CMP AL,'+'
    JE POSI
    JMP VOLTA
NEGA:
    MOV CX,1
POSI:
    INT 21H
VOLTA:
    CMP AL,'0'
    JNGE INVALIDO
    CMP AL,'9'
    JNLE INVALIDO

    AND AX,0FH
    PUSH AX

    MOV AX,10
    MUL BX
    POP BX

    ADD BX,AX
    MOV AH,01
    INT 21H
    CMP AL,0DH
    JNE VOLTA

    MOV AX,BX
    OR CX,CX
    JE SAIR
    NEG AX
SAIR:
    RET
INVALIDO:
    MOV AH,02
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    JMP INICIO
ENTRADA ENDP
SAIDA PROC
    PUSH AX
    MOV AH,09
    LEA DX,msg2
    INT 21H
    POP AX
    OR AX,AX
    JGE FINAL
    PUSH AX
    MOV DL,'-'
    MOV AH,02
    INT 21H
    POP AX
    NEG AX
FINAL:
    XOR CX,CX
    MOV BX,10
REPETI:
    XOR DX,DX
    DIV BX
    PUSH DX
    INC CX

    OR AX,AX
    JNE REPETI

    MOV AH,02
LUP:
    POP DX
    OR DL,30H
    INT 21H
    LOOP LUP

    RET
SAIDA ENDP
END MAIN
section .data
    msg1 db "Digite o primeiro numero: ",0
    msg2 db "Digite o segundo numero: ",0
    msgOp db "Operacao (+ - * /): ",0
    msgRes db "Resultado: ",0
    newline db 10

section .bss
    num1 resb 4
    num2 resb 4
    op resb 2
    resultado resb 4

section .text
    global _start

_start:

; -------- pedir primeiro numero --------
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,25
int 0x80

mov eax,3
mov ebx,0
mov ecx,num1
mov edx,4
int 0x80

; -------- pedir segundo numero --------
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,25
int 0x80

mov eax,3
mov ebx,0
mov ecx,num2
mov edx,4
int 0x80

; -------- pedir operação --------
mov eax,4
mov ebx,1
mov ecx,msgOp
mov edx,18
int 0x80

mov eax,3
mov ebx,0
mov ecx,op
mov edx,2
int 0x80

; ----- converter ascii para numero     ----
mov eax,[num1]
sub eax,'0'

mov ebx,[num2]
sub ebx,'0'

; ----- escolher operação -----
mov cl,[op]

cmp cl,'+'
je soma

cmp cl,'-'
je subtracao

cmp cl,'*'
je multiplicacao

cmp cl,'/'
je divisao

; -------- soma ------
soma:
add eax,ebx
jmp mostrar

; ----- subtração -----
subtracao:
sub eax,ebx
jmp mostrar

; ----- multiplicação -----
multiplicacao:
imul eax,ebx
jmp mostrar

; ----- divisão -----
divisao:
mov edx,0
div ebx
jmp mostrar

; ------ mostrar resultado ------
mostrar:

add eax,'0'
mov [resultado],eax

mov eax,4
mov ebx,1
mov ecx,msgRes
mov edx,10
int 0x80

mov eax,4
mov ebx,1
mov ecx,resultado
mov edx,1
int 0x80

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 0x80

; -------- sair --------
mov eax,1
mov ebx,0
int 0x80
section .data
    msg1   db "Digite o primeiro numero: "
    len1   equ $-msg1

    msg2   db "Digite o segundo numero: "
    len2   equ $-msg2

    msgOp  db "Operacao (+ - * /): "
    len3   equ $-msgOp

    msgRes db "Resultado: "
    len4   equ $-msgRes

    newline db 10

section .bss
    num1   resb 12
    num2   resb 12
    op     resb 2
    resbuf resb 12

section .text
global _start

_start:
    ; --- ler num1 ---
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 12
    int 0x80

    ; --- ler num2 ---
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 12
    int 0x80

    ; --- ler operacao ---
    mov eax, 4
    mov ebx, 1
    mov ecx, msgOp
    mov edx, len3
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, op
    mov edx, 2
    int 0x80

    ; --- converter num1 string -> inteiro -> EDI ---
    mov esi, num1
    call str_to_int
    mov edi, eax

    ; --- converter num2 string -> inteiro -> ESI ---
    mov esi, num2
    call str_to_int
    mov esi, eax

    ; --- realizar operacao ---
    mov eax, edi
    mov ebx, esi
    mov cl, [op]

    cmp cl, '+'
    je  op_soma
    cmp cl, '-'
    je  op_sub
    cmp cl, '*'
    je  op_mult
    cmp cl, '/'
    je  op_divi
    jmp mostrar

op_soma:
    add eax, ebx
    jmp mostrar

op_sub:
    sub eax, ebx
    jmp mostrar

op_mult:
    imul eax, ebx
    jmp mostrar

op_divi:
    cdq
    idiv ebx
    jmp mostrar

mostrar:
    ; converter resultado (EAX) para string
    mov edi, resbuf
    call int_to_str

    ; imprimir "Resultado: "
    push ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, msgRes
    mov edx, len4
    int 0x80
    pop edx

    ; imprimir o numero
    mov eax, 4
    mov ebx, 1
    mov ecx, resbuf
    int 0x80

    ; newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; sair
    mov eax, 1
    mov ebx, 0
    int 0x80


; ─────────────────────────────────────────
; str_to_int
;   entrada: ESI = ponteiro para string
;   saida:   EAX = inteiro
; ─────────────────────────────────────────
str_to_int:
    xor eax, eax
.loop:
    movzx ecx, byte [esi]
    cmp cl, '0'
    jl  .done
    cmp cl, '9'
    jg  .done
    sub cl, '0'
    imul eax, eax, 10
    add eax, ecx
    inc esi
    jmp .loop
.done:
    ret


; ─────────────────────────────────────────
; int_to_str
;   entrada: EAX = inteiro, EDI = buffer
;   saida:   ECX = tamanho da string
; ─────────────────────────────────────────
int_to_str:
    xor ecx, ecx
    mov ebx, 10

    ; verificar se negativo
    cmp eax, 0
    jge .positivo
    neg eax
    mov byte [edi], '-'
    inc edi
    inc ecx

.positivo:
    ; guardar ponteiro de inicio dos digitos
    mov esi, edi

.extrair:
    xor edx, edx
    div ebx
    add dl, '0'
    mov [edi], dl
    inc edi
    inc ecx
    cmp eax, 0
    jne .extrair

    ; reverter os digitos
    dec edi
.reverter:
    cmp esi, edi
    jge .fim
    mov al, [esi]
    mov bl, [edi]
    mov [esi], bl
    mov [edi], al
    inc esi
    dec edi
    jmp .reverter

.fim:
    ret
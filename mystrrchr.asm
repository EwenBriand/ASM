SECTION .text
   GLOBAL strrchr


strrchr:
    push rbp
    push rdi
    push rsi
    mov rbp, rsp
    xor rax, rax
    jmp rchrloop


change_rax:
    mov rax, rdi
    jmp after_change

rchrloop:
    cmp sil, byte [rdi]
    je change_rax

after_change:
    cmp byte [rdi], 0
    je strrchr_end
    inc rdi
    jmp rchrloop

strrchr_end:
    pop rsi
    pop rdi
    pop rbp
    ret




; SECTION .text
;   GLOBAL strrchr

; strrchr:
;     push rbp
;     push rdi
;     push rsi
;     push r10
;     mov rbp, rsp
;     mov r10, -1
;     mov rax , 0

; chrrloop:
;     inc  r10
;     cmp byte [rdi + r10] , sil
;     je chrrloop_true
;     cmp byte [rdi + r10] , 0
;     jne chrrloop

;     pop r10
;     pop rsi
;     pop rdi
;     pop rbp
;     ret

; chrrloop_true:
;   lea rax, [rdi + r10]
;   jmp chrrloop

section    .text
   [global strrchr:]

strrchr_end:
    pop rsi
    pop rdi
    pop rbp
    ret

change_rax:
    mov rax, rdi
    jmp after_change

loop:
    cmp sil, byte [rdi]
    je change_rax
after_change:
    cmp byte [rdi], 0
    je strrchr_end
    inc rdi
    jmp loop

strrchr:
    push rbp
    push rdi
    push rsi
    mov rbp, rsp
    xor rax, rax
    jmp loop


SECTION .text
    global strncmp

strncmp:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    push rdx
    push r10
    push r8
    xor r10, r10
    xor r8, r8

mloop:
    cmp rdx, 0
    jle end
    mov r10b, byte [rdi]
    mov r8b, byte [rsi]
    cmp r10b, r8b
    jne end
    inc rsi
    inc rdi
    dec rdx
    jmp mloop

end:
    sub r10b, r8b
    movsx rax, r10b
    pop r8
    pop r10
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret

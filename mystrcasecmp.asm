
SECTION .text
    global strcasecmp

mystrcasecmp:
    push rbp
    mov rcx, -1

strcasecmploop:
    inc rcx
    mov al, byte [rdi + rcx]
    mov r8b, byte [rsi + rcx]

    cmp al, 'Z'
    jle a_change

b_upper:
    cmp r8b, 'Z'
    jle b_change

compare:
    cmp al, r8b
    jne  end_false
    cmp al , 0
    jne strcasecmploop

    mov rax , 0
    pop rbp
    ret

a_change:
    cmp al, 'A'
    jl b_upper
    add al, 32
    jmp b_upper

b_change:
    cmp r8b, 'A'
    jl compare
    add r8b, 32
    jmp compare

end_false:
    sub al, r8b
    movsx rax, al
    pop rbp
    ret

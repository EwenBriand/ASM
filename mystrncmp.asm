
SECTION .text
    GLOBAL strncmp

strncmp:
    push rbp
    push rdi
    push rsi
    push rcx
    push rdx
    mov rbp, rsp
    xor rcx, rcx
    mov rax, 0
    jmp ncmploop

ncmploop:
    cmp rcx, rdx
    jge end
    mov al, [rdi + rcx]
    mov bl, [rsi + rcx]
    cmp al, bl
    jne end
    cmp al, 0
    je end
    inc rcx
    jmp ncmploop

end2:
    xor rax, rax
    pop rdx
    pop rcx
    pop rsi
    pop rdi
    pop rbp
    ret

end:
    sub al, bl
    movsx rax, al
    cmp rdx, 0
    je end2
    pop rdx
    pop rcx
    pop rsi
    pop rdi
    pop rbp
    ret

; SECTION .text
;     global strncmp

; strncmp:
;     push rbp
;     mov rbp, rsp
;     push rdi
;     push rsi
;     push rdx
;     push r10
;     push r8
;     xor r10, r10
;     xor r8, r8

; mloop:
;     cmp rdx, 0
;     jle end
;     mov r10b, byte [rdi]
;     mov r8b, byte [rsi]
;     cmp r10b, r8b
;     jne end
;     inc rsi
;     inc rdi
;     dec rdx
;     jmp mloop

; end:
;     sub r10b, r8b
;     movsx rax, r10b
;     pop r8
;     pop r10
;     pop rdx
;     pop rsi
;     pop rdi
;     pop rbp
;     ret

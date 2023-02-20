
SECTION .text
    global strstr


strstr:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    push rdx
    push r10
    mov r10, rdi
    mov rdi, rsi
    call strlen
    mov rdx, rax
    mov rdi, r10
    cmp rdx, 0
    jle end_zero

msloop:
    cmp byte [rdi], 0
    je end_f
    call strncmp
    cmp rax, 0
    je end_s_true
    inc rdi
    jmp msloop

end_f:
    mov rax, 0
    pop r10
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret

end_s_true:
  mov rax, rdi
  pop r10
  pop rdx
  pop rsi
  pop rdi
  pop rbp
  ret


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

mmloop:
    cmp rdx, 0
    jle end
    mov r10b, byte [rdi]
    mov r8b, byte [rsi]
    cmp r10b, r8b
    jne end
    inc rsi
    inc rdi
    dec rdx
    jmp mmloop

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

strlen:
    push rbp
    push rdi
    mov rbp, rsp
    mov rax, 0
    cmp byte [rdi], 0
    je void

.Lloop:                       ; do {
    inc  rax                  ; ++p
    cmp byte [rdi + rax] , 0
    jne .Lloop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    pop rdi
    pop rbp
    ret

void:
    mov rax, 0
    pop rdi
    pop rbp
    ret

end_zero:
    mov rax, rdi
    pop r10
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret

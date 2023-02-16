SECTION .text
  Global strcmp

strcmp:
    push rbp
    push rdi
    push rsi
    push r10
    push r8
    mov rbp, rsp
    mov r10, -1

strcmploop:                       ; do {
    inc  r10                  ; ++p
    mov al, byte [rdi + r10]
    mov r8b, byte [rsi + r10]
    cmp al, r8b
    jne  end_false
    cmp al , 0
    jne strcmploop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data

    mov rax , 0
    pop r8
    pop r10
    pop rsi
    pop rdi
    pop rbp
    ret

end_false:
    sub al, r8b
    movsx rax, al
    pop r8
    pop r10
    pop rsi
    pop rdi
    pop rbp
    ret

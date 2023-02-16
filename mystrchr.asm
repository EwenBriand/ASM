SECTION .text
  GLOBAL strchr

strchr:
    push rbp
    push rdi
    push rsi
    push r10
    mov rbp, rsp
    mov r10, -1

chrloop:                       ; do {
    inc  r10                  ; ++p
    cmp byte [rdi + r10] , sil
    je  end_true
    cmp byte [rdi + r10] , 0
    jne chrloop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data

    mov rax , 0
    pop r10
    pop rsi
    pop rdi
    pop rbp
    ret

end_true:
    lea rax , [rdi + r10]
    pop r10
    pop rsi
    pop rdi
    pop rbp
    ret

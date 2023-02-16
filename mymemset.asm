SECTION .text
  GLOBAL memset

memset:
    push rbp
    push rdi
    push rsi
    push r10
    mov rbp, rsp
    mov r10, 0

setloop:                       ; do {
    mov byte [rdi + r10], sil
    inc  r10                  ; ++p
    cmp rdx , r10
    jne setloop            ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    lea rax, [rdi]
    pop r10
    pop rsi
    pop rdi
    pop rbp
    ret

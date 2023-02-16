SECTION .text
  GLOBAL memcpy

memcpy:
    push rbp
    push rdi
    push rsi
    push rdx
    push r10
    mov rbp, rsp
    mov r10, -1

cpyloop:                       ; do {
    inc  r10                  ; ++p
    mov al, byte [rsi + r10]
    mov byte [rdi + r10], al
    cmp rdx , r10
    jne cpyloop            ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    lea rax, [rdi]
    pop r10
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret

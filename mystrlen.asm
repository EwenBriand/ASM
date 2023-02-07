SECTION .text
  GLOBAL mystrlen


mystrlen:
    push rbp
    push rdi
    mov rbp, rsp
    mov rax, 0

.Lloop:                       ; do {
    inc  rax                  ; ++p
    cmp byte [rdi + rax] , 0
    jne .Lloop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    pop rdi
    pop rbp
    ret

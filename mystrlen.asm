SECTION .text
  GLOBAL strlen


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

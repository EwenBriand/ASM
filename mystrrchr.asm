SECTION .text
  GLOBAL strrchr

mystrrchr:
    push rbp
    push rdi
    push rsi
    push r10
    mov rbp, rsp
    mov r10, -1
    mov rax , 0

chrrloop:                       ; do {
    inc  r10                  ; ++p
    cmp byte [rdi + r10] , sil
    je chrrloop_true
    cmp byte [rdi + r10] , 0
    jne chrrloop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    pop r10
    pop rsi
    pop rdi
    pop rbp
    ret

chrrloop_true:
  lea rax, [rdi + r10]
  jmp chrrloop

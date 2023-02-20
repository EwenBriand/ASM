SECTION .text
  GLOBAL memcpy

memcpy:
    push rbp
    push rdi
    push rsi
    push rdx
    push r10
    mov rbp, rsp
    sub rdx, 1
    mov r10, -1
    cmp rdi, 0
    je  endMEMCPY
    cmp rsi, 0
    je  endMEMCPY
    cmp rdx, 0
    jle  endMEMCPY

cpyloop:                       ; do {
    inc  r10                  ; ++p
    mov al, byte [rsi + r10]
    mov byte [rdi + r10], al
    cmp al, 0
    je endcpy
    cmp rdx , r10
    jne cpyloop            ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
endcpy:
    lea rax, [rdi]
    pop r10
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret

endMEMCPY:
    mov rax, 0
    pop r10
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret

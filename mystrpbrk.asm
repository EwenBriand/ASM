SECTION .text
  global mystrpbrk


mystrpbrk:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    push r8

wloop:
    cmp byte [rdi], 0
    je end
    mov r10, rsi
floop:
    cmp byte [r10], 0
    je incloop
    mov r8b, byte [r10]
    cmp byte [rdi], r8b
    je end_t
    inc r10
    jmp floop

incloop:
    inc rdi
    jmp wloop

end_t:
    mov rax, rdi
    pop r8
    pop rsi
    pop rdi
    pop rbp
    ret


end:
    mov rax, 0
    pop r8
    pop rsi
    pop rdi
    pop rbp
    ret

; mystrpbrk:
;   push rbp
;   push rdi
;   push rsi
;   push rcx
;   push r8
;   mov rcx, -1
;   mov r8, rsi

; pbrkloop:
;   inc rcx
;   mov rsi, [r8 + rcx]
;   call strchr
;   cmp rax, 0
;   jne end_p_true
;   cmp rsi, 0
;   jne pbrkloop

;   pop r8
;   pop rcx
;   pop rsi
;   pop rbp
;   mov rax, 0
;   ret

; end_p_true:
;   pop r8
;   pop rcx
;   pop rsi
;   pop rbp
;   ret



; strchr:
;     push rbp
;     push rdi
;     push rsi
;     push r10
;     mov rbp, rsp
;     mov r10, -1

; chrloop:                       ; do {
;     inc  r10                  ; ++p
;     cmp byte [rdi + r10] , sil
;     je  end_true
;     cmp byte [rdi + r10] , 0
;     jne chrloop             ; }while(*p != 0);
;                            ; RAX points at the terminating 0 byte = one-past-end of the real data

;     mov rax , 0
;     pop r10
;     pop rsi
;     pop rdi
;     pop rbp
;     ret

; end_true:
;     lea rax , [rdi + r10]
;     pop r10
;     pop rsi
;     pop rdi
;     pop rbp
;     ret

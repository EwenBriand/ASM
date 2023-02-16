
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

; mystrstr:
;     push rbp
;     mov rbp, rsp
;     push rdi
;     push rsi
;     push rdx
;     push rcx
;     push r12
;     push r11
;     push r10
;     push r8
;     mov r10, rdi
;     mov rdi, rsi
;     call strlen
;     mov rcx, rax
;     mov r8, -1

; strloop:
;   inc r8

;   mov rsi, rdi
; t1:
;   inc r10
;   t3:
;   mov rdi, r10
; t2:
;   mov rdx, rcx
; bef:
;   call strncmp
;   mov r12, rax

;   cmp r12, 0
;   je end_s_true
;   cmp r12, 0
;   jl end_s_false

;   cmp r10b, 0
;   jne strloop


end_s_true:
  mov rax, rdi
  pop r10
  pop rdx
  pop rsi
  pop rdi
  pop rbp
  ret


; end_s_false:
;   mov rax, 0
;   pop r8
;   pop r10
;   pop r11
;   pop r12
;   pop rcx
;   pop rdx
;   pop rsi
;   pop rdi
;   pop rbp
;   ret

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

.Lloop:                       ; do {
    inc  rax                  ; ++p
    cmp byte [rdi + rax] , 0
    jne .Lloop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    pop rdi
    pop rbp
    ret

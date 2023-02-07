SECTION .text
  GLOBAL memmove

; mymemmove:
;     push rbp
;     mov rbp, rsp

;     mov r10, -1

; mloop:
;     inc r10
;     mov al, byte [rsi + r10]
;     mov byte [rdi + r10], al
;     cmp rdx, r10
;     jne mloop

;     mov rax, rdi
;     pop rbp
;     ret

mymemmove:
    push rbp
    push rdi
    push rsi
    push rdx
    push r10
    mov rbp, rsp
    mov r10, -1
    mov rax, 0

    cmp rdi, rsi
    je finish
    cmp rdi, rsi
    jg great
    jmp less

great:
    inc  r10
    mov al, byte [rsi + r10]
    mov byte [rdi + r10], al
    cmp rdx, r10
    jne great

    mov rax, rdi
    pop r10
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret

less:
    sub rdx, 1
    mov al, byte [rsi + rdx]
    mov byte [rdi + rdx], al
    cmp byte [rdx], 1
    jne less

    mov rax, rdi
    pop r10
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret

finish:
    mov rax, rdi
    pop r10
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret

; mymemmove:
;     push rbp
;     mov rbp, rsp

;     cmp rdi, rsi
;     je memmove_equal

;     cmp rdi, rsi
;     jb memmove_backward

; memmove_forward:
;     cld
;     rep movsb
;     jmp memmove_end

; memmove_backward:
;     lea edx, [esi + ecx - 1]
;     lea edi, [esi + ecx - 1]
;     std
;     rep movsb
;     cld

; memmove_end:
;     mov rsp, rbp
;     pop rbp
;     ret

; memmove_equal:
;     mov rsp, rbp
;     pop rbp
;     ret

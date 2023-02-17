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

memmove:
    push rbp
    push rdi
    push rsi
    push rdx
    push r10
    mov rbp, rsp
    mov r10, -1
    sub rdx, 1
    mov rax, 0

    cmp rdi, 0
    je  endMEMMOVE
    cmp rsi, 0
    je  endMEMMOVE
    cmp rdx, 0
    jle  endMEMMOVE

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

    lea rax, [rdi]
    pop r10
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret

less:
    sub rdx, 1
    mov al, byte [rsi + rdx]
l1:
    mov byte [rdi + rdx], al
l2:
    cmp rdx, 0
l3:
    jne less

    mov rax, rdi
l4:
    pop r10
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret

finish:
    lea rax, [rdi]
    pop r10
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret


endMEMMOVE:
    mov rax, 0
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


; strlen vide ok
; mem... ptete null
; strncmp taille trops grande stop \0
; strrchr a revoir when \0
; strstr a revoir when \0

SECTION .text
  GLOBAL strlen
  GLOBAL strchr
  GLOBAL strrchr
  GLOBAL memset
  GLOBAL memcpy
  Global strcmp
  GLOBAL memmove
  GLOBAL strncmp
  GLOBAL strcasecmp
  GLOBAL strstr
  GLOBAL mystrpbrk
  GLOBAL mystrcspn

strlen:
    push rbp
    mov rax, 0

.Lloop:                       ; do {
    inc  rax                  ; ++p
    cmp byte [rdi + rax] , 0
    jne .Lloop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    pop rbp
    ret

strchr:
    push rbp
    mov r10, -1

chrloop:                       ; do {
    inc  r10                  ; ++p
    cmp byte [rdi + r10] , sil
    je  end_true
    cmp byte [rdi + r10] , 0
    jne chrloop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data

    mov rax , 0
    pop rbp
    ret

end_true:
    lea rax , [rdi + r10]
    pop rbp
    ret

strrchr:
    push rbp
    mov r10, -1
    mov rax , 0

chrrloop:                       ; do {
    inc  r10                  ; ++p
    cmp byte [rdi + r10] , sil
    je chrrloop_true
    cmp byte [rdi + r10] , 0
    jne chrrloop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    pop rbp
    ret

chrrloop_true:
  lea rax, [rdi + r10]
  jmp chrrloop

memset:
    push rbp
    mov r10, 0

setloop:                       ; do {
    mov byte [rdi + r10], sil
    inc  r10                  ; ++p
    cmp rdx , r10
    jne setloop            ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    lea rax, [rdi]
    pop rbp
    ret

memcpy:
    push rbp
    mov r10, -1

cpyloop:                       ; do {
    inc  r10                  ; ++p
    mov al, byte [rsi + r10]
    mov byte [rdi + r10], al
    cmp rdx , r10
    jne cpyloop            ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    lea rax, [rdi]
    pop rbp
    ret

strcmp:
    push rbp
    mov r10, -1

strcmploop:                       ; do {
    inc  r10                  ; ++p
    mov al, byte [rdi + r10]
    mov r8b, byte [rsi + r10]
    cmp al, r8b
    jne  end_false
    cmp al , 0
    jne strcmploop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data

    mov rax , 0
    pop rbp
    ret

end_false:
    sub al, r8b
    movsx rax, al
    pop rbp
    ret

memmove:
  push rbp
  call memcpy
  pop rbp

strncmp:
    push rbp
    mov r10, -1

strncmploop:                       ; do {
    inc  r10                  ; ++p
    mov al, byte [rdi + r10]
    mov r8b, byte [rsi + r10]
    cmp al, r8b
    jne  end_n_false
    cmp al , 0
    je  end_n_true
    cmp r10 , rdx
    jne strncmploop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data

    mov rax , 0
    pop rbp
    ret

end_n_false:
    sub al, r8b
    movsx rax, al
    pop rbp
    ret

end_n_true:
    mov rax, 0
    pop rbp
    ret

strcasecmp:
    push rbp
    mov rcx, -1

strcasecmploop:
    inc rcx
    mov al, byte [rdi + rcx]
    mov r8b, byte [rsi + rcx]

    cmp al, 'Z'
    jle a_change

b_upper:
    cmp r8b, 'Z'
    jle b_change

compare:
    cmp al, r8b
    jne  end_false
    cmp al , 0
    jne strcasecmploop

    mov rax , 0
    pop rbp
    ret

a_change:
    cmp al, 'A'
    jl b_upper
    add al, 32
    jmp b_upper

b_change:
    cmp r8b, 'A'
    jl compare
    add r8b, 32
    jmp compare


strstr:
    push rbp
    mov r10, rdi
    mov rdi, rsi
    call strlen
    mov rcx, rax
    mov r8, -1

strloop:
  inc r8

  mov r11, [r10 + r8]
  mov rsi, rdi
  mov rdi, r11
  mov rdx, rcx
  call strncmp
  mov r12, rax

  cmp r12, 0
  je end_s_true
  cmp r12, 0
  jl end_s_false

  cmp r8, 0
  jne strloop


end_s_true:
  mov rax, rdi
  pop rbp
  ret


end_s_false:
  mov rax, 0
  pop rbp
  ret

mystrpbrk:
  push rbp
  mov rcx, -1
  mov r8, rsi

pbrkloop:
  inc rcx
  mov rsi, [r8 + rcx]
  call strchr
  cmp rax, 0
  jne end_p_true
  cmp rsi, 0
  jne pbrkloop

  pop rbp
  mov rax, 0
  ret

end_p_true:
  pop rbp
  ret

mystrcspn:
  push rbp
  mov rcx, -1
  mov r8, rdi
  mov rdi, rsi

cspnloop:  
  inc rcx
  mov rsi, [r8 + rcx]
  call strchr
  cmp rax, 0
  je cspnloop

  mov rax, rcx
  pop rbp
  ret
  

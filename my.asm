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

strlen:
    mov rax, 0

.Lloop:                       ; do {
    inc  rax                  ; ++p
    cmp byte [rdi + rax] , 0
    jne .Lloop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    ret

strchr:
    mov r10, -1

chrloop:                       ; do {
    inc  r10                  ; ++p
    cmp byte [rdi + r10] , sil
    je  end_true
    cmp byte [rdi + r10] , 0
    jne chrloop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data

    mov rax , 0
    ret

end_true:
    lea rax , [rdi + r10]
    ret

strrchr:
    mov r10, -1
    mov rax , 0

chrrloop:                       ; do {
    inc  r10                  ; ++p
    cmp byte [rdi + r10] , sil
    je chrrloop_true
    cmp byte [rdi + r10] , 0
    jne chrrloop             ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    ret

chrrloop_true:
  lea rax, [rdi + r10]
  jmp chrrloop

memset:
    mov r10, 0

setloop:                       ; do {
    mov byte [rdi + r10], sil
    inc  r10                  ; ++p
    cmp rdx , r10
    jne setloop            ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    lea rax, [rdi]
    ret

memcpy:
    mov r10, -1

cpyloop:                       ; do {
    inc  r10                  ; ++p
    mov al, byte [rsi + r10]
    mov byte [rdi + r10], al
    cmp rdx , r10
    jne cpyloop            ; }while(*p != 0);
                           ; RAX points at the terminating 0 byte = one-past-end of the real data
    lea rax, [rdi]
    ret

strcmp:
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
    ret

end_false:
    sub al, r8b
    movsx rax, al
    ret

memmove:
  call memcpy
  mov rax, 10
  mov al, 10

strncmp:
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
    ret

end_n_false:
    sub al, r8b
    movsx rax, al
    ret

end_n_true:
    mov rax, 0
    ret

strcasecmp:
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

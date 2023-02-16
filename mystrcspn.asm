SECTION .text
  global strcspn


strcspn:
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
  

strchr:
    push rbp
    push rdi
    push rsi
    push r10
    mov rbp, rsp
    mov r10, -1

chrloop:
    inc  r10
    cmp byte [rdi + r10] , sil
    je  end_true
    cmp byte [rdi + r10] , 0
    jne chrloop

    mov rax , 0
    pop r10
    pop rsi
    pop rdi
    pop rbp
    ret

end_true:
    lea rax , [rdi + r10]
    pop r10
    pop rsi
    pop rdi
    pop rbp
    ret

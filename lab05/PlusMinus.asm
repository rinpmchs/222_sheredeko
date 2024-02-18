	.text
  main:
    li a7, 5
    ecall
    mv t0, a0
    
    add t1, t1, zero  # for ans
    li t2, 2
    rem t2, t0, t2
    j odd
    
  even:
    beqz t0, end
    addi t0, t0, -1
    
    li a7, 5
    ecall
    sub t1, t1, a0
    
    j odd
    
  odd:
    beqz t0, end
    addi t0, t0, -1
    
    li a7, 5
    ecall
    add t1, t1, a0
    
    j even
    
  end:
    li a7, 1
    mv a0, t1
    ecall
  
    li a0, '\n'
    li a7, 11
    ecall

	.data
  data:
    .word 0, 0, 0, 0

	.text
  main:
    la t2, data
    
    li a7, 5
    ecall
    sw a0, 0(t2)
    
    li a7, 5
    ecall
    sw a0, 4(t2)
    
    li a7, 5
    ecall
    sw a0, 8(t2)
    
    li a7, 5
    ecall
    sw a0, 12(t2)
    
    lw t0, 0(t2)
    lw t1, 8(t2)
    add a0, t0, t1  # print first + third
    li a7, 1
    ecall
    
    li a0, '\n'
    li a7, 11
    ecall
      
    lw t0, 4(t2)
    lw t1, 12(t2)
    add a0, t0, t1  # print second + last
    li a7, 1
    ecall
    
    li a0, '\n'
      li a7, 11
      ecall


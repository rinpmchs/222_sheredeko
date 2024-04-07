	.text

main:
  li s0, 10
  li s1, 1
  li s2, 2
  li s4, 4
  fcvt.d.w fs1, s1 # 1
  fcvt.d.w fs2, s2 # 2
  fcvt.d.w fs4, s4 # 4
  
  li a7, 5
  ecall
  mv t0, a0  # n
  
  li t1, 1
  li t6, 10000
  fmv.d ft0, fs4  # pi = 4
  
  leibniz:
    beq t1, t6, leibniz_end
    fcvt.d.w ft1, t1
    fmul.d ft1, fs2, ft1
    fadd.d ft1, ft1, fs1
    fdiv.d ft1, fs1, ft1
    fmul.d ft1, ft1, fs4
    
    rem t2, t1, s2
    beqz t2, even
    
  odd:
    fsub.d ft0, ft0, ft1
    addi t1, t1, 1
    j leibniz
    
  even:
    fadd.d ft0, ft0, ft1
    addi t1, t1, 1
    j leibniz
    
  leibniz_end:
  
  li t1, 1
  mv t6, t0 # n
  
  pow:
    beqz t6, pow_end
    mul t1, t1, s0
    addi t6, t6, -1
    j pow
    
  pow_end:
  
  round:
    fcvt.d.w ft1, t1 # ft1 = 10^n
    fmul.d ft0, ft0, ft1  # ft0 = A * 10^n
    fcvt.w.d t1, ft0 # A * 10^n form double to int
    fcvt.d.w ft0, t1 # A * 10^n from int to double
    fdiv.d ft0, ft0, ft1 # ft0 = A
  
  output:
    li a7, 3
    fmv.d fa0, ft0
    ecall
    li a7, 11
    li a0, '\n'
    ecall
  
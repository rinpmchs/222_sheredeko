li a7, 5
ecall
mv t0, a0
ecall
mv t1, a0
ecall
fcvt.s.w f0, t0, dyn    
fcvt.s.w f1, t1, dyn 
fdiv.s fa0, f0, f1, dyn
jal fracTrunket
j print
  
fracTrunket:
 li t0, 10
 li t1, 10
 mv s0, a0
multiplier:
 beqz s0, cont
 mul t0, t0, t1
 addi s0, s0, -1
 j multiplier
cont:
 fcvt.s.w f1, t0, dyn     
 fmul.s fa0, fa0, f1
 fcvt.w.s t1, fa0, dyn 
 li t2, 10
 div t1, t1, t2
 fcvt.s.w fa1, t1, dyn
 div t0, t0, t2
 fcvt.s.w f1, t0, dyn  
 fdiv.s fa0, fa1, f1
 jr ra
print:
 li a7, 2
 ecall
 li a0, '\n'
 li a7, 11
 ecall
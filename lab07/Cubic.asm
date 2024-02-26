	.text
li a7, 6
ecall
fmv.s ft0, fa0

li a7, 6
ecall
fmv.s ft1, fa0

li t1, 0
fcvt.s.w f2, t1, dyn
flt.s t1, ft0, f2

beqz t1, greater
li t1, -1
fcvt.s.w f28, t1, dyn
fmul.s ft0, ft0, f28
j prep

greater:
 li t1, 1
 fcvt.s.w f28, t1, dyn
 
prep:
 li t0, 0
 fcvt.s.w ft2, t0, dyn
 fsqrt.s ft3, ft0, dyn
 li t1, 2
 fcvt.s.w ft7, t1, dyn
 
find_answer:
 fadd.s ft4, ft2, ft3, dyn
 fdiv.s ft4, ft4, ft7, dyn
 feq.s t4, ft2, ft4
 beqz t4, cont
 j exit
 
cont:
 feq.s t4, ft3, ft4
 beqz t4, cont1
 j exit
 
cont1:
 fmul.s ft5, ft4, ft4, dyn
 fmul.s fs1, ft4, ft5, dyn
 fsub.s ft5, fs1, ft0, dyn
 fmv.s fa0, ft5
 fmv.s fa1, ft0
 fmv.s fa2, ft1
 jal check_answer
 beqz t0, exit
 li t0, 0
 fcvt.s.w ft6, t0, dyn 
 fgt.s t0, ft5, ft6
 beqz t0, renew_M
 fmv.s ft3, ft4
 j find_answer
 
renew_M:
 fmv.s ft2, ft4
 j find_answer
 
check_answer:
 li t0, 0
 fmv.s.x  ft6, t0  
 flt.s t0, fa0, ft6
 beqz t0, pos
 li t0, -1
 fcvt.s.w  ft6, t0, dyn 
 fmul.s fa0, fa0, ft6
 
pos:
 fle.s t0, fa0, fa2
 beqz t0, not_answer
 li t0, 0 # ft4 is answer
 jr ra
not_answer:
 li t0, 1
 jr ra
 
exit:
 fmul.s ft4, ft4, f28, dyn
 fmv.s fa0, ft4
 li a7, 2
 ecall
 li a7, 11
 li a0, '\n'
 ecall
finish:

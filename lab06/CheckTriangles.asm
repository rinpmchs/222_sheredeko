.macro read_int(%x)
   li a7, 5
   ecall
   mv %x, a0
   .end_macro
   
.macro print_char(%x)
   li a7, 11
   li a0, %x
   ecall
   .end_macro

	.text
    j main
check:
    beqz t0, zero_1
    j continue
  zero_1:
    beqz t1, zero_2
    j continue
  zero_2:
    beqz t2, all_zeros
    j continue
    
  continue:
    add t4, t0, t1
    add t5, t0, t2
    add t6, t1, t2

    blt t6, t0, invalid_triangle
    blt t5, t1, invalid_triangle
    blt t4, t2, invalid_triangle
    
    li t3, 1  # valid
    ret
    
  all_zeros:
    li t3, 0
    ret

  invalid_triangle:
    li t3, 2
    ret

	.text
  main:
    
  while:
    read_int(t0)
    read_int(t1)
    read_int(t2)
    
    jal check
    
    beqz t3, end
    li s0, 1
    beq t3, s0, valid
    j invalid
    
  valid:
    print_char('Y')
    print_char('\n')
    j while
    
  invalid:
    print_char('N')
    print_char('\n')
    j while
    
  end:
    print_char('\n')
    
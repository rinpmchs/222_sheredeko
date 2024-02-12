# Input an integer (can be negative), and output the sum of its digits.
	.text
  main:    
    li a7, 5
    ecall
    mv t0, a0
    li t1, 10
    li t2, 0
 
  calc_sum:
    bltz t0, negative
    beqz t0, print_ans
    rem t3, t0, t1
    add t2, t2, t3
    div t0, t0, t1
    j calc_sum
    
  negative:
    li t6, -1
    mul t0, t0, t6
    j calc_sum
    
  print_ans:
    li a7, 1
    mv a0, t2
    ecall
    
    li a0, '\n'
    li a7, 11
    ecall

    
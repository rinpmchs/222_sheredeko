#
# (x + 5) - (y - 7)
#
    .text
main:
    addi a7, zero, 5
    ecall
    add t0, zero, a0

    addi a7, zero, 5
    ecall
    add t1, zero, a0
    
    addi t0, t0, 5
    addi t1, t1, -7
    
    neg t1, t1
    add t2, t0, t1

    add a0, zero, t2
    addi a7, zero, 1
    ecall

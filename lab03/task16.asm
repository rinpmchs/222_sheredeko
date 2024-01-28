#
# x < -5 & y > 10
#

    .text
main:
    addi a7, zero, 5
    ecall
    add t0, zero, a0
    
    addi a7, zero, 5
    ecall
    add t1, zero, a0
    
    slti t0, t0, -5
    li t2, 10
    sgt t1, t1, t2
    and a0, t0, t1
    
    addi a7, zero, 1
    ecall

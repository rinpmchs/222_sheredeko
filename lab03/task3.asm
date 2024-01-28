#
# (x << y) - 10
#
    .text
main:
    addi a7, zero, 5
    ecall
    add t0, zero, a0

    addi a7, zero, 5
    ecall
    add t1, zero, a0
    
    sll t0, t0, t1
    addi t0, t0, -10

    add a0, zero, t0
    addi a7, zero, 1
    ecall

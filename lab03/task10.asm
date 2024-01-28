#
# x & (-1 << 5)
#

    .text
main:
    addi a7, zero, 5
    ecall
    add t0, zero, a0
    
    li t1, -1
    slli t1, t1, 5  # -1 << 5
    and a0, t0, t1  # x & (-1 << 5)
    
    addi a7, zero, 1
    ecall

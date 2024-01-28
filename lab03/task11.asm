#
# x | (-1 >> 27) (>> - logical shift)
#

    .text
main:
    addi a7, zero, 5
    ecall
    add t0, zero, a0
    
    li t1, -1
    srli t1, t1, 27  # -1 << 27
    or a0, t0, t1  # x | (-1 >> 27)
    
    addi a7, zero, 1
    ecall

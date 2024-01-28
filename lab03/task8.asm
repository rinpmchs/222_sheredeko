#
# (x + 5) / y + 10 / (y - 1)
#

    .text
main:
    addi a7, zero, 5
    ecall
    add t0, zero, a0

    addi a7, zero, 5
    ecall
    add t1, zero, a0
    
    # t2 is temp
    addi t0, t0, 5  # x + 5
    div t0, t0, t1  # (x + 5) / y
    addi t1, t1, -1  # y - 1
    li t2, 10
    div t1, t2, t1  # 10 / (y - 1)
    add a0, t0, t1
    
    addi a7, zero, 1
    ecall

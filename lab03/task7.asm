#
# 2 * x * x - 3 * y + 4
#

    .text
main:
    addi a7, zero, 5
    ecall
    add t0, zero, a0

    addi a7, zero, 5
    ecall
    add t1, zero, a0
    
    # t2 is temp for saving the result of intermediate multiplication
    slli t2, t0, 1  # t2 = x * 2
    mul t0, t0, t2  # t0 = x * x * 2
    
    slli t2, t1, 1  # t1 = y * 2
    add t1, t1, t2  # t1 = t + t * 2 = y * 3
    
    sub a0, t0, t1
    addi a0, a0, 4
    addi a7, zero, 1
    ecall
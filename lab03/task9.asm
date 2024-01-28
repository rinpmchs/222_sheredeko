#
# (x / y) * y + x % y
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
    div t2, t0, t1  # x / y
    mul t2, t2, t1  # x / y * y
    rem t0, t0, t1  # x % y
    add a0, t2, t0  # x / y * y + x % y
    
    addi a7, zero, 1
    ecall

#
# ((x << 2) - y + 5) >> 1  (>> - arithmetical shift)
#
    .text
main:
    addi a7, zero, 5
    ecall
    add t0, zero, a0

    addi a7, zero, 5
    ecall
    add t1, zero, a0
    
    slli t0, t0, 2
    sub t0, t0, t1
    addi t0, t0, 5
    srai t0,t0, 1

    add a0, zero, t0
    addi a7, zero, 1
    ecall

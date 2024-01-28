#
# reset the y-th bit of x to 0 (bit numbers start from 0)
#

    .text
main:
    addi a7, zero, 5
    ecall
    add t0, zero, a0
    
    addi a7, zero, 5
    ecall
    add t1, zero, a0
    
    li t2,1
    sll t1, t2, t1
    not t1, t1  # 16-17: create a mask
    and a0, t0, t1
    
    addi a7, zero, 1
    ecall

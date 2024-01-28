#
# x > y ? 0 : 1
#

    .text
main:
    addi a7, zero, 5
    ecall
    add t0, zero, a0
    
    addi a7, zero, 5
    ecall
    add t1, zero, a0
    
    ble t0, t1, else
    addi a0, zero, 0
    j end
    
else:
    addi a0, zero, 1
    j end
    
end:
    addi a7, zero, 1
    ecall

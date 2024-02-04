# print "Hello, ACOS"

    .text
    lui x6, 444102
    addi x6, x6, 1352
    lui x7, 266755
    addi x7, x7, -913
    lui x28, 1333
    addi x28, x28, -189
    lui x8, 65552
    
    sw x6, 0(x8)
    sw x7, 4(x8)
    sw x28, 8(x8)
    
    addi x17, x0, 4
    add x10, x0, x8
    ecall
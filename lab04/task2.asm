# this program does multiiplication

    .text
    addi x17, x0, 5
    ecall
    add x6, x0, x10  # store "a"
    srli x5, x10, 31  # store sign of "a"
    ecall
    add x29, x0, a0  # store "b"
    srli x28, x10, 31  # store sign of "b"
    beq x6, x0, res  # a = 0
    beq x29, x0, res  # b = 0
    beq x5, x0, saez  # if "a" < 0 then inverse it
    xori x6, x6, -1
    addi x6, x6, 1

    saez:
    beq x28, x0, sbez  # if "b" < 0 then inverse it
    xori x29, x29, -1
    addi x29, x29, 1

    sbez:
    bge x6, x29, ageb
    xor x29, x29, x6
    xor x6, x29, x6
    xor x29, x29, x6
    
    ageb:
    add x7, x0, x0
    
    zlb:
    add x7, x7, x6
    addi x29, x29, -1
    blt x0, x29, zlb
    xor x31, x5, x28
    beq x31, x0, xez
    xori x7, x7, -1
    addi x7, x7, 1
    
    xez:
    addi x17, x0, 1
    add x10, x0, x7
    ecall
    addi x17, x0, 10
    ecall
    
    res:
    addi x17, x0, 1
    add x10, x0, x0
    ecall
    addi x17, x0, 10
    ecall

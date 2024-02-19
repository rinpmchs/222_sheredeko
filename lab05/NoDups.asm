.data
    arr:
      .word 4

 .text
    main: 
        li a7, 5
        ecall
        mv t0, a0 

        sw sp, arr, t1
        lw t2, arr
        li t3, 0  # unique elements counter
        li t4, 1

    input_array:
        li a7, 5
        ecall

        lw s0, arr
        li t6, 0

    start:
        lw s1, 0(s0)
        mv a1, s0
        mv a2, s1
        mv a3, t3
        jal check
        beqz a3, save_element
        j next
    check:
        beqz a3, yes_check
        addi a3, a3, -1
        lw a4, 0(a1)
        addi a1, a1, 4
        beq a0, a4, exit_check
        j check
    yes_check:
        li a3, 0
        jr ra
    exit_check:
        li a3, 1
        jr ra
        
    save_element:
        sw a0, 0(t2)
        addi t2, t2, 4
        addi t3, t3, 1

    next:
        addi t4, t4, 1
        ble t4, t0, input_array

        lw t2, arr
        li t4, 0
    
    output_element:
        lw t1, 0(t2)
        li a7, 1
        mv a0, t1
        ecall
        
        addi t4, t4, 1
        addi t2, t2, 4
        j output_line

    output_line:
        li a0, '\n'
        li a7, 11
        ecall
        blt t4, t3, output_element
	.text
   
  main:
    li a7, 5
    ecall
    mv t0, a0  # n
    
    li t1, 4
    mul a0, t0, t1  # size = n * 4 bytes
    li a7, 9  # allocate {size} bytes
    ecall
    mv t2, a0  # allocatoed heap memory address
    
    mv t1, t0  # n
    
    while:
      beqz t0, check  # while (n > 0) read a number and save it, else go to check
      addi t0, t0, -1  # n--
      
      li a7, 5
      ecall  # read number 
      sw a0, 0(t2)  # put it in memory
      addi t2, t2, 4  # address += 4
      j while
      
    check:
      beqz, t1, end  # while (n > 0) 
      addi t1, t1, -1  # n--
      
      lw t3, -4(t2)  # load last number
      addi t2, t2, -4 # address -= 4
      
      li t4, 2
      rem t5, t3, t4
      
      beqz t5, print  # if even (number % 2 == 0), print
      j check
      
    print:
      mv a0, t3
      li a7, 1
      ecall  
      
      li a0, '\n'
      li a7, 11
      ecall
      j check
       
    end:
      li a0, '\n'
      li a7, 11
      ecall
      
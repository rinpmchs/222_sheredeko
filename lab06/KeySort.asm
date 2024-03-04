.macro read_int(%x)
  li a7, 5
  ecall
  mv %x, a0
  .end_macro

.macro print_int(%x)
  li a7, 1
  mv a0, %x
  ecall
  .end_macro

.macro allocate_memory(%x)  # allocate heap memory
  li a7, 9
  mv a0, %x
  ecall
  .end_macro

.text
j main

input_array:
  addi sp, sp, -12
  sw t0, 8(sp)
  sw t1, 4(sp)
  sw t2, 0(sp)
  li t0, 0  # counter
  mv t1, a1  # n
  mv t2, a2  # arr
input_loop:
  bge t0, t1, input_end
  li a7, 5
  ecall
  sw a0, (t2)
  addi t2, t2, 4  # move to next element
  addi t0, t0, 1  # counter++
  j input_loop
input_end:
  lw t2, 0(sp)
  lw t1, 4(sp)
  lw t0, 8(sp)
  addi sp, sp, 12
  jalr zero, 0(ra)

main:
  read_int(a1)  # n
  slli t0, a0, 2
  allocate_memory(t0)
  mv a2, a0  # arr address

  jal input_array
  li a3, 0  # 0 - comp1, 1 - comp2
  jal function # a1 = n, a2 = arr, a3 - comparator
  jal output_array
  li a3, 1
  jal function
  jal output_array
  j end
  
function:
  addi sp, sp, -24
  sw ra, 20(sp)
  sw t0, 16(sp)
  sw t1, 12(sp)
  sw t2, 8(sp)
  sw t4, 4(sp)
  sw t5, 0(sp)
  mv t1, a1  # n
  mv t2, a2  # arr begin
  li t4, 4
  mul t4, t4, t1
  add t4, t2, t4  # arr end
  
  #bgt t0, t1, func_end
  li s3, 0  # tmp
  addi t4, t4, -4
  loop1:
    mv t5, zero  # sorted flag
    mv t2, a2
    loop2:
      beq t2, t4, end_loop2
      lw s1, 0(t2)  # current element
      lw s2, 4(t2)  # next element
      beqz a3, clt
      jal ra, comparator_ld_greater_than
    continue:
      mv t3, a0
      bnez t3, no_swap  # here i will use comparator
      mv s3, s1
      sw s2, 0(t2)
      sw s3, 4(t2)
      li t5, 1  # sorted = true
      no_swap:
        addi t2, t2, 4
        j loop2

  end_loop2:
    bnez t5, loop1 
    j func_end
  
  clt:
     jal ra, comparator_less_than
     j continue
  
func_end:
  lw t0, 0(sp)
  lw t1, 4(sp)
  lw t2, 8(sp)
  lw t4, 12(sp)
  lw t5, 16(sp)
  lw ra, 20(sp)
  addi sp, sp, 24
  jr ra
  
comparator_less_than:
  addi sp, sp, -4
  sw s0, 0(sp)
  blt s1, s2, less
more:
  li s0, 0  # false
  mv a0, s0
  lw s0, 0(sp)
  addi sp, sp, 4
  jalr zero, 0(ra)
less:
  li s0, 1  # true
  mv a0, s0
  lw s0, 0(sp)
  addi sp, sp, 4
  ret

comparator_ld_greater_than:
  addi sp, sp, -12
  sw t2, 8(sp)
  sw t1, 4(sp)
  sw s0, 0(sp)
  li t2, 10
  rem t1, s1, t2
  rem t2, s2, t2
  blt t2, t1, less_ld
more_ld:
  li s0, 0  # false
  mv a0, s0
  j end_comparator_ld
less_ld:
  li s0, 1  # true
  mv a0, s0
end_comparator_ld:
  lw s0, 0(sp)
  lw t1, 4(sp)
  lw t2, 8(sp)
  addi sp, sp, 12
  ret

output_array:
  li t0, 0
output_loop:
  bge t0, a1, output_end
  lw a0, (a2)
  print_int(a0)
  li a0, ' '
  li a7, 11
  ecall
  addi a2, a2, 4
  addi t0, t0, 1
  j output_loop
output_end:
  li a0, '\n'
  li a7, 11
  ecall
  ret
  
end:

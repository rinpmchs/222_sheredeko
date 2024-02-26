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

.macro allocate_memory(%x)  # Allocate heap memory
  li a7, 9
  mv a0, %x
  ecall
  .end_macro

.text
j main

input_array:
  li t2, 0  # counter
input_loop:
  bge t2, a2, input_end
  li a7, 5
  ecall
  sw a0, (a1)
  addi a1, a1, 4  # move to next element
  addi t2, t2, 1  # counter++
  j input_loop
input_end:
  jr ra

sort:
  beq s3, a1, end_sort
  mv t3, s3
  outer_loop:
    beq t3, a1, end_sort
    mv t5, t3
    lw s1, (t3)
    addi t3, t3, 4
    inner_loop:
      beq t3, a1, outer_loop
      lw s0, (t3)
      bgt s1, s0, swap
      mv t5, t3
      addi t3, t3, 4
      j inner_loop
  swap:
    lw t6, 0(t5)
    lw s5, 0(t3)
    sw s5, 0(t5)
    sw t6, 0(t3)
    j outer_loop
  end_sort:
    jr ra

main:
  read_int(t0)
  slli t1, t0, 2
  allocate_memory(t1)
  mv s3, a0

  mv a1, s3
  mv a2, t0
  jal input_array
  jal sort
  jal output_array

output_array:
  li t0, 0
output_loop:
  bge t0, a2, output_end
  lw a0, (s3)
  print_int(a0)
  li a0, ' '
  li a7, 11
  ecall
  addi s3, s3, 4
  addi t0, t0, 1
  j output_loop
output_end:
  li a0, '\n'
  li a7, 11
  ecall

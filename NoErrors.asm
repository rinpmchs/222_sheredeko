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

handler:
csrrw  s0, uepc, zero
addi   s0, s0, 16
csrrw  zero, uepc, s0
uret

main:
  li t0, 40
  allocate_memory(t0)
  li a1, 10  # n = 10
  mv a2, a0  # arr address
  
  la s0, handler
  csrrw zero, utvec, s0
  csrrsi zero, ustatus, 1
  
  jal input_array
  j output_array

output_array:
  li t0, 0
output_loop:
  bge t0, a1, output_end
  lw a0, (a2)
  print_int(a0)
  li a0, '\n'
  li a7, 11
  ecall
  addi a2, a2, 4
  addi t0, t0, 1
  j output_loop
output_end:
  li a0, '\n'
  li a7, 11
  ecall
  
end:
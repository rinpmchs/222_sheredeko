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

main:
  read_int(t0)
  slli t1, t0, 2
  allocate_memory(t1)
  mv s3, a0

  mv a1, s3
  mv a2, t0
  jal input_array
  jal bubble_sort # Вызов функции bubble_sort
  jal output_array
  
  
bubble_sort:
  li s5, 0              # переменная для хранения временного значения
  li s6, 4
  mul s6, t0, s6
  add t4, s3, s6 # вычисление верхней границы
  addi t4, t4, -4
  loop1:
    mv t5, zero         # сброс флага отсортированности
    mv t1, s3         # начало массива
    loop2:
      beq t1, t4, end_loop2 # если дошли до конца массива, заканчиваем
      lw t2, 0(t1)      # текущий элемент массива
      lw t3, 4(t1)      # следующий элемент массива
      ble t2, t3, no_swap # если текущий элемент не больше следующего, не меняем местами
      # иначе меняем местами
      mv s5, t2
      sw t3, 0(t1)
      sw s5, 4(t1)
      li t5, 1          # устанавливаем флаг отсортированности в 1
      no_swap:
        addi t1, t1, 4
        j loop2

  end_loop2:
    bnez t5, loop1 
    jr ra

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

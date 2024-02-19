.macro read_int(%x)
   li a7, 5
   ecall
   mv %x, a0
   .end_macro
   
.macro print_char(%x)
   li a7, 11
   li a0, %x
   ecall
   .end_macro

.macro newline
   print_char('\n')
   .end_macro
   
.macro printline(%x, %y, %z)   
   .text
 add t0, zero, %x
 #li t0, %x
 while:
   beqz t0, end
   addi t0, t0, -1
   print_char(%y)
   print_char(%z)
   j while
 end:
   print_char(%y)
   .end_macro

	.text
  main:
    read_int(t1)
    read_int(t2)
    
  while_cols:
    printline(t1, '+', '-')
    newline
    printline(t1, '|', ' ')
    newline
    addi t2, t2, -1
    beqz t2, output_end
    j while_cols

  output_end:
    printline(t1, '+', '-')
    newline
    newline
    

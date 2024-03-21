#
# Example that demonstrates MMIO in Digital Lab Sim.
#
# It works with hexadecimal keyword.
#
# See Help on Digital Lab Sim for details.
#

.eqv nothing, 0x00
.eqv D0, 0x3f
.eqv D1, 0x06
.eqv D2, 0x5b
.eqv D3, 0x4f 
.eqv D4, 0x66
.eqv D5, 0x6d
.eqv D6, 0x7d
.eqv D7, 0x07
.eqv D8, 0x7f
.eqv D9, 0x6f

.macro exit
    li      a7, 10          # System call for exit
    ecall
.end_macro

.macro print_digit(%x, %y)
    li t1, %x
    sb t1, 0x11(t3)
    li t1, %y
    sb t1, 0x10(t3)
.end_macro

.macro newline
    li      a0, '\n'         # ASCII code for newline
    li      a7, 11           # System call for print character
    ecall
.end_macro

    .text
main:
    lui     s0, 0xffff0     # MMIO base
    mv      s1, zero        # counter
    li      s3, 20          # counter limit
loop:
    li      t0, 1         # check first row
    sb      t0, 0x12(s0)  # scan
    lb      t1, 0x14(s0)  # get result
    bnez    t1, pressed   # process key pressed

    li      t0, 2         # check second row
    sb      t0, 0x12(s0)
    lb      t1, 0x14(s0)
    bnez    t1, pressed

    li      t0, 4         # check third row
    sb      t0, 0x12(s0)
    lb      t1, 0x14(s0)
    bnez    t1, pressed

    li      t0, 8         # check fourth row
    sb      t0, 0x12(s0)
    lb      t1, 0x14(s0)
    bnez    t1, pressed
   
    mv      s2, zero  # reset previous value
    j       loop  # nothing is pressed (t1 == 0) - repeat
pressed:
    beq     t1, s2, loop # repeat if the same key value
    mv      s2, t1 # save current value
    
    # Convert hexadecimal key to decimal
  #  li      t2, 10          # divisor for decimal conversion
  #  mv      t3, zero        # remainder
  #  mv      t4, t1          # store hexadecimal value
  #  mv      a0, zero        # clear a0 to store decimal result

  #  divu    a0, t3, t4      # divide by 10
  #  mv      a0, t3          # quotient (decimal value)
  #  remu    a1, a0, t2      # remainder

    # Print the decimal value
  #  print_digit(a1, a0)
  #  newline
    
  #  print_hex(t1)
  #  newline

    	lui t3, 0xffff0   # MMIO base

    	li t6, 0x00000011  # 0
    	bne t1, t6, n0
    	print_digit(nothing, D0)
    	
    n0:

    	li t6, 0x00000021  # 1
    	bne t1, t6, n1
    	print_digit(nothing, D1)
    
    n1:
    	
    	li t6, 0x00000041  # 2
    	bne t1, t6, n2
    	print_digit(nothing, D2)
    
    n2:
    	
    	li t6, 0xffffff81  # 3
    	bne t1, t6, n3
    	print_digit(nothing, D3)
    
    n3:
    	
    	li t6, 0x00000012  # 4
    	bne t1, t6, n4
    	print_digit(nothing, D4)
    
    n4:
    	
    	li t6, 0x00000022  # 5
    	bne t1, t6, n5
    	print_digit(nothing, D5)
    
    n5:
    	
    	li t6, 0x00000042  # 6
    	bne t1, t6, n6
    	print_digit(nothing, D6)
    	
    n6:
    	
    	li t6, 0xffffff82  # 7
    	bne t1, t6, n7
    	print_digit(nothing, D7)
    	
    n7:
    
    	li t6, 0x00000014  # 8
    	bne t1, t6, n8
    	print_digit(nothing, D8)
    
    n8:
    	
    	li t6, 0x00000024  # 9
    	bne t1, t6, n9
    	print_digit(nothing, D9)
    	
    n9:
    	
    	li t6, 0x00000044  # a
    	bne t1, t6, n10
    	print_digit(D1, D0)
    
    n10:
    	
    	li t6, 0xffffff84  # b
    	bne t1, t6, n11
    	print_digit(D1, D1)
    
    n11:
    	
    	li t6, 0x00000018  # c
    	bne t1, t6, n12
    	print_digit(D1, D2)
    	
    n12:
    	
    	li t6, 0x00000028  # d
    	bne t1, t6, n13
    	print_digit(D1, D3)
    
    n13:
    	
    	li t6, 0x00000048  # e
    	bne t1, t6, n14
    	print_digit(D1, D4)
    
    n14:
    	
    	li t6, 0xffffff88  # f
    	bne t1, t6, n15
    	print_digit(D1, D5)
    	
    n15:
    	
    	addi    s1, s1, 1    # counter increment
    	ble     s1, s3, loop # repeat if s1 <= s3
    	
end:
	exit

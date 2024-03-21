	.data
table: 
	.space 128  # адрес начала таблицы "виртуальной памяти"

size: 
	.word 128  # размер таблицы в байтах

	.text
handler:
	csrrw  s2, uepc, zero 
	addi   s2, s2, 4      
	csrrw  zero, uepc, s2  # ready to go to the next instruction
	addi sp, sp, -24
	
	sw t1, 20(sp)
	sw t2, 16(sp)
	sw t3, 12(sp)
	sw t4, 8(sp)
	sw t5, 4(sp)
	sw t6, 0(sp)
 
	la t0, table  # адрес начала таблицы
 
	csrr t1, utval  # адрес исключения
 
	csrr t2, ucause  # тип исключения
	li t3, 5  # LOAD_ACCESS_FAULT
	beq t2, t3, reading
	li t3, 7  # STORE_ACCESS_FAULT
	beq t2, t3, writing
	j end_handler
 
 
reading:
	la t2, size  # размер
	la t0, table 
    
check_presence_r:
	lw t4, 0(t0)  # address
	beqz t4, not_found_r
	beq t4, a0, found_r
	addi t0, t0, 8
	bgt t2, t0, check_presence_r
	j not_found_r

found_r:
	lw t0, 4(t0)  # load value from VM
	j end_handler
 
not_found_r:
	li t0, 0
	j end_handler
 

writing:
	la t0, table  # адрес таблицы
	la t2, size  # размер
 
    
check_presence_w:
	lw t4, 0(t0)  # address
	lw t6, 20(sp)
	beqz t4, not_found_w
	beq t4, t6, found_w
	addi t0, t0, 8
	bgt t2, t0, check_presence_w
	j not_found_w

found_w:
	sw a0, 4(t0)  # load value from VM
	j end_handler
 
not_found_w:
	sw t6, (t0)
	addi t0, t0, 4
	sw a0, (t0)
	j end_handler

end_handler:
	lw t6, 0(sp)
	lw t5, 4(sp)
	lw t4, 8(sp)
	lw t3, 12(sp)
	lw t2, 16(sp)
	lw t1, 20(sp)
	addi sp, sp, 24
	uret

    
.globl	main
.text
main:	la	t1 handler
	csrw	t1 utvec
	csrsi	ustatus 1
	
loop:	li	a7 5		# Ввод адреса
	ecall
	beqz	a0 done		# Если 0, конец
	andi	t0 a0 3		# Кратен ли 4
	beqz	t0 read		# Если да — чтение

write:	andi	a0 a0 -4	# Запись, затираем 2 бита
	mv	t1 a0		# Это «виртуальный» адрес
	li	a7 5		# Вводим значение
	ecall
	mv	t0 a0		# Готовим t0
	sw	t0 (t1)		# Сохраняем знеачение в «виртуальной памяти»
	b 	loop

read:	lw	t0 (a0)		# Читаем значение из «виртуальной памяти»
	mv	a0 t0
	li	a7 1		# Выводим значение
	ecall
	li	a0 '\n'		# И перевод строки
	li	a7 11
	ecall
	b 	loop

done:	li	a7 10
	ecall
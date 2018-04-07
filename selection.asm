.data
v: .word

.text
li $t0, 5 		# n = 5
li $t1, 0		# i = 0
li $t2, 0		# j
li $t3, 0		# menor
li $t4, 0		# aux
li $s0, 0		# bool
li $s1, 0		# endereço j
li $s2, 0		# endereço menor
li $s3, 0		# menor*4
li $s4, 0		# j*4
li $s5, 0		# v[j]
li $s7, 0		# i*4
li $s6, 0		# v[menor]
la $t5, v		# t5 = v[0]
li $t6, 0		# endereço i*4

loop:
	addi $t3, $t1, 0 	# menor = i
	mul $s3, $t3, 4		# menor*4
	add $s2, $t5, $s3	# endereço menor*4
	lw $s6, 0($s2)		# v[menor]
	
	addi $t2, $t1, 1	# j = i + 1
	
	beq $t0, $t2, fim2
loop2:
	mul $s4, $t2, 4		# j*4
	
	add $s1, $t5, $s4	# endereço j*4
	add $s2, $t5, $s3	# endereço menor*4
	
	lw $s5, 0($s1)		# v[j]
	lw $s6, 0($s2)		# v[menor]
	
	slt $s0, $s5, $s6	# if(v[j] < v[menor])
	beqz $s0, else
	
	addi $t3, $t2, 0	# menor = j
	mul $s3, $t3, 4		# menor*4
	add $s2, $t5, $s3	# endereço menor*4
	lw $s6, 0($s2)		# v[menor]
else:
	addi $t2, $t2, 1	# j++
	beq $t0, $t2, fim2
	
	j loop2
	
fim2:
	mul $s7, $t1, 4		# i*4
	add $t6, $t5, $s7	# endereço i*4
	lw $t4, 0($t6)		# aux = v[i]
	sw $s6, 0($t6)		# v[i] = v[menor]
	sw $t4, 0($s2)		# v[menor] = aux
	addi $t1, $t1, 1	# i++
	
	beq $t1, $t0, fim
	j loop
	
fim:
	syscall
	
	

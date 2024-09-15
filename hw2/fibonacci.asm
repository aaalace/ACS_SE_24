main:
	mv	t0,	zero		# Псевдокоманда
	li 	t1,	1			# Псевдокоманда
	
	li	a7,	5			# Псевдокоманда
	ecall				
	mv	t3,	a0			# Псевдокоманда
fib:
	beqz t3, finish		# Псевдокоманда
	add  t2, t1, t0		# R: | opcode | rd | funct3 | rs1 | rs2 | funct7 |
	mv	 t0, t1			# Псевдокоманда
	mv	 t1, t2			# Псевдокоманда
	addi t3, t3, -1		# I: | opcode | rd | funct3 | rs1 | imm[11:0] |
	j	 fib			# Псевдокоманда
finish:
	li	a7,	1			# Псевдокоманда
	mv	a0,	t0			# Псевдокоманда
	ecall				

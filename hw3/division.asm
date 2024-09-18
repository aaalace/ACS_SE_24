.data
	number_announce: .asciz "Введите делимое:\n"
	divider_announce: .asciz "Введите делитель:\n"
	err_divizion_by_zero: .asciz "Ошибка: деление на 0"
	q_result: .asciz "Целая часть: "
	r_result: .asciz "\nОстаток: "

.text
main:
	la a0 number_announce
	li a7 4
	ecall
	li a7 5 # input number
	ecall
	mv t0 a0 # number в  t0
	
	la a0 divider_announce
	li a7 4
	ecall
	li a7 5  # input divider
	ecall
	mv t1 a0 # divider в  t1
	
	j if_div_0
	
if_div_0: # check if divider is not 0
	bnez t1 set_num_is_neg
	la a0 err_divizion_by_zero
	li a7 4
	ecall
	j exit
	
set_num_is_neg:
	bgez t0 set_num_is_pos
	li a1 -1 # a1 = -1 => num < 0
	sub t2, t2, t0 # в t2 abs(num)
	j set_div_is_neg
	
set_num_is_pos:
	li a1 1  # a1 = 1 => num >= 0
	mv t2, t0 # в t2 abs(num)
	j set_div_is_neg

set_div_is_neg:
	bgez t1 set_div_is_pos
	li a2 -1 # a2 = -1 => div < 0
	sub t3 t3 t1 # в t3 abs(div)
	j while_num_not_less_div
	
set_div_is_pos:
	li a2 1 # a2 = 1 => div >= 0
	mv t3, t1 # в t3 abs(div)
	j while_num_not_less_div
	
while_num_not_less_div: # t4 - целая часть, t2 - остаток (num=t2 -= div => t2=r)
	sub t5 t2 t3 # t5 = num - div
	bltz t5 leave_loop # if t5 < 0 => leave loop
	sub t2 t2 t3
	addi  t4 t4 1
	j while_num_not_less_div
	
leave_loop:
	add a3 a1 a2
	beqz a3 state_is_neg # n < 0 XOR d < 0
	j check_div_is_neg
	
state_is_neg:
	sub t2 zero t2
	sub t4 zero t4
	j check_div_is_neg

check_div_is_neg:
	bgez a2 end
	sub t2 zero t2
	j end

end:
	la a0 q_result
	li a7 4
	ecall
	mv a0 t4
	li a7 1
	ecall
	
	la a0 r_result
	li a7 4
	ecall
	mv a0 t2
	li a7 1
	ecall
	
	j exit

exit:
	li a7, 10
	ecall
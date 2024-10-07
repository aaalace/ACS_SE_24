.data
array:      .word 0:10		# Массив из 10 элементов
sum:        .word 0			# Переменная для хранения суммы
count:      .word 0          	# Переменная для хранения количества элементов
even_count: .word 0         	# Переменная для хранения количества четных элементов
odd_count:  .word 0          	# Переменная для хранения количества нечетных элементов

input_msg:  .asciz 		"Введите элемент массива (0 для завершения):\n "
sum_msg:    .asciz 		"Сумма элементов - "
even_msg:   .asciz 		"Количество четных элементов - "
odd_msg:    .asciz 		"Количество нечетных элементов - "
error_msg:  .asciz 		"Ошибка - превышено максимальное количество элементов (10)\n"
overflow_msg:    .asciz		"Ошибка - переполнение\n"
newline:    .asciz 			"\n"

.text
main:
    # Макс кол-во - константа
    li t6, 10

    # Инициализация указателя на массив
    la s1, array

    # Инициализация счетчика элементов
    li s0, 0

input_loop:
    # Вывод приглашения для ввода элемента
    la a0, input_msg
    li a7, 4
    ecall

    # Ввод элемента массива
    li a7, 5
    ecall
    mv t1, a0
    
    # Проверка на завершение ввода (введен 0)
    beqz t1, input_end
    
    # Проверка на макс кол-во элементов
    beq t6, s0, error_exit

    # Сохранение элемента в массив
    sw t1, 0(s1)

    # Переход к следующему элементу
    addi s1, s1, 4
    addi s0, s0, 1
    j input_loop
    
error_exit:
    # Вывод сообщения об ошибке кол-ва элементов
    la a0, error_msg
    li a7, 4
    ecall
    
    # Завершение программы
    li a7, 10
    ecall

input_end:
    # Указатель на элемент
    la s1, array

    # Сумма
    li s2, 0

    # Индекс текущего
    li t0, 0
    
sum_loop:
    # Если индекс == количество элементов
    beq t0, s0, sum_end

    # Загрузка элемента массива
    lw t1, 0(s1)

    # Сложение
    add t2, s2, t1
    
    slt s9, t2, s2
    beq s9, zero, no_overflow
    
    la a0, overflow_msg
    li a7, 4
    ecall
    j sum_end
    
no_overflow:
    # Обновление суммы
    mv s2, t2

    # Переход к следующему элементу
    addi s1, s1, 4
    addi t0, t0, 1
    j sum_loop

sum_end:
    # Вывод сообщения суммы элементов
    la a0, sum_msg
    li a7, 4
    ecall
    
    # Вывод суммы элементов
    mv a0, s2
    li a7, 1
    ecall
    
    la a0, newline
    li a7, 4
    ecall

    # Инициализация указателя на массив
    la s1, array

    # Инициализация счетчиков четных и нечетных элементов - s4 s5 соотв.
    li s4, 0
    li s5, 0

    # Индекс текущего
    li t0, 0
    
count_loop:
     # Если индекс == количество элементов
    beq t0, s0, ok_exit

    # Загрузка элемента массива
    lw t1, 0(s1)

    # Проверка на четность
    andi t2, t1, 1
    beqz t2, even

    # Элемент нечетный
    addi s5, s5, 1
    j count_next

even:
    # Элемент четный
    addi s4, s4, 1

count_next:
    # Переход к следующему элементу
    addi s1, s1, 4
    addi t0, t0, 1
    j count_loop

ok_exit:
    # Вывод количества четных элементов
    la a0, even_msg
    li a7, 4
    ecall
    mv a0, s4
    li a7, 1
    ecall
    
    la a0, newline
    li a7, 4
    ecall

    # Вывод количества нечетных элементов
    la a0, odd_msg
    li a7, 4
    ecall
    mv a0, s5
    li a7, 1
    ecall
    
    la a0, newline
    li a7, 4
    ecall

    # Завершение программы
    li a7, 10
    ecall
   
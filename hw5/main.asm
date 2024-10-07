.data
output_result: .asciz "Аргумент:  "

.text
main:	
    li s1, 2147483647
    li t2, 1
    li t3, 0
    li a1, 1

loop:
    mul t2, t2, a1
    divu t3, s1, t2
    addi a1, a1, 1
    bleu a1, t3, continue
    overflow:
        addi a1, a1, -1
        j finish
    continue:
        j loop

finish:
    mv a2, a1
    la a0, output_result
    li a7, 4
    ecall
    mv a0, a2
    li a7, 1
    ecall

exit:
    li a7, 10
    ecall
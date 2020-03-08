.import ../write_matrix.s
.import ../utils.s

.data
m0: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 # MAKE CHANGES HERE
file_path: .asciiz "test_output.bin"

.text
main:
    # Write the matrix to a file
    la a0 file_path
    la a1 m0
    li a2 2
    li a3 5
    jal write_matrix

    # Exit the program
    addi a0 x0 10
    ecall
.import ../read_matrix.s
.import ../utils.s

.data
file_path: .asciiz "./test_files/test_input.bin"

.text
main:
    # Read matrix into memory
    la a0 file_path
    addi sp sp -4
    mv s1 sp
    mv a1 s1
    addi sp sp -4
    mv s2 sp
    mv a2 s2

    jal read_matrix

    # Print out elements of matrix
    lw a1 0(s1)
    lw a2 0(s2)
    jal print_int_array

    # Terminate the program
    addi a0, x0, 10
    ecall
.import ../matmul.s
.import ../utils.s
.import ../dot.s

# static values for testing
.data
m0: .word 3 -4 4 1 -3 -1 -2 6 5 7 0 2
m1: .word 3 8 9 -4 4 1 -1 10 -3 6 5 11
d: .word 0 0 0 0 0 0 0 0 0 0 0 0 # allocate static space for output

.text
main:
    # Load addresses of input matrices (which are in static memory), and set their dimensions
    la s0 m0
    la s1 m1
    la s2 d

    # Call matrix multiply, m0 * m1
    mv a0 s0
    li a1 4
    li a2 3
    mv a3 s1
    li a4 3
    li a5 4
    mv a6 s2
    jal matmul

    # Print the output (use print_int_array in utils.s)
    la a0 d
    li a1 4
    li a2 4
    jal print_int_array

    # Exit the program
    jal exit
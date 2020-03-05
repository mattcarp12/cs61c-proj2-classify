.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:
# 	a0 is the pointer to the start of m0
#	a1 is the # of rows (height) of m0
#	a2 is the # of columns (width) of m0
#	a3 is the pointer to the start of m1
# 	a4 is the # of rows (height) of m1
#	a5 is the # of columns (width) of m1
#	a6 is the pointer to the the start of d
# Returns:
#	None, sets d = matmul(m0, m1)
# =======================================================
matmul:

    # Error if mismatched dimensions
    bne a2, a4, mismatched_dimensions

    # Prologue
    addi sp, sp, -48
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)
    sw s7, 32(sp)
    sw s8, 36(sp)
    sw s9, 40(sp)
    sw s10, 44(sp)

    mv s0, a0       # Pointer to m0
    mv s1, a1       # Num rows of m0
    mv s2, a2       # Num cols of m0
    mv s3, a3       # Pointer to m1
    mv s4, a4       # Num rows of m1
    mv s5, a5       # Num cols of m1
    mv s6, a6       # Pointer to d

    li s7, 0 # outer loop counter. program stops when s7 == s1
    li s8, 0 # inner loop counter. reset when s8 == s5
    li s9, 0 # offset for m0
    li s10, 0 # offset for m1

outer_loop_start:
    beq s7, s1, outer_loop_end
    
inner_loop_start:
    
    # check if inner loop is finished
    beq s8, s5, inner_loop_end

    # setup call to dot
    add a0, s0, s9          # set a0 to start of m0 row
    add a1, s3, s10         # set a1 to start of m1 column
    add a2, a2, x0          # set length of vectors to num cols of m0 (=num rows of m1)
    li a3, 1                # stride of v0, always one since row major format
    mv a4, a5               # stride of v1, always num cols of m1

    # call dot on arguments
    jal dot

    # put return value into d vector
    sw a0, 0(s6)

    # increment d vector 
    addi s6, s6, 4          # always step 1 integer since sequentially putting values into rows

    # increment m1 col to be used in next loop
    # add 4 bytes to offset since next row element
    # is start of next column
    addi s10, s10, 4

    # iterate inner loop
    addi s8, s8, 1
    j inner_loop_start

inner_loop_end:

    # increment m0 row to be used in next loop
    # add (num cols of m0)*4 to offset for m0
    # to set pointer to next row
    li t0, 4
    mul t1, s2, t0
    add s9, s9, t1

    # reset inner loop counter and offset
    li s8, 0
    li s10, 0

    # iterate outer loop
    addi s7, s7, 1
    j outer_loop_start

outer_loop_end:

    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    lw s9, 40(sp)
    lw s10, 44(sp)
    addi sp, sp, 48
        
    ret


mismatched_dimensions:
    li a1 2
    jal exit2

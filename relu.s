.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 is the pointer to the array
#	a1 is the # of elements in the array
# Returns:
#	None
# ==============================================================================
relu:
    add t0, a0, x0 # pointer to array
    add t1, x0, x0 # counter

loop_start:
    lw t2, 0(t0) # get integer from array
    blt t2, x0, zero_out
    j loop_continue

zero_out:
    add t2, x0, x0

loop_continue:
    sw t2, 0(t0) # store integer back in array
    addi t1, t1, 1 # increment counter
    beq t1, a1, loop_end
    addi t0, t0, 4
    j loop_start


loop_end:
	ret

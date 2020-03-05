.import ../utils.s

.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 is the pointer to the start of the vector
#	a1 is the # of elements in the vector
# Returns:
#	a0 is the first index of the largest element
# =================================================================
argmax:
    add t0, a0, x0 # pointer to array
    add t1, x0, x0 # counter
    add t2, x0, x0 # max value
    add t3, x0, x0 # index of max value
loop_start:
    lw t4, 0(t0) # get integer from array
    bge t4, t2, update
    j loop_continue

update:
    add t2, t4, x0 # update max value to current integer 
    add t3, t1, x0 # update index to current counter


loop_continue:
    sw t4, 0(t0) # store integer back in array
    addi t1, t1, 1 # increment counter
    beq t1, a1, loop_end
    addi t0, t0, 4
    j loop_start


loop_end:
    add a0, t3, x0
    ret

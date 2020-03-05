.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
dot:
    add t0, a0, x0 # pointer to v1
    add t1, a1, x0 # pointer to v2
    add t2, x0, x0 # counter
    add t3, x0, x0 # sum
    addi t6, x0, 4 # temp store size of int
    mul a3, a3, t6 # set stride to distance in memory
    mul a4, a4, t6

loop_start:
    lw t4, 0(t0) # get int from v1
    lw t5, 0(t1) # get int from v2
    mul t6, t4, t5
    add t3, t3, t6 # update sum
    addi t2, t2, 1 # update counter
    beq t2, a2, loop_end # check end of loop
    add t0, t0, a3 # update v1 pointer
    add t1, t1, a4 # update v2 pointer
    j loop_start

loop_end:
    add a0, t3, x0    
    ret

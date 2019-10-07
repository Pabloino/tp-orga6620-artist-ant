#include <regdef.h>

#define NORTH 0
#define SOUTH 1
#define EAST 2
#define WEST 3

.data
rotation_rules:
    north: .word WEST, EAST
    south: .word EAST, WEST
    east: .word NORTH, SOUTH
    west: .word SOUTH, NORTH
relevant_bounds: .space 16
allowed_forward: .word step_north, step_south, step_east, step_west

.text
.align 2
.globl new_orientation
.ent new_orientation
new_orientation:
    subu sp, sp, 8              # Building stack
    sw fp, 4(sp)
    .cprestore 0                # sw gp, 0(sp)
    mul a0, a0, 8               # Getting the offset
    mul a1, a1, 4
    addu a0, a0, a1             # Storing the offset in $a0
    la a1, rotation_rules       # Storing rotation_rules address in $a1
    addu a0, a1, a0             # $a0 = address + offset
    lw v0, (a0)
    lw gp, 0(sp)                # Disarming stack
    lw fp, 4(sp)
    addu sp, sp, 8
    jr ra
.end new_orientation

.text
.align 2
.globl move_forward
.ent move_forward
move_forward:
    .frame sp, 32, ra
    .set noreorder
    .cpload	t9
    .set reorder
    subu sp, sp, 32             # Building stack
    sw ra, 24(sp)
    sw fp, 20(sp)
    .cprestore 16               # sw gp, 16(sp)
    move fp, sp
    sw a2, 8(fp)
    sw a1, 4(fp)
    sw a0, 0(fp)
    sw a2, relevant_bounds        # height      # Function body
    sw a2, relevant_bounds+4      # height
    sw a1, relevant_bounds+8      # width
    sw a1, relevant_bounds+12     # width
    lw t0, 8(a0)                  # ant->o
    mul t0, t0, 4
    la t1, relevant_bounds        # Storing relevant_bounds address in $t1
    addu t1, t1, t0               # $t1 = address(relevant_bounds) + ant->o
    lw a1, (t1)                   # bound
    la t1, allowed_forward        # Storing allowed_forward address in $t1
    addu t1, t1, t0               # $t1 = address(allowed_forward) + ant->o
    lw t1, (t1)
    jal t1
    lw ra, 24(sp)       # Disarming stack
    lw fp, 20(sp)
    lw gp, 16(sp)
    lw a2, 8(sp)
    lw a1, 4(sp)
    lw a0, 0(sp)
    addu sp, sp, 32
    move v0, a0
    jr ra
.end move_forward

.text
.align 2
.globl step_north
.ent step_north
step_north:
    subu sp, sp, 8          # Building stack
    sw fp, 4(sp)
    .cprestore 0            # sw gp, 0(sp)
    lw t0, 4(a0)            # ant->y
    subu t0, t0, 1          # ant->y-1
    addu t1, a0, 4          # &ant->y
    blt t0, 0, step_side_n  # Check if position is out of limit of the grid
    div t0, a1
    mfhi t0
    b exit_adjust_n
step_side_n:
    subu t0, a1, 1          # Step to [size-1] position
exit_adjust_n:
    sw t0, (a0)
    lw gp, 0(sp)            # Disarming stack
    lw fp, 4(sp)
    addu sp, sp, 8
    jr ra
.end step_north

.text
.align 2
.globl step_south
.ent step_south
step_south:	
    subu sp, sp, 8          # Building stack
    sw fp, 4(sp)
    .cprestore 0            # sw gp, 0(sp)
    lw t0, 4(a0)            # ant->y
    addu t0, t0, 1          # ant->y+1
    addu t1, a0, 4          # &ant->y
    blt t0, 0, step_side_s  # Check if position is out of limit of the grid
    div t0, a1
    mfhi t0
    b exit_adjust_s
step_side_s:
    subu t0, a1, 1          # Step to [size-1] position
exit_adjust_s:
    sw t0, (a0)
    lw gp, 0(sp)            # Disarming stack
    lw fp, 4(sp)
    addu sp, sp, 8
    jr ra
.end step_south

.text
.align 2
.globl step_east
.ent step_east
step_east:
    subu sp, sp, 8          # Building stack
    sw fp, 4(sp)
    .cprestore 0            # sw gp, 0(sp)
    lw t0, 0(a0)            # ant->x             
    addu t0, t0, 1          # ant->x+1
    blt t0, 0, step_side_e  # Check if position is out of limit of the grid
    div t0, a1
    mfhi t0
    b exit_adjust_e
step_side_e:
    subu t0, a1, 1          # Step to [size-1] position
exit_adjust_e:
    sw t0, (a0)
    lw gp, 0(sp)            # Disarming stack
    lw fp, 4(sp)
    addu sp, sp, 8
    jr ra
.end step_east

.text
.align 2
.globl step_west
.ent step_west
step_west:	
    subu sp, sp, 8          # Building stack
    sw fp, 4(sp)
    .cprestore 0            # sw gp, 0(sp)
    lw t0, 0(a0)            # ant->x                
    subu t0, t0, 1          # ant->x-1
    blt t0, 0, step_side_w  # Check if position is out of limit of the grid
    div t0, a1
    mfhi t0
    b exit_adjust_w
step_side_w:
    subu t0, a1, 1          # Step to [size-1] position
exit_adjust_w:
    sw t0, (a0)
    lw gp, 0(sp)            # Disarming stack
    lw fp, 4(sp)
    addu sp, sp, 8
    jr ra
.end step_west
#include <regdef.h>

#define NORTH 0
#define SOUTH 1
#define EAST 2
#define WEST 3

.data
default: .asciiz "Unknown orientation"
default_m: .asciiz "Unknown forward"

.text
.align 2
.globl new_orientation
.ent new_orientation

new_orientation:
    .frame sp, 32, ra
    .set noreorder
    .cpload	t9
    .set reorder	
    subu sp, sp, 32                 # Building stack
    sw ra, 24(sp)
    sw fp, 20(sp)
    .cprestore 16   # sw gp, 16(sp)
    move fp, sp
    sw a1, 4(fp)
    sw a0, 0(fp)
    beq a0, NORTH, north            # Function body
    beq a0, SOUTH, south
    beq a0, EAST, east
    beq a0, WEST, west
    la a0, default
    jal doPanic
north:
    move a0, a1
    li a1, WEST
    li a2, EAST
    b call_decide
south:
    move a0, a1
    li a1, EAST
    li a2, WEST
    b call_decide
east:
    move a0, a1
    li a1, NORTH
    li a2, SOUTH
    b call_decide
west:
    move a0, a1
    li a1, SOUTH
    li a2, NORTH
    b call_decide
call_decide:
    jal decide
    lw ra, 24(sp)                   # Disarming stack
    lw fp, 20(sp)
    lw gp, 16(sp)
    lw a1, 4(sp)
    lw a0, 0(sp)
    addu sp, sp, 32
    jr ra
.end new_orientation

.text
.align 2
.globl decide
.ent decide

decide:
    subu sp, sp, 8          # Building stack
    sw fp, 4(sp)
    .cprestore 0   # sw gp, 0(sp)
    beq	a0, 1, go_right     # Function body
go_left:
    move v0, a1
    b exit_decide
go_right:
    move v0, a2
exit_decide:
    lw gp, 0(sp)            # Disarming stack
    lw fp, 4(sp)
    addu sp, sp, 8
    jr ra
.end decide

.text
.align 2
.globl move_forward
.ent move_forward
move_forward:
    .frame sp, 32, ra
    .set noreorder
    .cpload	t9
    .set reorder	
    subu sp, sp, 32                 # Building stack
    sw ra, 24(sp)
    sw fp, 20(sp)
    .cprestore 16   # sw gp, 16(sp)
    move fp, sp
    sw a2, 8(fp)
    sw a1, 4(fp)
    sw a0, 0(fp)
    lw t0, 0(a0)    #ant->x       # Function body
    lw t1, 4(a0)    #ant->y
    lw t2, 8(a0)    #ant->o
    beq t2, NORTH, move_north
    beq t2, SOUTH, move_south
    beq t2, EAST, move_east
    beq t2, WEST, move_west
    la a0, default_m
    jal doPanic
move_north:
    addu a0, a0, 4      #&ant->y
    subu t1, t1, 1
    move a1, t1         #ant->y-1
    b call_adjust
move_south:
    addu a0, a0, 4      #&ant->y
    addu t1, t1, 1
    move a1, t1         #ant->y+1
    b call_adjust
move_east:
    move a2, a1         #width
    addu t0, t0, 1
    move a1, t0         #ant->x+1
    b call_adjust
move_west:
    move a2, a1         #width
    subu t0, t0, 1
    move a1, t0         #ant->x-1
    b call_adjust
call_adjust:
    jal adjust
    lw ra, 24(sp)                   # Disarming stack
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
.globl adjust
.ent adjust
adjust:
    subu sp, sp, 8          # Building stack
    sw fp, 4(sp)
    .cprestore 0   # sw gp, 0(sp)
    div a1, a2     # Function body
    mfhi t0
    sw t0, (a0)
    lw gp, 0(sp)            # Disarming stack
    lw fp, 4(sp)
    addu sp, sp, 8
    jr ra
.end adjust

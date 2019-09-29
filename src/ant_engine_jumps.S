#include <regdef.h>

.data
default: .asciiz "Unknown orientation %d"
ime: .asciiz "Holi"

.text
.align 2
.globl new_orientation
.ent new_orientation

new_orientation:
    la a0, default
    jal doPanic
.end new_orientation

.text
.align 2
.globl move_forward
.ent move_forward
move_forward:
    la a0, ime
    jal doPanic
.end move_forward

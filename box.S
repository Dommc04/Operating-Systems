.global box
.global _box_check_box_
.global _box_draw_corners_
.global _box_draw_top_bottom_
.global _box_draw_right_left_

// Dominic McElroy - PROGRAM 1 - BOX.S
//MAIN FUNCTION 
box:
    // standard entry: save link and stack frame registers
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    // Save the arguments.  Called functions may overwrite x0-x3
    sub     sp, sp, 32
    stp     x0, x1, [x29, -16]
    stp     x2, x3, [x29, -32]

    ldp     x0, x1, [x29, -16]    
    ldp     x2, x3, [x29, -32]    
    bl      _box_check_box_
    cmp     w0, 0
    beq     _box_continue
    b       _box_error_

_box_continue:
    mov     w0, 0

    ldp     x0, x1, [x29, -16]
    ldp     x2, x3, [x29, -32]
    bl      _box_draw_corners_

    ldp     x0, x1, [x29, -16]
    ldp     x2, x3, [x29, -32]
    bl      _box_draw_top_bottom_

    ldp     x0, x1, [x29, -16]
    ldp     x2, x3, [x29, -32]
    bl      _box_draw_right_left_

    mov     w0, 0
    b       _box_exit_

_box_error_:
    mov     w0, 1

_box_exit_:
    add     sp, sp, 32
    ldp     x29, x30, [sp], 16
    ret
// BOX VALIDATION
_box_check_box_:
    cmp     w0, w2
    bge     _check_fail
    cmp     w1, w3
    bge     _check_fail
    mov     w0, 0
    ret
_check_fail:
    mov     w0, 1
    ret
// DRAW CORNERS
_box_draw_corners_:
    stp     x29, x30, [sp, -48]!
    mov     x29, sp

    str     w0, [x29, 16]
    str     w1, [x29, 20]
    str     w2, [x29, 24]
    str     w3, [x29, 28]

    ldr     w0, [x29, 16]
    ldr     w1, [x29, 20]
    mov     w2, '+'
    bl      putc_to

    ldr     w0, [x29, 16]
    ldr     w1, [x29, 28]
    mov     w2, '+'
    bl      putc_to

    ldr     w0, [x29, 24]
    ldr     w1, [x29, 20]
    mov     w2, '+'
    bl      putc_to

    ldr     w0, [x29, 24]
    ldr     w1, [x29, 28]
    mov     w2, '+'
    bl      putc_to

    ldp     x29, x30, [sp], 48
    ret
// DRAW TOP AND BOTTOM EDGES
_box_draw_top_bottom_:
    stp     x29, x30, [sp, -80]!
    mov     x29, sp

    str     w0, [x29, 16]
    str     w1, [x29, 20]
    str     w2, [x29, 24]
    str     w3, [x29, 28]

    ldr     w0, [x29, 16]
    ldr     w4, [x29, 20]
    add     w4, w4, 1
    ldr     w5, [x29, 28]
    sub     w5, w5, 1

_top_loop:
    cmp     w4, w5
    bgt     _top_done
    str     w4, [x29, 32]
    str     w5, [x29, 36]
    str     w0, [x29, 40]

    mov     w1, w4
    mov     w2, '-'
    bl      putc_to

    ldr     w4, [x29, 32]
    ldr     w5, [x29, 36]
    ldr     w0, [x29, 40]
    add     w4, w4, 1
    b       _top_loop

_top_done:
    ldr     w0, [x29, 24]
    ldr     w6, [x29, 20]
    add     w6, w6, 1
    ldr     w7, [x29, 28]
    sub     w7, w7, 1

_bottom_loop:
    cmp     w6, w7
    bgt     _bottom_done
    str     w6, [x29, 48]
    str     w7, [x29, 52]
    str     w0, [x29, 56]

    mov     w1, w6
    mov     w2, '-'
    bl      putc_to

    ldr     w6, [x29, 48]
    ldr     w7, [x29, 52]
    ldr     w0, [x29, 56]
    add     w6, w6, 1
    b       _bottom_loop

_bottom_done:
    ldp     x29, x30, [sp], 80
    ret
// DRAW RIGHT AND LEFT EDGES
_box_draw_right_left_:
    stp     x29, x30, [sp, -80]!
    mov     x29, sp

    str     w0, [x29, 16]
    str     w1, [x29, 20]
    str     w2, [x29, 24]
    str     w3, [x29, 28]

    ldr     w1, [x29, 20]
    ldr     w4, [x29, 16]
    add     w4, w4, 1
    ldr     w5, [x29, 24]
    sub     w5, w5, 1

_left_loop:
    cmp     w4, w5
    bgt     _left_done
    str     w4, [x29, 32]
    str     w5, [x29, 36]
    str     w1, [x29, 40]

    mov     w0, w4
    mov     w2, '|'
    bl      putc_to

    ldr     w4, [x29, 32]
    ldr     w5, [x29, 36]
    ldr     w1, [x29, 40]
    add     w4, w4, 1
    b       _left_loop

_left_done:
    ldr     w1, [x29, 28]
    ldr     w6, [x29, 16]
    add     w6, w6, 1
    ldr     w7, [x29, 24]
    sub     w7, w7, 1

_right_loop:
    cmp     w6, w7
    bgt     _right_done
    str     w6, [x29, 48]
    str     w7, [x29, 52]
    str     w1, [x29, 56]

    mov     w0, w6
    mov     w2, '|'
    bl      putc_to

    ldr     w6, [x29, 48]
    ldr     w7, [x29, 52]
    ldr     w1, [x29, 56]
    add     w6, w6, 1
    b       _right_loop

_right_done:
    ldp     x29, x30, [sp], 80
    ret
// FINISHED!!!
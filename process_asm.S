    .global dispatch
    .global restore_context

    .extern Running
    .extern Ready_q
    .extern q_enqueue
    .extern dispatch_select

dispatch:
    sub     sp, sp, #(16*16)

    stp     x0,  x1,  [sp, #(0*16)]
    stp     x2,  x3,  [sp, #(1*16)]
    stp     x4,  x5,  [sp, #(2*16)]
    stp     x6,  x7,  [sp, #(3*16)]
    stp     x8,  x9,  [sp, #(4*16)]
    stp     x10, x11, [sp, #(5*16)]
    stp     x12, x13, [sp, #(6*16)]
    stp     x14, x15, [sp, #(7*16)]
    stp     x16, x17, [sp, #(8*16)]
    stp     x18, x19, [sp, #(9*16)]
    stp     x20, x21, [sp, #(10*16)]
    stp     x22, x23, [sp, #(11*16)]
    stp     x24, x25, [sp, #(12*16)]
    stp     x26, x27, [sp, #(13*16)]
    stp     x28, x29, [sp, #(14*16)]
    str     x30,      [sp, #(15*16)]

    mrs     x0, SPSR_EL1
    str     x0, [sp, #(16*15+8)]

    adr     x1, Running
    ldr     x1, [x1]
    mov     x4, sp
    str     x4, [x1]

    adr     x0, Ready_q
    bl      q_enqueue

restore_context:
    bl      dispatch_select

    adr     x1, Running
    ldr     x0, [x1]
    str     x0, [x1]
    ldr     x2, [x0]
    mov     sp, x2

    ldr     x0, [sp, #(16*15+8)]
    msr     SPSR_EL1, x0

    ldp     x0,  x1,  [sp, #(0*16)]
    ldp     x2,  x3,  [sp, #(1*16)]
    ldp     x4,  x5,  [sp, #(2*16)]
    ldp     x6,  x7,  [sp, #(3*16)]
    ldp     x8,  x9,  [sp, #(4*16)]
    ldp     x10, x11, [sp, #(5*16)]
    ldp     x12, x13, [sp, #(6*16)]
    ldp     x14, x15, [sp, #(7*16)]
    ldp     x16, x17, [sp, #(8*16)]
    ldp     x18, x19, [sp, #(9*16)]
    ldp     x20, x21, [sp, #(10*16)]
    ldp     x22, x23, [sp, #(11*16)]
    ldp     x24, x25, [sp, #(12*16)]
    ldp     x26, x27, [sp, #(13*16)]
    ldp     x28, x29, [sp, #(14*16)]
    ldr     x30,      [sp, #(15*16)]

    add     sp, sp, #(16*16)

    ret

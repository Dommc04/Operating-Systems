/*
Name: Dominic McElroy 
Date: 3/9/2026
Purpose: Assignment 2 Task Switching 
 * Process.c
 */

#include <stdint.h>
#include "queue.h"
#include "process.h"

#define MAX_PROCESSES 8
#define STACK_SIZE    1024

static uint64_t stacks[MAX_PROCESSES][STACK_SIZE];
static PCB_t    pcb_pool[MAX_PROCESSES];
static int      stack_index = 0;
static int      pcb_index   = 0;

PCB_Q_t  Ready_q;
PCB_t   *Running = (PCB_t *)0;
uint32_t next_pid = 1;

static uint64_t *alloc_stack(int size) {   /*Static Allocator variables*/
    (void)size;
    if (stack_index >= MAX_PROCESSES) return (uint64_t *)0;
    return stacks[stack_index++];
}

static PCB_t *alloc_pcb(void) {
    if (pcb_index >= MAX_PROCESSES) return (PCB_t *)0;
    return &pcb_pool[pcb_index++];
}

int spawn_process(int (*pfun)()) {
    uint64_t *stackptr;
    uint64_t *sp;
    PCB_t    *pcb;
    int       i;

    stackptr = alloc_stack(1024);
    if (stackptr == (uint64_t *)0) {
        return -1;
    }

    sp = stackptr + 1024;

    for (i = 0; i <= 32; i++) {
        sp--;
        *sp = 0;
    }

    *(sp + 30) = (uint64_t)pfun;

    pcb = alloc_pcb();
    if (pcb == (PCB_t *)0) {
        return -1;
    }

    pcb->sp  = (uint64_t)sp;
    pcb->pid = next_pid++;

    q_enqueue(&Ready_q, pcb);

    return 0;
}

void dispatch_select(void) {
    PCB_t *next;
    next = q_dequeue(&Ready_q);
    if (next == (PCB_t *)0) {
        while (1) {}
    }
    Running = next;
}

/*THE STACK FUNCTIONALITY OF THE PROGRAM*/

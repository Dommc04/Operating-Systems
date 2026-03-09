#ifndef QUEUE_H
#define QUEUE_H

#include <stdint.h>

typedef struct PCB {
    uint64_t    sp;
    uint32_t    pid;
    struct PCB *next;
} PCB_t;

typedef struct {
    PCB_t *head;
    PCB_t *tail;
} PCB_Q_t;

void   q_init(PCB_Q_t *q);
void   q_enqueue(PCB_Q_t *q, PCB_t *pcb);
PCB_t *q_dequeue(PCB_Q_t *q);

#endif

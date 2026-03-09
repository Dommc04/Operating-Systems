/*
Name: Dominic McElroy 
Date: 3/9/2026
Purpose: Assignment 2 Task Switching 
 * Queue.C
 */

#include "queue.h"

void q_init(PCB_Q_t *q) {
    q->head = (PCB_t *)0;
    q->tail = (PCB_t *)0;
}

void q_enqueue(PCB_Q_t *q, PCB_t *pcb) {
    pcb->next = (PCB_t *)0;
    if (q->tail == (PCB_t *)0) {
        q->head = pcb;
        q->tail = pcb;
    } else {
        q->tail->next = pcb;
        q->tail = pcb;
    }
}

PCB_t *q_dequeue(PCB_Q_t *q) {
    PCB_t *pcb;
    if (q->head == (PCB_t *)0) {
        return (PCB_t *)0;
    }
    pcb = q->head;
    q->head = pcb->next;
    if (q->head == (PCB_t *)0) {
        q->tail = (PCB_t *)0;
    }
    pcb->next = (PCB_t *)0;
    return pcb;
}

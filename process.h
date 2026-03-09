#ifndef PROCESS_H
#define PROCESS_H

#include "queue.h"

extern PCB_Q_t  Ready_q;
extern PCB_t   *Running;
extern uint32_t next_pid;

int  spawn_process(int (*pfun)());
void dispatch_select(void);
extern void dispatch(void);

#endif


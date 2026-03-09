/*
Name: Dominic McElroy 
Date: 3/9/2026
Purpose: Assignment 2 Task Switching 
Driver:
 * main.c
 */

#include <stdint.h>
#include "queue.h"
#include "process.h"
#include "libos.h"

extern int box(unsigned int srow, unsigned int scol, unsigned int erow, unsigned int ecol);

int p1(void);
int p2(void);
int p3(void);
int p4(void);

static int is_prime(unsigned long long num) {
    unsigned long long i;
    if (num < 2) return 0;
    if (num == 2) return 1;
    if (num % 2 == 0) return 0;
    for (i = 3; i <= num / 2; i += 2) {
        dispatch();
        if (num % i == 0) return 0;
    }
    return 1;
}

int p1(void) {
    char message[] = "Process 1: 0";
    unsigned long long num = 1;
    int count = 0;
    box(9, 23, 11, 39);
    print_to(10, 25, message);
    while (1) {
        if (is_prime(num)) {
            count++;
            message[11] = (char)(count + '0');
            print_to(10, 25, message);
        }
        num++;
        if (count > 9) count = 0;
        if (num > 4000000000ULL) num = 1;
        dispatch();
    }
    return 0;
}

int p2(void) {
    char message[] = "Process 2: 0";
    unsigned long long num = 1;
    int count = 0;
    box(13, 23, 15, 39);
    print_to(14, 25, message);
    while (1) {
        if (is_prime(num)) {
            count++;
            message[11] = (char)(count + '0');
            print_to(14, 25, message);
        }
        num++;
        if (count > 9) count = 0;
        if (num > 4000000000ULL) num = 1;
        dispatch();
    }
    return 0;
}

int p3(void) {
    char message[] = "Process 3: 0";
    unsigned long long num = 1;
    int count = 0;
    box(9, 49, 11, 65);
    print_to(10, 51, message);
    while (1) {
        if (is_prime(num)) {
            count++;
            message[11] = (char)(count + '0');
            print_to(10, 51, message);
        }
        num++;
        if (count > 9) count = 0;
        if (num > 4000000000ULL) num = 1;
        dispatch();
    }
    return 0;
}

int p4(void) {
    char message[] = "Process 4: 0";
    unsigned long long num = 1;
    int count = 0;
    box(13, 49, 15, 65);
    print_to(14, 51, message);
    while (1) {
        if (is_prime(num)) {
            count++;
            message[11] = (char)(count + '0');
            print_to(14, 51, message);
        }
        num++;
        if (count > 9) count = 0;
        if (num > 4000000000ULL) num = 1;
        dispatch();
    }
    return 0;
}

int main(void) {
    int retval;

    print_to(0, 0, "Running processes");

    q_init(&Ready_q);

    retval = spawn_process(p1);
    if (retval != 0) { while(1){} }

    retval = spawn_process(p2);
    if (retval != 0) { while(1){} }

    retval = spawn_process(p3);
    if (retval != 0) { while(1){} }

    retval = spawn_process(p4);
    if (retval != 0) { while(1){} }

    asm volatile("b restore_context");

    while (1) {}
    return 0;
}

/*PROCESS COUNT FUNCTIONALITY OF PROGRAM*/

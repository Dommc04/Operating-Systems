/*
 * CSC 4100 Project 1 - Hello Box
 * kernel.c - Main kernel driver
 * DOMINIC MCELROY - PROGRAM 1 
 */
#include "libos.h"

int box(unsigned int srow, unsigned int scol, unsigned int erow, unsigned int ecol);
int clear_scr(int start_row, int start_col, int width, int height);

int clear_scr(int start_row, int start_col, int width, int height)
{
    int end_row = start_row + height;
    int end_col = start_col + width;
    for (int row = start_row; row < end_row; row++) {
        for (int col = start_col; col < end_col; col++) {
            putc_to(row, col, ' ');
        }
    }
    return 0;
}

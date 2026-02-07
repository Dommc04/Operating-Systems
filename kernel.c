/*
 * CSC 4100 Project 1 - Hello Box
 * kernel.c - Main kernel driver
 * DOMINIC MCELROY - PROGRAM 1 
 */
#include "libos.h"

// Function prototypes
int box(unsigned int srow, unsigned int scol, unsigned int erow, unsigned int ecol);
int clear_scr(int start_row, int start_col, int width, int height);

// CLEAR SCREEN
int clear_scr(int start_row, int start_col, int width, int height)
{
    // END POSITIONS
    int end_row = start_row + height;
    int end_col = start_col + width;
    
    // NESTED LOOPSSSSS
    for (int row = start_row; row < end_row; row++) {
        for (int col = start_col; col < end_col; col++) {
            putc_to(row, col, ' ');  // Clear with space character
        }
    }
    return 0;
}

// MAIN
int main(void)
{
    // CLEAR SCREEN
    clear_scr(0, 0, 128, 30);

    // DRAW BOX = EXACT VALUES
    box(21, 49, 27, 79);

    print_to(24, 59, "Hello world");

    // IDLE FOREVER
    while (1) {
        // INFINITE LOOP
    }

    return 0;
}
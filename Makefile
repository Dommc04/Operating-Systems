# CSC 4100 Project 1 - Hello Box Makefile
# NOTE: For Mac M1/M2/M3 users, remove "aarch64-linux-gnu-" prefix

# Compiler and tools
CC = aarch64-linux-gnu-gcc
LD = aarch64-linux-gnu-ld
CFLAGS = -g -pedantic -Wall -Wextra -fPIC -std=gnu2x -MMD
ASFLAGS = -g -MMD
LDFLAGS = -g -N -Ttext=0x10000

# Target binary
TARGET = kernel.elf

# Object files
OBJS = kernel.o main.o boot.o box.o process.o queue.o process_asm.o

# Libraries
LIBS = libos.a

# Dependency files
DEPS = $(OBJS:.o=.d)

# Default target
all: $(TARGET)

# Link all object files and libraries into the kernel
$(TARGET): $(OBJS) $(LIBS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)

# Compile C source files
kernel.o: kernel.c libos.h
	$(CC) $(CFLAGS) -c $< -o $@

main.o: main.c queue.h process.h libos.h
	$(CC) $(CFLAGS) -c $< -o $@

process.o: process.c process.h queue.h
	$(CC) $(CFLAGS) -c $< -o $@

queue.o: queue.c queue.h
	$(CC) $(CFLAGS) -c $< -o $@

# Assemble assembly files
boot.o: boot.S
	$(CC) $(ASFLAGS) -c $< -o $@

box.o: box.S
	$(CC) $(ASFLAGS) -c $< -o $@

process_asm.o: process_asm.S
	$(CC) $(ASFLAGS) -c $< -o $@

# Include dependency files 
-include $(DEPS)

# Run target 
run: $(TARGET)
	qemu-system-aarch64 -machine raspi3b -kernel $(TARGET)

# Debug target 
debug: $(TARGET)
	qemu-system-aarch64 -machine raspi3b -S -s -kernel $(TARGET) & \
	ddd --debugger 'gdb-multiarch -ex "target remote localhost:1234" -ex "break main" -ex "continue"' $(TARGET)

# Clean target 
clean:
	rm -f $(OBJS) $(DEPS) $(TARGET)

.PHONY: all run debug clean

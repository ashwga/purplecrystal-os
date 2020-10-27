#!/bin/sh

mkdir -p bin

nasm bootloader.asm -f bin -o bin/bootloader.bin
nasm extend.asm -f elf64 -o bin/extend.o

gcc -Ttext 0x8000 -ffreestanding -mno-red-zone -m64 -c Kernel.cpp -o bin/Kernel.o
ld -T"linker.ld"

cat bin/bootloader.bin bin/kernel.bin > bin/bootloader.flp

qemu-system-x86_64 -boot order=a -fda bin/bootloader.flp 2>/dev/null

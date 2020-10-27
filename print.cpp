#pragma once
#include "IO.cpp"
#include "typedefs.cpp"
#define VGA_MEMORY (uint_8*)0x8b000
#define VGA_WIDTH 80


uint_16 CursorPosition;

void SetCursorPosition(uint_16 position)
{
  outb(0x3D4, 0x0F);
  outb(0x3D5, (uint_8)(position & 0xFF));
  outb(0x3D4, 0x0E);
  outb(0x3D5, (uint_8)((position >> 8) & 0xFF));

  if (position > 2000) position = 2000;
  if (position < 0) position = 0;

  CursorPosition = position;
} 

uint_16 PositionFromCoords(uint_8 x, uint_8 y)
{
  return y * VGA_WIDTH + x;
}

void PrintString(const char* str)
{
  uint_8* charPtr = (uint_8*)str;
  uint_16 index = CursorPosition;
  while (*charPtr != 0)
  {
    *(VGA_MEMORY + index*2) = *charPtr;
    index++;
    charPtr++;
  }
  SetCursorPosition(index);
  
}
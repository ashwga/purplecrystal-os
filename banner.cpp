#pragma once
#include "print.cpp"
#include "colorcodes.cpp"

void PrintBanner(uint_8 Theme) {
  SetCursorPosition(0);
  PrintString(" _________________\n\r", Theme);
  PrintString("|o |purple     | o|\n\r", Theme);
  PrintString("|  |crystal    |  |\n\r", Theme);
  PrintString("|  |OS         |  |\n\r", Theme);
  PrintString("|  |           |  |\n\r", Theme);
  PrintString("|  |___________|  |\n\r", Theme);
  PrintString("|     _________   |\n\r", Theme);
  PrintString("|    | __      |  |\n\r", Theme);
  PrintString("|    ||  |     |  |\n\r", Theme);
  PrintString("\\____||__|_____|__|\n\r", Theme);
}
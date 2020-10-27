#include "print.cpp"

extern "C" void _start() {
  SetCursorPosition(0);
  PrintString("testing");
  return;
}

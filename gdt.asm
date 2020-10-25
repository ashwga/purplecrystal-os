gdt_nulldesc:
  dd 0
  dd 0
gdt_codedesc:
  dw 0xffff
  dw 0x0000
  db 0x00
  db 10011010b
  db 11001111b
  db 0x00
gdt_datadesc:
  dw 0xffff
  dw 0x0000
  db 0x00
  db 10010010b
  db 11001111b
  db 0x00

gdt_end:

gdt_descriptor:
  gdt_size: 
    db gdt_end - gdt_nulldesc - 1
    db gdt_nulldesc

codeseg equ gdt_codedesc - gdt_nulldesc
dataseg equ gdt_datadesc - gdt_nulldesc

[bits 32]

EditGDT:
  mov [gdt_codedesc + 6], byte 10101111b
  mov [gdt_datadesc + 6], byte 10101111b
  ret
[bits 16]
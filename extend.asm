jmp EPM

%include 'print.asm'
%include 'gdt.asm'

EPM: ; enter protected mode
  call Ea20
  cli
  lgdt [gdt_descriptor]
  mov eax, cr0
  or eax, 1
  mov cr0, eax
  jmp codeseg:SPM


Ea20: ; enable a20
  in al, 0x92
  or al, 2
  out 0x92, al
  ret

[bits 32]

%include 'CPUID.asm'
%include 'paging.asm'


SPM: ; start pm
  mov ax, dataseg
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov [0xb8000], byte 'H'
  mov [0xb8001], byte 'A'
  mov [0xb8002], byte 'I'

  mov [0xb8003], byte 'a'
  call DetectCPUID
  call DLM
  call SUIP
  call EditGDT
  jmp S64B

[bits 64]
[extern _start]

S64B:
  mov edi, 0xb8000
  mov rax, 0x1f201f201f201f20
  mov ecx, 500
  rep stosq
  call _start
  jmp $

times 2048-($-$$) db 0

BIN=bin/bootloader.bin

OBJS=\
	bin/extend.o\
	Kernel.o\
	# C/IO.o\
	# C/TextModeColorCodes.o\
	# C/TextPrint.o\
	# C/TypeDefs.o\


all: os.flp

os.flp: $(BIN) $(OBJS)
	echo $(OBJS)
	ld -Ttext 0x8000 $(OBJS) -o bin/Kernel.tmp
	objcopy -O binary bin/Kernel.tmp bin/Kernel.bin
	cat $(BIN) bin/Kernel.bin > bin/os.flp


%.o: %.cpp
	g++ -ffreestanding -mno-red-zone -m64 -c $^ -o bin/$@

bin/%.o: %.asm
	nasm -f elf64 $^ -o $@

bin/%.bin: %.asm
	nasm -f bin $^ -o $@

.PHONY: all clean run
clean:
	rm -f $(BIN) $(OBJS)

run: clean os.flp
	qemu-system-x86_64 -fda os.flp

SRC=boot_sect_simple.asm
BIN=boot_sect_simple.bin
TXT=boot_sect_simple.txt
SHELL=/bin/zsh

all: binary hex

binary: $(SRC)
	nasm -f bin $(SRC) -o $(BIN)

qemu: $(SRC)
	nasm -f bin $(SRC) -o $(BIN); \
	qemu-system-i386 $(BIN);

hex: all
	xxd  $(BIN) > $(TXT)

clean:
	if [[ -e "$(BIN)" ]]; then;	\
		rm $(BIN); 				\
	fi; 						\
	if [[ -e "$(TXT)" ]]; then;	\
		rm $(TXT); 				\
	fi;
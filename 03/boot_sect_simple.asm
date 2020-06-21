; Lets find out where the bootloader is placed in memory by
; BIOS....
;
; By moving 0x0e into AH, this will tell the CPU
; to print the char in AL when the interupt 0x10
; is raised.
;
; See this RBIL (https://www.cs.cmu.edu/~ralf/files.html) table for INT 10:
;
; INT 10 - VIDEO - TELETYPE OUTPUT
; 	AH = 0Eh
; 	AL = character to write
; 	BH = page number
; 	BL = foreground color (graphics modes only)
; Return: nothing
; Desc:	display a character on the screen, advancing the cursor and scrolling
; 	  the screen as necessary

; <<Discovered later>>
; This sets the offset globally so we dont need to keep track of where the bootloader
; was loaded into memory. In this case, the bootloader is loaded at 0x7c00 by BIOS.
[org 0x7c00]

; Lets define this label here just for the fun of it
the_secret:
    db "X"

; My attempts at figuring out how to print the above label.
;
mov ah, 0x0e

; Attempt one... Nope..
; mov al, the_secret
; int 0x10

; Attempt two... prints "S" ????
; mov al, [the_secret]
; int 0x10

; Attempt three... prints "X"!!!
; mov bx, the_secret
; add bx, 0x7c00
; mov al, [bx] ; De-reference bx and get its contents
; int 0x10

; Fourth attempt...
;
; This assembles to...
; 00000010: 007c 8a07 cd10 a029 7ccd 10eb fe58 0000  .|.....)|....X..
;                                           ^- 1d (29 in deximal) bytes in..
; mov al, [0x7c00]
; int 0x10

; So now that we can set a global offset, we can print X without doing anything fancy.
mov al, [the_secret]
int 0x10

; Loop forever...
jmp $


; Intent: Fill with 510 zeros minus the size of the previous code.
; 
; times 510-($-$$) db 0
;
; This will fill out the big empty space between the infinite
; loop, leaving just enough space for the `magic number at the end
; The times prefix causes the instruction to be executed
; multiple times. How many times? 510-($-$$) times. We will write
; 0s (bytes) to the output file 510-($-$$) times.
; 
times 510-($-$$) db 0

; This magic number tells the BIOS that this is a boot sector
;
; dw 0xaa55
; 
; This writes one word (2-bytes) to the output file (written here in in little endian).
; So the output should be 55 aa. 
dw 0xaa55
;
; 000001f0: 0000 0000 0000 0000 0000 0000 0000 55aa  ..............U.
;                                              ^- our magic number
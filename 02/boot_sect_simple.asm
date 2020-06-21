; Print "Hello" to the screen.
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

; Print H
mov ah, 0x0e
mov al, 'H'
int 0x10

;
; I think its cool to look at the compiled binary:
; 00000000: b40e b048 cd10 b065 cd10 b06c cd10 cd10  ...H...e...l....
;           ^    ^    ^- Raise the interupt and print to the TTY
;           |    |- Load "h"         
;           |- Load 0x0e into the AH register
;


; Print e
mov al, 'e'
int 0x10

; Note these are different than the Intel IA-32
; interupts defined in Intel's documentation. Right now
; in "bare metal mode" (?) 0x10 means an interupt regarding
; to TTY output. Intel says this should be something about
; "Invalid TSS". I think that only takes effect once we are in
; Intel's "Real Mode", right now, that is not the case.
;
mov al, 'l'
int 0x10
int 0x10

mov al, 'o'
int 0x10

jmp $
;
; Corresponding binary:
; 00000010: b06f cd10 ebfe 0000 0000 0000 0000 0000  .o..............
;                ^    ^- Loop here forever.
;                |- Print 'o'

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
; Simplest boot sector ever
; Infinite loop (e9 fd ff)
loop:
    jmp loop

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
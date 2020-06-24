; So here is how things should look rightnow in
; low level memory...

;             +~~~~~~~~~~~~~~~~~~~~~~~~~+
;             |                         |
;             |          Free           |
;             +-------------------------+ 0x100000
;             |                         |
;             |                         |
;     262144< |          BIOS           |
;             |                         |
;             |                         |
;             +-------------------------+ 0xC0000
;             |                         |
;     131072< |      Video Memory       |
;             |                         |
;             +-------------------------+ 0xA0000
;     1024<   |    Extended BIOS Stuff  | <--- I dont know how Nick Blundell came up with 600KB+ here...
;             +-------------------------+ 0x9fc00
;             |                         |
;             |                         |
;             |                         |
;             |                         |
;     622080< |          Free           |
;             |                         |
;             |                         |
;             |                         | <--- We're about to put a stack here, at 0x8000
;             |                         |
;             +-------------------------+ 0x7e00
;     512<    | Loaded boot sector (us) |
;             +-------------------------+ 0x7c00
;             |                         |
;     30464<  |          Free           |
;             |                         |
;             +-------------------------+ 0x500
;     256<    |    BIOS Data stuff      |
;             +-------------------------+ 0x400
;     1024<   | Interrupt Vector Table  |
;             +-------------------------+ 0x0

; Set tty mode
mov ah, 0x0e 

; Set the stack's base pointer
mov bp, 0x8000

; Set the stack pointer to start at the base and grow DOWNWARD
mov sp, bp

; Push some things on the stack (note these are UNICODE)
push 'A'
push 'B'
push 'C'

; Heres what this looks like now....
;             |                         | 
;             |          Free           | 
;             |                         | 
; bp ----->   |-------------------------| <--- We're about to put a stack here, at 0x8000
; Grows V     |           'A'           | <--- Lives at 0x7ffe (occupies 2 Byte UNICODE)
; Down  V     |           'B'           | <--- Lives at 0x7ffc (occupies 2 Byte UNICODE)
; sp ----->   |           'C'           | <--- Lives at 0x7ffa (occupies 2 Byte UNICODE)
;             |~~~~~~~~~~~~~~~~~~~~~~~~~|
;             |                         |
;             |          Free           |
;             +-------------------------+ 0x7e00
;     512<    | Loaded boot sector (us) |
;             +-------------------------+ 0x7c00
;             |                         |

; Remember!
; "and off the stack:  in 16-bit mode, the stack works only on 16-bit boundaries."
; 2-Bytes!

; Print A
mov al, [0x7ffe]
int 0x10

; Print B
mov al, [0x7ffc]
int 0x10

; Print C
mov al, [0x7ffa]
int 0x10

; Pop off the stack, C
pop bx
mov al, bl
int 0x10

; Pop off the stack, B
pop bx
mov al, bl
int 0x10

; Pop off the stack, A
pop bx
mov al, bl
int 0x10

; Palindrome! Now the stack is empty.

; Magic
jmp $
times 510-($-$$) db 0
dw 0xaa55
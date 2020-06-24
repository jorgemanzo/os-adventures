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
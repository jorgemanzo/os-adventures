## Making a kernel from ground up

I really like low-level OS and kernel stuff, so I am learning more about it. I am following [this](https://github.com/cfenollosa/os-tutorial) guide, however I am leaving more comments about my understanding throught the progress.

Things I am specifically looking to learn about that books seem to skip:
- Creating the boot sector from scratch
- Going from real mode to protected mode
- Starting in Assembly and moving into C
- Virtualizing memory by creating page table data structures
- Handling faults and interrupts
- Loading binaries and executing them
- Anythign else I can get my hands on

Other sources:
- [Writing a Simple Operating System —from Scratch](https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf)

Memory Layout (so far)
---
```
            +~~~~~~~~~~~~~~~~~~~~~~~~~+
            |                         |
            |          Free           |
            +-------------------------+ 0x100000
            |                         |
            |                         |
    262144< |          BIOS           |
            |                         |
            |                         |
            +-------------------------+ 0xC0000
            |                         |
    131072< |      Video Memory       |
            |                         |
            +-------------------------+ 0xA0000
    1024<   |    Extended BIOS Stuff  | <--- I dont know how Nick Blundell came up with 600KB+ here...
            +-------------------------+ 0x9fc00
            |                         |
            |                         |
            |                         |
            |                         |
    622080< |          Free           |
            |                         |
            |                         |
            |                         | <--- We're about to put a stack here, at 0x8000
            |                         |
            +-------------------------+ 0x7e00
    512<    | Loaded boot sector (us) |
            +-------------------------+ 0x7c00
            |                         |
    30464<  |          Free           |
            |                         |
            +-------------------------+ 0x500
    256<    |    BIOS Data stuff      |
            +-------------------------+ 0x400
    1024<   | Interrupt Vector Table  |
            +-------------------------+ 0x0
```
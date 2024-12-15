bits 16             ; specifies to assembler that code will run in 16-bit mode
org 0x7c00          ; code will output stuff at offset 0x7c00

boot:               ; label for boot code start
    mov si,hello    ; moves memory address of hello into si source index register
    mov ah,0x0e     ; 0x0e tells BIOS to 'Write Character in teletype(scrolling) mode'

.loop:
    lodsb           ; loads single byte of memory location pointed by 'si' into 'al' and increments si
    or al,al        ; is al == 0 ?
    jz halt         ; if (al == 0) then jump to 'halt' label
    int 0x10        ; runs BIOS interrupt 0x10 - Video Services
    jmp .loop       ; jumps back to loop

halt:
    cli             ; clear interrupt flag
    hlt             ; halt CPU, stopping all execution

hello: db "Hello world!",0      ; string to be printed is defined

times 510 - ($-$$) db 0         ; fills remaining 510 bytes with zeroes
dw 0xaa55                       ; magic bootloader magic - marks this 512 byte sector bootable

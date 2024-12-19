bits 16							
org 0x7c00						; sets 16 bit mode

boot:
	mov ax, 0x2401					; BIOS interrupt call to enable A20 Gate (memory above 1MB accessible)
	int 0x15					; system interrupt to execute this
	mov ax, 0x3					; sets video mode to text mode config
	int 0x10					; video interrupt to change mode
	cli						; disables interrupt
	lgdt [gdt_pointer]				; loads GDT pointer
	mov eax, cr0					; reads control register 0
	or eax,0x1					; sets the protection enable to 1 (switches the CPU from real mode to protected mode)
	mov cr0, eax
	jmp CODE_SEG:boot2				; jumps at the 32 bits boot2 segment

gdt_start:
	dq 0x0						; first gdt is null discriptor

gdt_code:						; code segment discriptor (properties of code segment)
	dw 0xFFFF     					; Limit (low)
	dw 0x0        					; Base (low)
	db 0x0        					; Base (middle)
	db 10011010b  					; Access byte
	db 11001111b  					; Flags and limit (high)
	db 0x0        					; Base (high)

gdt_data:						; data segment discriptor (similar to code seg)
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0

gdt_end:

gdt_pointer:						; pointer to GDT
	dw gdt_end - gdt_start				; GDT size measured
	dd gdt_start					; GDT address

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

bits 32							; switches to 32-bit mode

boot2:							; loads all segment register with data segment selector
	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	mov esi,hello					; esi points to hello string
	mov ebx,0xb8000					; ebx points to video memory starting (text mode)

.loop:							; loop for checking string and printing
	lodsb						; load string byte
	or al,al					; check if zero
	jz halt						; if zero then jump to halt
	mov ah, 0x02                			; add color attribute
	mov word [ebx], ax				; write character with color
	add ebx,2					; move at next video memory position
	jmp .loop					; continue loop

halt:
	cli						; disables interrupt
	hlt						; halt CPU, stopping all execution

hello: db "Hello world but from 32 bit mode!!!!",0

times 510 - ($-$$) db 0
dw 0xaa55

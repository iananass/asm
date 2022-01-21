.code16
.global init

start:
	mov $0x0e, %ah      # bios io
	mov $0x8000, %bp    
	mov %bp, %sp        # initialize stack
	
	mov $'-', %dl

	mov $msg, %bx
	call print

	mov %dl, %al
	int $0x10

stop:
	jmp stop



print:
	pusha
	mov $'+', %dl
	mov %bx, %si
	print_ch:
		lodsb
		cmp $0, %al
		je done
		int $0x10
		jmp print_ch
	
	done:
		popa
		ret
	

msg: 
	.asciz "Hello my brave new OS"


eod:
	.fill 510-(eod-start),1,0
	.word 0xaa55

.code16
.global init

start:
	mov $0x0e, %ah      # bios io
	mov $0x8000, %bp    
	mov %bp, %sp        # initialize stack
	
	mov $'-', %dl

	mov $msg, %bx
	call print_str

	mov %dl, %al
	int $0x10


	call newline
	mov $0x12CF, %bx
	call print_uint16
	jmp .


newline:
	pusha
	mov $'\n', %al
	int $0x10
	mov $'\r', %al
	int $0x10
	popa
	ret

print_str:
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
	

print_uint16:
	pusha
	mov $12, %cl
	call print_uint_symbol
	mov $8, %cl
	call print_uint_symbol
	mov $4, %cl
	call print_uint_symbol
	mov $0, %cl
	call print_uint_symbol

	popa
	ret

print_uint_symbol:
	pusha
	shr %cl, %bx
	and $0xf, %bx
	mov $itoc, %si
	add %bx, %si
	lodsb
	int $0x10
	popa
	ret


msg: .asciz "Hello my brave new OS"
itoc: .asciz "0123456789ABCDEF"


eod:
	.fill 510-(eod-start),1,0
	.word 0xaa55

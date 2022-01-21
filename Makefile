all:
	as -o hw.gasm.o hw.s 
	ld -o hw.gasm.bin --oformat binary -Ttext 0x7c00 -e init hw.gasm.o
	dd if=hw.gasm.bin of=hw.gasm.img conv=notrunc
	qemu-system-i386 -fda hw.gasm.img -boot a

clean:
	rm -rf *.o *.bin *.img

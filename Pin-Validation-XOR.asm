[org 0x100]

jmp start
arr: db 3,5,9,3,5,9
encrypt:
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push si
	push di
	
	mov bx, [bp+10] ;array address
	mov ax, [bp+6]
	mov cx, [bp+8]
	sub cx, ax ;calculate size
	mov di, cx ;store size in di
	inc cx ;for loop
	xor si, si
	xor dx, dx
	jmp loop1
	swapit:
		mov dl, al
		jmp back
	loop1:
		mov al, [bx+si]
		inc si
		xor al, byte [bp+4]
		cmp al, dl
		jge swapit
		back:
		loop loop1
		
	
	
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	pop bp
	ret 8
start:

	push arr
	push 5
	push 2
	push 4
	call encrypt
	mov ax, 0x4c00
	int 0x21
	

[org 0x100]
jmp start
clrscr:
	push ax
	push cx
	push es
	push di
	mov ax,0xb800
	mov es,ax
	mov cx,2000
	xor di,di
	mov ax,0x0720
	cld
	rep stosw
	pop di
	pop es
	pop cx
	pop ax
	ret
circle:
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	
	mov ax, 0xb800
	mov es, ax
	
	mov si, 80
	mov di, 80
	
	mov ax, 0x072A
	mov [es:di], ax
	
	mov cx, [bp+4]
	mov dx, 2
	
	
	loop1:
		add di, 156
		add si, 164
		mov [es:di], ax
		mov [es:si], ax
		
		loop loop1
	loop2:
		add di, 164
		add si, 156
		mov [es:di], ax
		mov [es:si], ax
		
		cmp si, di
		jnz loop2
		
	
	
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret 2
	


start:
	call clrscr
	mov ax, 4
	push ax
	call circle
	mov ax, 0x4c00
	int 0x21

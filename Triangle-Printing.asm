[org 0x100]
jmp start
clrscr:
	push es
	push ax
	push cx
	push di
	mov ax,0xb800
	mov es,ax;pointestovideobase
	xor di,di;pointditotopleftcolumn
	mov ax,0x0720;spacecharinnormalattribute
	mov cx,2000;numberofscreenlocations
	cld;autoincrementmode
	rep stosw;clearthewholescreen
	pop di
	pop cx
	pop ax
	pop es
	ret

delay:
	push ax
	push bx
	push cx
	mov ax,3
	l1:
		mov bx,1000
		l2:
			mov cx,1000
			
			l3:
				dec cx
				cmp cx,0
				jnz l3
				dec bx
				cmp bx,0
				jnz l2
				dec ax
				cmp ax,0
				jnz l1
				
		
	pop cx
	pop bx
	pop ax
	
	ret
PrintTriangle:
	call clrscr
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
	
	mov si, 1200
	mov di, 1200
	
	mov ax, 0x092B
	mov [es:di], ax
	
	mov cx, [bp+4]
	mov dx, 0
	
	
	
	loop1:
		
		add di, 156
		add si, 164
		
		mov [es:di], ax
		
		mov [es:si], ax
		
		loop loop1
	loop2:
		mov [es:di], ax
		mov [es:si], ax
		sub si,2
		add di,2	
		cmp si, di
		
		jnz loop2
		
	call delay
	call clrscr
	mov si, 520
	mov di, 520
	
	mov ax, 0x022A
	mov [es:di], ax
	
	mov cx, [bp+4]
	mov dx, 0
		
	loop3:
		
		add di, 160
		add si, 164
		
		mov [es:di], ax		
		mov [es:si], ax
		
		loop loop3
	loop4:
		mov [es:di], ax
		mov [es:si], ax
		sub si,2
		add di,2	
		cmp si, di
		
		jnz loop4
	
	call delay
	call clrscr
	
	mov si, 3900
	mov di, 3900
	
	mov ax, 0x0423
	mov [es:di], ax
	
	mov cx, [bp+4]
	mov dx, 0
	loop5:
		
		sub di, 156
		sub si, 164
		
		mov [es:di], ax
		
		mov [es:si], ax
		
		loop loop5
	loop6:
		mov [es:di], ax
		mov [es:si], ax
		add si,2
		sub di,2	
		cmp si, di
		
		jnz loop6
	
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret 2
	
start:
	
	push 10 ; size of the triangle
	call PrintTriangle
	mov ax, 0x4c00
	int 0x21
	

[org 0x0100]
jmp start
size: dw 8
star:
	first:
		push ax
		push cx
		push es
		mov ax,0xb800
		mov es,ax;
		mov di,80
		mov si,80
		mov word[es:di],0x772A
		mov cx,word[size]
		dec cx
		l1:
		add di,162
		add si,158
	
		mov word[es:di],0x772A
		mov word[es:si],0x772A
		loop l1
	
	
		
	second:
		push ax
		push cx
		push es
		mov ax,0xb800
		mov es,ax;
		mov cx,word[size]
		add cx, 8
		l2:
		add di,2
		sub si,2
		mov word[es:di],0x672A
		mov word[es:si],0x672A
		loop l2
	add di, 4
	sub si, 4
	
		
	third:
		push ax
		push cx
		push es
		mov ax,0xb800
		mov es,ax;
		mov cx,word[size]
		dec cx
		l3:
		add di,156
		add si,164
		mov word[es:di],0x572A
		mov word[es:si],0x572A
		loop l3
		
		
	fourth:
		push ax
		push cx
		push es
		mov ax,0xb800
		mov es,ax;
		mov cx,word[size]
		dec cx
		dec cx
		l4:
		add di,162
		add si,158
		mov word[es:di],0x472A
		mov word[es:si],0x472A
		loop l4
		
		
	fifth:
		push ax
		push cx
		push es
		mov ax,0xb800
		mov es,ax;
		mov cx,word[size]
		sub cx,3
		l5:
		sub di,166
		sub si,154
		mov word[es:di],0x372A
		mov word[es:si],0x372A
		
		loop l5
		
ret								
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

start:
	call clrscr
	call star
	
	mov ax,0x4c00
	int 0x21

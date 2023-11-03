[org 0x0100]
jmp start
size: dw 3
delay:
	push ax
	push bx
	push cx
	mov ax,3
	ll1:
		mov bx,500
		ll2:
			mov cx,500
			
			ll3:
				dec cx
				cmp cx,0
				jnz ll3
				dec bx
				cmp bx,0
				jnz ll2
				dec ax
				cmp ax,0
				jnz ll1
				
		
	pop cx
	pop bx
	pop ax
	
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
up:
	push ax
	push cx
	push es
	mov ax,0xb800
	mov es,ax;
	mov di,90
	mov ax,0x022A
	mov cx,[size]
	mov si,di
	l1:
		add di,160
		loop l1
		
	mov si,di
	call delay
	
	mov word[es:di],ax
	mov cx,word[size]
	
	l2:
		sub di,154
		sub si,166
		call delay
		mov word[es:di],ax
		mov word[es:si],ax
		
		loop l2
	
	pop es
	pop cx
	pop ax
	ret
down1:
	push ax
	push cx
	push es
	mov ax,0xb800
	mov es,ax;
	mov ax,0x072A
	mov cx,[size]
	
	l3:
		add di,164
		add si,156
		call delay
		mov word[es:di],ax
		call delay
		mov word[es:si],ax
		loop l3
	
	pop es
	pop cx
	pop ax
	ret
down2:
	push ax
	push cx
	push es
	mov ax,0xb800
	mov es,ax;
	mov ax,0x072A
	l4:
		add di,158
		add si,162
		mov word[es:di],ax
		mov word[es:si],ax
		cmp si,di
		jne l4
	
	pop es
	pop cx
	pop ax
	ret
start:
	call clrscr
	call up
	call down1
	call down2
	mov ax,0x4c00
	int 0x21

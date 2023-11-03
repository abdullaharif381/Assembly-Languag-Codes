[org 0x100]
jmp start
cross:
	push bp
	mov bp, sp
	push ax
	push cx
	push dx
	push si
	push di
	
	mov ax, 0xb800
	mov es, ax
	mov al, 80
	mul byte[bp+4]
	;add ax, [bp+6]
	shl ax, 1	
	
	
	
	mov di, ax	
	mov cx, 80
	mov ax, 0xB720
	rep stosw  
	
	mov ax, [bp+6]
	shl ax, 1
	mov di, ax
	
	mov cx, 25
	l1:	
	mov word[es:di], 0xA720
	add di, 160
	loop l1
	
	mov al, 80
	mul byte[bp+4]
	add ax, [bp+6]
	shl ax, 1
	mov di, ax
	
	mov al, '*'
	mov ah, 0xAC
	
	mov word[es:di], ax
	pop di
	pop si
	pop dx
	pop cx
	pop ax
	pop bp	
	ret 4
	
start:
	mov ax, 10
	push ax
	mov ax, 10
	push ax
	call cross
	mov ax, 0x4c00
	int 0x21
	
	

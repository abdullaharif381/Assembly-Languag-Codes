[org 0x100]

jmp start

index: db 0
num: dw 0x381A ;0011 1000 0001 1010
pattern: dw 0x1A 	;0001 1010

start:	mov ax, [num]; 0011 1000 0001 1010
	push ax
	mov ax, [pattern]
	push ax
	call find_pattern

mov ax, 0x4c00
int 0x21

find_pattern:
	push bp
	mov bp, sp
	push cx
	push dx
	push si
	push di

	mov bx, [bp+4]
	mov ax, [bp+6]

	xor cx, cx

	mov cl, 0x10	
	mov dx, bx
count_n:
	inc ch
	shr dx, 1
	jnz count_n	
	mov dx, bx
	jmp find

match:
	sub cl, ch
	mov [index], cl
	xor ax, ax
	mov al, byte[index]
	jmp done

find:
	and dx, ax
	cmp dx, bx
	je match
	shl bx, 1
	mov dx, bx
	loop find

	xor ax, ax
	mov ax, 0xffff

done:

pop di
pop si
pop dx
pop cx
pop bp
ret 

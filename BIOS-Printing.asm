[org 0x100]
jmp start
name: db 'I am A B D U L L A H'
name_len: dw 20
mode: db 'Just growing quieter'
mode_len: dw 20
inst: db 'FAST-NUCES'
inst_len: dw 10
roll: db '22L 7 7 6 4'
roll_len: dw 11



clrscr: push es
	 push ax
	 push cx
	 push di
	 mov ax, 0xb800
	 mov es, ax ; point es to video base
	 xor di, di ; point di to top left column
	 mov ax, 0x720 ; space char in normal attribute
	 mov cx, 2000 ; number of screen locations
	 cld ; auto increment mode
	 rep stosw ; clear the whole screen
	 pop di 
	 pop cx
	 pop ax
	 pop es
	 ret 
 
 
print:
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	
	
	
	
	mov ax, 0xb800
	mov es, ax
	
	mov si, [bp+6]
	mov cx, [bp+4]
	mov ah, 3
	cld
	nextchar: 
		lodsb 
		stosw 
		loop nextchar
		
	
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 4


start:
	call clrscr
	s5:
	mov ah,00
	int 16h
	cmp ah, 28
	jne s5
	
	xor di, di
	add di, 700
	mov ax, name
	push ax
	mov ax, [name_len]
	push ax
	call print
	
	s4:
	mov ah,00
	int 16h
	cmp ah, 28
	jne s4
	
	add di, 160
	sub di, [name_len]
	sub di, [name_len]
	mov ax, mode
	push ax
	mov ax, [mode_len]
	push ax
	call print
	s2:
	mov ah,00
	int 16h
	cmp ah, 21
	jne s2
	
	add di, 160
	sub di, [mode_len]
	sub di, [mode_len]
	mov ax, inst
	push ax
	mov ax, [inst_len]
	push ax
	call print
	s1:
	mov ah,00
	int 16h
	cmp ah, 28
	jne s1
	
	add di, 160
	sub di, [inst_len]
	sub di, [inst_len]
	mov ax, roll
	push ax
	mov ax, [roll_len]
	push ax
	call print
	
mov ax, 0x4c00
int 0x21

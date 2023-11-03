[org 0x100]
jmp start
PIN: db 5,2,4,1,3
PIN2: db 4,3,5,3,4
PIN3: db 6,4,5,3,8

min: db 5,2,4,1,3
max: db 9,5,8,4,6

Validate_PIN:
	push bp
	mov bp, sp
	push bx
	push cx
	push dx
	
	mov bx, [bp+4]
	xor cx, cx
	
	check1:
		inc cx
		xor si, si
		mov dx, [bx+si]
		cmp dx, [max]		
		ja invalid
		cmp dx, [min]
		jb invalid
		
	check2:
		inc cx
		mov si, 1
		mov dx, [bx+si]
		cmp dx, [max]		
		ja invalid
		cmp dx, [min]
		jb invalid
	check3:
		inc cx
		mov si, 2
		mov dx, [bx+si]
		cmp dx, [max]		
		ja invalid
		cmp dx, [min]
		jb invalid
	check4:
		inc cx
		mov si, 3
		mov dx, [bx+si]
		cmp dx, [max]		
		ja invalid
		cmp dx, [min]
		jb invalid
	check5:
		inc cx
		mov si, 4
		mov dx, [bx+si]
		cmp dx, [max]		
		ja invalid
		cmp dx, [min]
		jb invalid	
		
	invalid:
		cmp cx, 1
		je first
		cmp cx, 2
		je second
		cmp cx, 3
		je third
		cmp cx, 4
		je fourth
		cmp cx, 5
		je fifth
		
		
	first:	
		mov ax, cx
		jmp fin
	second:	
		mov ax, cx
		jmp fin
	third:	
		mov ax, cx
		jmp fin
	fourth:	
		mov ax, cx
		jmp fin
	fifth:	
		mov ax, cx
		jmp fin
	
		
		
		
	fin:
	pop dx
	pop cx
	pop bx
	pop bp
	ret 2
	
start:
	push PIN
	call Validate_PIN
	mov ax, 0x4c00
	int 0x21

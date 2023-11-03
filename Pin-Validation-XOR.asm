[org 0x100]
jmp start
m1: dw "VALID", 0
m2: dw "INVALID", 0

PIN: db 5,2,4,1,3
PIN2: db 4,3,5,3,4
PIN3: db 6,4,5,3,8

min: db 5,2,4,1,3
max: db 9,5,8,4,6
delay:
	push ax
	push bx
	push cx
	mov ax,3
	l1:
		mov bx,700
		l2:
			mov cx,700
			
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
		mov dl, byte[bx+si]
		cmp dl, byte[max]		
		ja invalid
		cmp dl, byte[min]
		jb invalid
		
	check2:
		inc cx
		mov si, 1
		mov dl, byte[bx+si]
		cmp dl, byte[max+si]		
		ja invalid
		cmp dl, byte[min+si]
		jb invalid
	check3:
		inc cx
		mov si, 2
		mov dl, byte[bx+si]
		cmp dl, byte[max+si]		
		ja invalid
		cmp dl, byte[min+si]
		jb invalid
	check4:
		inc cx
		mov si, 3
		mov dl, byte[bx+si]
		cmp dl, byte[max+si]		
		ja invalid
		cmp dl, byte[min+si]
		jb invalid
	check5:
		inc cx
		mov si, 4
		mov dl, byte[bx+si]
		cmp dl, byte[max+si]		
		ja invalid
		cmp dl, byte[min+si]
		jb invalid
		
		jmp fin
		
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
	
print: 
	push bp
	mov bp, sp
	push bx
	push cx
	push dx
	push si
	push di
	
			  mov  di, [bp+4]         ; point di to string 
              mov  cx, 0xffff         ; load maximum number in cx 
              xor  al, al             ; load a zero in al 
              repne scasb             ; find zero in the string 
              mov  ax, 0xffff         ; load maximum number in ax 
              sub  ax, cx             ; find change in cx 
              dec  ax                 ; exclude null from length 
              jz   exit               ; no printing if string is empty
			 
              mov  cx, ax             ; load string length in cx 
              mov  ax, 0xb800 
              mov  es, ax             ; point es to video base 
              mov  al, 80             ; load al with columns per row 
              mul  byte [bp+8]        ; multiply with y position 
              add  ax, [bp+10]        ; add x position 
              shl  ax, 1              ; turn into byte offset 
              mov  di,ax              ; point di to required location 
              mov  si, [bp+4]         ; point si to string 
              mov  ah, [bp+6]         ; load attribute in ah
	
	
             cld                     ; auto increment mode 
nextchar:     lodsb                   ; load next char in al 
              stosw                   ; print char/attribute pair 
              loop nextchar           ; repeat for the whole string 
 
exit:         pop  di 
              pop  si 
              pop  cx 
              pop  ax 
              pop  es 
              pop  bp 
              ret  8 
start:
	push PIN
	call Validate_PIN
	call clrscr
	push ax
	push m1
	push m2
	call print
	
	push PIN2
	call Validate_PIN
	call clrscr
	push ax
	push m1
	push m2
	call print

	push PIN3
	call Validate_PIN
	call clrscr
	push ax
	push m1
	push m2
	call print

    mov  ax, 0x4c00         ; terminate program 
    int  0x21    

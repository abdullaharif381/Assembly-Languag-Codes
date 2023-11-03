[org 0x0100]
jmp start
message: db ' ABDULLAH ARIF ',0;nullterminatedstring
message2: db 'after delay',0;nullterminatedstring

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
		mov bx,1100
		l2:
			mov cx,1100
			
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
printstr: push bp 
	 mov bp, sp 
	 push es 
	 push ax 
	 push cx 
	 push si 
	 push di 
	 push ds 
	 
	 pop es ; load ds in es 
	 mov di, [bp+4] ; point di to string 
	 mov cx, 0xffff ; load maximum number in cx 
	 xor al, al ; load a zero in al 
	 repne scasb ; find zero in the string 
	 mov ax, 0xffff ; load maximum number in ax 
	 sub ax, cx ; find change in cx 
	 dec ax ; exclude null from length 
	 
	 jz exit ; no printing if string is empty
	 mov cx, ax ; load string length in cx 
	 mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [bp+8] ; multiply with y position 
	 add ax, [bp+10] ; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, [bp+4] ; point si to string 
	 
	 mov ah, [bp+6] ; load attribute in ah 
 cld ; auto increment mode 
nextchar: lodsb ; load next char in al 
	 stosw ; print char/attribute pair 
	 loop nextchar ; repeat for the whole string 
exit: pop di 
	 pop si 
	 pop cx 
	 pop ax 
	 pop es 
	 pop bp 
	 ret 8 
	
start:
	call clrscr

	 mov ax, 30 
	 push ax ; push x position 
	 mov ax, 20 
	 push ax ; push y position 
	 mov ax, 0xcf ; blue on black attribute 
	 push ax ; push attribute 
	 mov ax, message 
	 push ax
	 
	call printstr
	
	call delay
	
	 mov ax, 30 
	 push ax ; push x position 
	 mov ax, 10 
	 push ax ; push y position 
	 mov ax, 0xee ; blue on black attribute 
	 push ax ; push attribute 
	 mov ax, message2 
	 push ax
	 call printstr
	 
mov ax, 0x4c00 ; terminate program 
int 0x21 

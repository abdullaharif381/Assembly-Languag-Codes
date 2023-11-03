[org 0x100]
jmp start
n: dw " A B D U L L A H   A R I F ", 0
i: dw " FAST - NU Lahore ", 0
b: dw " Batch 2022 ", 0
r: dw " 2 2 L 7 7 6 4 ", 0
e: dw " l227764@lhr.nu.edu.pk ", 0
a: dw " Lahore, Punjab, Pakistan ", 0


clrscr:       push es 
              push ax 
              push cx 
              push di 
              mov  ax, 0xb800 
              mov  es, ax             ; point es to video base 
              xor  di, di             ; point di to top left column 
              mov  ax, 0xb720       ; space char in normal attribute 
              mov  cx, 2000           ; number of screen locations 
              cld                     ; auto increment mode 
              rep  stosw             ; clear the whole screen 
              pop  di 
			  pop  cx 
              pop  ax 
              pop  es 
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
nextchar: 
	lodsb ; load next char in al 
	stosw ; print char/attribute pair 
	loop nextchar ; repeat for the whole string 
exit: 
	 pop di 
	 pop si 
	 pop cx 
	 pop ax 
	 pop es 
	 pop bp 
	 ret 8 

delay: 
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	mov ax,3
	l1:
		mov bx,[bp+4]
		l2:
			mov cx,[bp+4]
			
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
	pop bp
	
	ret 2

scrollup:
	push bp
	mov bp, sp
	push ax
	push cx
	push si
	push di
	push es
	push ds
	
	 mov ax, 80 ; load chars per row in ax 
	 mul byte [bp+4] ; calculate source position 
	 mov si, ax ; load source position in si 
	 push si ; save position for later use 
	 shl si, 1 ; convert to byte offset 
	 mov cx, 2000 ; number of screen locations 
	 sub cx, ax ; count of words to move 
	 mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov ds, ax ; point ds to video base 
	 xor di, di ; point di to top left column 
	 cld ; set auto increment mode 
	 rep movsw ; scroll up 
	 mov ax, 0xb720 ; space in normal attribute 
	 pop cx ; count of positions to clear 
	 rep stosw ; clear the scrolled space
	 
	pop ds 
	pop es 
	pop di 
	pop si 
	pop cx 
	pop ax 
	pop bp 
	ret 2 


start:
	call clrscr
	
	
	mov ax, 800
	push ax 
	call delay
	
	mov ax, 20 
	push ax ; push x position 
	mov ax, 20 
	push ax ; push y position 
	mov ax, 0x93 ; blue on black attribute 
	push ax ; push attribute 
	mov ax, n 
	push ax ; push address of message 
	call printstr 
	
	mov ax, 800
	push ax 
	call delay
	
	mov ax, 2
	push ax
	call scrollup
	
	mov ax, 20 
	push ax ; push x position 
	mov ax, 20 
	push ax ; push y position 
	mov ax, 0xc3 ; blue on black attribute 
	push ax ; push attribute 
	mov ax, i 
	push ax ; push address of message 
	call printstr 
	
	mov ax, 2
	push ax
	call scrollup
	
	mov ax, 800
	push ax 
	call delay
	
	mov ax, 20 
	push ax ; push x position 
	mov ax, 20 
	push ax ; push y position 
	mov ax, 0x93 ; blue on black attribute 
	push ax ; push attribute 
	mov ax, b 
	push ax ; push address of message 
	call printstr 
	
	mov ax, 800
	push ax 
	call delay
	
	mov ax, 2
	push ax
	call scrollup
	
	mov ax, 20 
	push ax ; push x position 
	mov ax, 20 
	push ax ; push y position 
	mov ax, 0xc3 ; blue on black attribute 
	push ax ; push attribute 
	mov ax, r 
	push ax ; push address of message 
	call printstr 
	
	mov ax, 2
	push ax
	call scrollup	
	
	mov ax, 800
	push ax 
	call delay
	
	mov ax, 20 
	push ax ; push x position 
	mov ax, 20 
	push ax ; push y position 
	mov ax, 0x93 ; blue on black attribute 
	push ax ; push attribute 
	mov ax, e 
	push ax ; push address of message 
	call printstr 
	
	mov ax, 800
	push ax 
	call delay
	
	mov ax, 2
	push ax
	call scrollup
	
	mov ax, 20 
	push ax ; push x position 
	mov ax, 20 
	push ax ; push y position 
	mov ax, 0xc3 ; blue on black attribute 
	push ax ; push attribute 
	mov ax, a 
	push ax ; push address of message 
	call printstr 
	
	mov ax, 4
	push ax
	call scrollup	
	
	mov ax, 0x4c00
	int 0x21
	

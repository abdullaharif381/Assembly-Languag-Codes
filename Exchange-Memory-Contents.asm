[org 0x0100]
jmp start
para1: dw 2,3
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
	push ax
	push cx
	push es
	push di
	
	mov ax,0xb800
	mov es,ax
	mov cx,40
	
	mov dx,13
	xor di,di
q1a:
	mov ax,0xa720
	rep stosw
	add di,80
	mov cx,40
	dec dx
	jnz q1a

	mov di,80
	mov dx,13
q2a:
	q2b:
	mov word[es:di],0xc720
	add di,2
	loop q2b
	
	add di,80
	mov cx,40
	dec dx
	jnz q2a
	
	mov di,1920
	mov dx,13
q3a:
	q3b:
	mov word[es:di],0xd720
	add di,2
	loop q3b
	add di,80
	mov cx,40
	dec dx
	jnz q3a
 
	mov di,2000
	mov dx,13
q4a:
	q4b:
	mov word[es:di],0xe720
	add di,2
	loop q4b
	add di,80
	mov cx,40
	dec dx
	jnz q4a
	pop di
	pop es
	pop cx
	pop ax
	ret
	
offsets:
	push bp
	mov bp,sp
	push ax
	checkfirstparameter:
	mov ax,[para1]
	cmp ax,1
	jne fd1
	mov word[bp+4],0
	jmp checksecondparameter
	fd1:
	cmp ax,2
	jne fd2
	mov word[bp+4], 80
	jmp checksecondparameter
	fd2:
	cmp ax,3
	jne fd3
	mov word[bp+4], 1920
	jmp checksecondparameter
	fd3:
	mov word[bp+4],2000

	checksecondparameter:
	mov ax,word[para1+2]
	cmp ax,1
	jne fe1
	mov word[bp+6], 0
	jmp exit
	fe1:
	cmp ax,2
	jne fe2
	mov	word [bp+6], 80
	jmp exit
	fe2:
	cmp ax,3
	jne fe3
	mov word[bp+6], 1920
	jmp exit
	fe3:
	mov word[bp+6], 2000
	
	exit:
	pop ax
	pop bp
	ret 
exchange:
	push ax
	push cx
	push es
	push di
	push 0
	push 0
	call offsets
	pop si
	pop di
	
	mov ax,0xb800
	mov es,ax
	
	mov dx,13
l1:
	mov cx,40
	
	l2:
		mov ax, word[es:di]
		mov bx, word[es:si]

		xchg ax, bx
		
		mov word [es:di], ax
		mov word[es:si], bx
		
		call delay
		
		add di,2
		add si,2
		loop l2
	add di,80
	add si,80
	dec dx
	jnz l1
	pop di
	pop es
	pop cx
	pop ax
	ret
	
	
delay:
	push ax
	push bx
	push cx
	mov ax,3
	l11:
		mov bx,50
		l22:
			mov cx,50
			
			l33:
				dec cx
				cmp cx,0
				jnz l33
				dec bx
				cmp bx,0
				jnz l22
				dec ax
				cmp ax,0
				jnz l11
				
		
	pop cx
	pop bx
	pop ax
	
	ret
start:
	call clrscr
	call print
	
	call exchange
mov ax,0x4c00
int 0x21

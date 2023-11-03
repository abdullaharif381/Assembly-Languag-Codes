[org 0x100]
jmp start

arr: dw 0xA, 0xA, 0xA
len equ $ - arr

start:
    mov ax, arr
    push ax
    mov ax, len
    push len
    call statOfArray
done:
    mov ax, 0x4c00
    int 0x21

median:
    xor cx, cx
    mov ax, [bp+4]
    mov bl, 4
    div bl
    cmp ah, 0
    je evens
    jmp odd
evens:
    mov ah, 0
    mov si, ax
    mov bx, [bp+6]
    dec si
    shl si,1
    mov cx, [bx+si]
    jmp fin
odd:
	mov ah, 0
	mov si, ax
	mov bx, [bp+6]
	shl si, 1
	mov cx, [bx+si]
    jmp fin
  
statOfArray:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov ax, [bp+6]
    push ax 
    mov ax, [bp+4]
    push ax
    call bubblesort
    jmp median

fin:
    mov ax, [arr+0]
    mov si, len
    mov bx, [arr+len-2]
    jmp done
    

bubblesort:
    push bp
    mov bp, sp 
    sub sp, 2
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov bx, [bp+6]
    mov cx, [bp+4]

    dec cx
    shl cx, 1
    
    mainloop:
        mov si, 0
        mov word[bp-2], 0
        
        innerloop:
            mov ax, [bx+si]
            cmp ax, [bx+si+2]
            jbe noswap
            xchg ax, [bx+si+2]
            mov [bx+si], ax
            mov word[bp-2], 1
        noswap:
            add si, 2
            cmp si, cx
            jne innerloop
            cmp word[bp-2], 1
            je mainloop

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    mov sp, bp
    pop bp
    ret 

[org 0x100]
jmp start
x1: db 21
x2: db 20
y1: db 41
y2: db 40

manhattan:
push bp
mov bp, sp
push bx
push cx
push dx

xor cx, cx

mov bx, [bp+10]
mov cx, [bp+8]
sub bx, cx
mov ax, bx
cmp ax, 0
jge skip_neg_x
neg ax
skip_neg_x:

xor cx, cx

mov dx, [bp+6]
mov cx, [bp+4]
sub dx, cx
add ax, dx
cmp ax, 0
jge skip_neg_y
neg ax
skip_neg_y:

pop dx
pop cx
pop bx
pop bp
ret 8

start:

mov ax, [x1]
push ax
mov ax, [x2]
push ax
mov ax, [y1]
push ax
mov ax, [y2]
push ax

call manhattan

mov ax, 0x4c00
int 0x21

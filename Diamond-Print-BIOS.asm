[org 0x0100]
jmp code
w equ 50 ; width offset
x equ 50 ; starting x coordinate of line
y equ 100 ; starting y coordinate of line
c equ 60 ; color

a equ 100 ; starting x coordinate of line
b equ 50 ; starting y coordinate of line
d equ 150
e equ 100

code: mov ah, 0
 mov al, 13h
 int 10h
; draw diagonal 11:
mov cx, x
mov dx, y
 mov al, c

 
mov cx, a
mov dx, b
 
mov al, c
u2: inc dx
mov ah, 0ch ; put pixel
 int 10h
 inc cx
 cmp cx, a+w
 jbe u2
;wait for keypress
 mov ah,00
 int 16h
 
  mov cx, a
mov dx, b
 
  mov al, c
u3: inc dx
mov ah, 0ch ; put pixel
 int 10h
 dec cx
 cmp cx, x
 jae u3
;wait for keypress
 mov ah,00
 int 16h
 
 mov cx, d
mov dx, e
 
  mov al, c
u4: inc dx
mov ah, 0ch ; put pixel
 int 10h
 dec cx
 cmp cx, y
 jae u4
 
;wait for keypress
 mov ah,00
 int 16h
 mov cx, x
mov dx, y
 mov al, c
u1: inc dx
mov ah, 0ch ; put pixel
 int 10h
 inc cx
 cmp cx, x+w
 jbe u1
;wait for keypress
 mov ah,00
 int 16h
mov ax, 0x4c00
int 21h

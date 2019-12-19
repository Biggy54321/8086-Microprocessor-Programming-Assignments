.8086
.model small
.stack 100h
.data
    num1 db ?
    num2 db ?
    msg1 db "Enter the first number", 10, 13, "$"
    msg2 db "Enter the second number", 10 , 13, "$"
    msg3 db "Product of the two given numbers is", 10, 13, "$"
.code
    include utils.asm

main proc
    ; get num1
    lea si, msg1
    push si
    call str_write
    pop si
    call byte_read
    mov num1, al
    call print_newline

    ; get b
    lea si, msg2
    push si
    call str_write
    pop si
    call byte_read
    mov num2, al
    call print_newline

    ; multiply by rotation
    mov ax, 00h; ax stores the Product
    mov bl, num1
    mov bh, 00h 
    mov cl, num2
main_again:
    shr cl, 01h
    jnc main_down
    add ax, bx
main_down:
    shl bx, 01h
    cmp cl, 00h
    jnz main_again

    ; print the Product
    push ax
    call word_write
    pop ax

    ret
endp

.startup
    mov ax, @data
    mov ds, ax
    call main
    mov ah, 4ch
    int 21h
end
.8086
.model small
.stack 100h
.data
    num1 db ?
    num2 db ?
    msg1 db "Enter the 8 bit number", 10, 13, "$"
    msg2 db "Enter the 8 bit number", 10, 13, "$"
    msg3 db "The product of the two numbers is", 10, 13, "$"
.code
    include utils.asm

main proc
    ; get the first number
    lea si, msg1
    push si
    call str_write
    pop si
    call byte_read
    mov num1, al
    call print_newline

    ; get the second number
    lea si, msg2
    push si
    call str_write
    pop si
    call byte_read
    mov num2, al
    call print_newline

    ; multiply and print the result
    mov al, num1
    mov bl, num2
    mul bl
    lea si, msg3
    push si
    call str_write
    pop si
    ; print the result from ax
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
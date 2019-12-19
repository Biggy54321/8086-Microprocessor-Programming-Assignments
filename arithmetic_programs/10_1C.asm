.8086
.model small
.stack 100h
.data
    num1 db ?
    result dw ?
    msg1 db "Enter the number", 10, 13, "$"
    msg2 db "The 1's complement of the number is", 10, 13, "$"
.code
    include utils.asm

main proc
    ; get the number
    lea si, msg1
    push si
    call str_write
    pop si
    call byte_read
    mov num1, al
    call print_newline

    ; find the negation i.e. the 1's Complement of the number
    not al

    ; print the inversion
    push ax
    call byte_write
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
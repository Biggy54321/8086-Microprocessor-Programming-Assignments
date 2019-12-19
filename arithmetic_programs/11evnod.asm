.8086
.model small
.stack 100h
.data
    num1 db ?
    result dw ?
    msg1 db "Enter the number", 10, 13, "$"
    msg_even db "The given number is even", 10, 13, "$"
    msg_odd db "The given number is odd", 10, 13, "$"
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

    ; check if the number is odd or even by checking the lsb bit
    test al, 01h
    jnz main_odd
    lea si, msg_even
    push si
    call str_write
    pop si
    jmp main_down
main_odd:
    lea si, msg_odd
    push si
    call str_write
    pop si
    
main_down:
    ret
endp

.startup
    mov ax, @data
    mov ds, ax
    call main
    mov ah, 4ch
    int 21h
end
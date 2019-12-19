.8086
.model small
.stack 100h
.data
    num1 dw ?
    num2 db ?
    result db ?
    msg1 db "Enter the 16 bit dividend", 10, 13, "$"
    msg2 db "Enter the 8 bit divisor", 10, 13, "$"
    msg3 db "The result is (Remainder <space> Quotient) is", 10, 13, "$"
    msg4 db "Cannot divide as divisor is zero", 10, 13, "$"
.code
    include utils.asm

main proc
    ; get the first number which is dividend
    lea si, msg1
    push si
    call str_write
    pop si
    call word_read
    mov num1, ax
    call print_newline

    ; get the second number which is divisor
    lea si, msg2
    push si
    call str_write
    pop si
    call byte_read
    mov num2, al
    call print_newline

    ; divide and store the result in memory and print also
    cmp num2, 00h
    jnz main_down
    lea si, msg4
    push si
    call str_write
    pop si
    ret
main_down:
    mov ax, num1
    mov bl, num2
    div bl
    lea si, msg3
    push si
    call str_write
    pop si
    ; print the remainder in ah
    mov dl, ah
    push dx
    call byte_write
    pop dx
    mov dl, al
    push dx
    call byte_write
    pop dx

    ret
endp

.startup
    mov ax, @data
    mov ds, ax
    call main
    mov ah, 4ch
    int 21h
end
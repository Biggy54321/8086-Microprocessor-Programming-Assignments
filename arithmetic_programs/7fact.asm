.8086
.model small
.stack 100h
.data
    num1 db ?
    result dw ?
    msg1 db "Enter the number", 10, 13, "$"
    msg2 db "The factorial of the number is", 10, 13, "$"
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

    ; calculate the factorial
    mov bl, num1
    mov bh, 00h
    push bx
    call factorial
    pop bx
    mov result, ax

    ; print the factorial value
    lea si, msg2
    push si
    call str_write
    pop si
    mov dx, result
    push dx
    call word_write
    pop dx

    ret
endp

factorial proc
    push bp
    mov bp, sp
    push bx

    ; get the passed number from the stack in the register dx (data is only 8 bit)
    mov bx, [bp + 04h]
    cmp bl, 01h
    jnz factorial_down1
    mov ax, 0001h
    jmp factorial_down2
factorial_down1:
    dec bx
    push bx
    call factorial
    pop bx
    inc bx
    ; the return value is going to be in al so multiply it by dl to get the answer
    mul bx

factorial_down2:
    pop bx
    pop bp
    ret
endp

.startup
    mov ax, @data
    mov ds, ax
    call main
    mov ah, 4ch
    int 21h
end
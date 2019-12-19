.8086
.model small
.stack 100h
.data
    num1 db ?
    result dw ?
    msg1 db "Enter the number", 10, 13, "$"
    msg2 db "The fibonacci series for given number is", 10, 13, "$"
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

    ; calculate the fibonacci series and print simultaneously
    mov cl, num1
    mov ch, 00h
    mov al, 00h
    mov ah, 01h
    ; print the al term which is fo term in the fibonacci series
main_again:
    push ax
    call byte_write
    pop ax
    call print_space
    ; set f2 = f0 + f1 and f0 = f1, f1 = f2 for the next iteration
    xchg al, ah
    add ah, al
    loop main_again

    ret
endp

.startup
    mov ax, @data
    mov ds, ax
    call main
    mov ah, 4ch
    int 21h
end
.8086
.model small
.stack 100h
.data
    str1 db 100 dup (?)
    str_len db ?
    msg1 db "Enter the string", 10, 13, "$"
    msg2 db "The string length is", 10, 13, "$"
.code
    include utils.asm

main proc
    ; get the string
    lea si, msg1
    push si
    call str_write
    pop si
    lea si, str1
    push si
    call str_read
    pop si

    ; find the string length by traversing the complete string
main_again:
    mov al, "$"
    cmp [si], al
    jz main_down
    inc si
    inc str_len
    jmp main_again

    ; print the length of the string
main_down:
    mov al, str_len
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
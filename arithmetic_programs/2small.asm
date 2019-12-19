.8086
.model small
.stack 100h
.data
    array db 100 dup (?)
    len_arr db 00h
    msg1 db "Enter the length of array", 10, 13, "$"
    msg2 db "Enter the array elements", 10, 13, "$"
.code
    include utils.asm

main proc
    ; get the length of the array
    lea si, msg1
    push si
    call str_write
    pop si
    call byte_read
    mov len_arr, al
    call print_newline

    ; get the array elements
    lea si, msg2
    push si
    call str_write
    pop si
    mov cl, len_arr
    mov ch, 00h
    lea si, array
main_again1:
    call byte_read
    mov [si], al
    call print_newline
    inc si
    loop main_again1

    ; find the minimum element
    mov cl, len_arr
    mov ch, 00h
    dec cx
    lea si, array
    mov al, [si]
main_again2:
    inc si
    cmp al, [si]
    jc main_down
    mov al, [si]
main_down:
    loop main_again2

    ; print the minimum element
    push ax
    call byte_write
    pop ax
    call print_newline

    ret
endp

.startup
    mov ax, @data
    mov ds, ax
    call main
    mov ah, 4ch
    int 21h
end
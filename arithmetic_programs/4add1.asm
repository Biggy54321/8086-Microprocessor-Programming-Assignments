.8086
.model small
.stack 100h
.data
    array1 db 100 dup (?)
    array2 db 100 dup (?)
    add_array db 100 dup (?)
    len_arr db 00h
    msg1 db "Enter the length of arrays", 10, 13, "$"
    msg2 db "Enter the array elements for array 1", 10, 13, "$"
    msg3 db "Enter the array elements for array 2", 10, 13, "$"
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

    ; get the array 1 elements
    lea si, msg2
    push si
    call str_write
    pop si
    mov cl, len_arr
    mov ch, 00h
    lea si, array1
main_again1:
    call byte_read
    mov [si], al
    call print_newline
    inc si
    loop main_again1

    ; get the array 2 elements
    lea si, msg3
    push si
    call str_write
    pop si
    mov cl, len_arr
    mov ch, 00h
    lea si, array2
main_again2:
    call byte_read
    mov [si], al
    call print_newline
    inc si
    loop main_again2

    ; add the array element wise
    mov cl, len_arr
    mov ch, 00h
    lea si, array1
    lea di, array2
    lea bx, add_array
main_again3:
    mov al, [si]
    add al, [di]
    mov [bx], al
    inc si
    inc di
    inc bx
    loop main_again3

    ; print the addition array
    mov cl, len_arr
    mov ch, 00h
    lea si, add_array
main_again4:
    push [si]
    call byte_write
    pop [si]
    call print_space
    inc si
    loop main_again4

    ret
endp

.startup
    mov ax, @data
    mov ds, ax
    call main
    mov ah, 4ch
    int 21h
end
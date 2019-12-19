.8086
.model small
.stack 100h
.data
    array db 100 dup (?)
    len_arr db 00h
    msg1 db "Enter the length of array", 10, 13, "$"
    msg2 db "Enter the array elements", 10, 13, "$"
    msg3 db "The sorted array is", 10, 13, "$"
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

    ; sort the array in ascending order
main_again2:
    mov cl, len_arr
    mov ch, 00h
    dec cx
    lea si, array
main_again3:
    mov al, [si]
    cmp al, [si + 01h]
    jnc main_down
    ; swap if al is greater and again start from the beginning of the array
    xchg al, [si + 01h]
    mov [si], al
    jmp main_again2
main_down:
    inc si
    loop main_again3

    ; print the sorted array
    lea si, msg3
    push si
    call str_write
    pop si
    mov cl, len_arr
    mov ch, 00h
    lea si, array
main_again4:
    push [si]
    call byte_write
    pop [si]
    inc si
    call print_space
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
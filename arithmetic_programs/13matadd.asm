.8086
.model small
.stack 100h
.data
    matrix1 db 100 dup (?)
    matrix2 db 100 dup (?)
    row_count db ?
    column_count db ?
    msg1 db "Enter the row count", 10, 13, "$"
    msg2 db "Enter the column count", 10 , 13, "$"
    msg3 db "Enter first matrix elements", 10, 13, "$"
    msg4 db "Enter second matrix elements", 10, 13, "$"
    msg5 db "Addition of the two matrices is", 10, 13, "$"
.code
    include utils.asm

main proc
    ; get the number of rows
    lea si, msg1
    push si
    call str_write
    pop si
    call byte_read
    mov row_count, al
    call print_newline

    ; get the number of columns
    lea si, msg2
    push si
    call str_write
    pop si
    call byte_read
    mov column_count, al
    call print_newline

    ; get the first matrix elements
    lea si, msg3
    push si
    call str_write
    pop si
    lea si, matrix1
    mov cl, row_count
    mov ch, 00h
main_again1:
    push cx ; push in stack the counter for the outer loop
    mov cl, column_count
    mov ch, 00h
main_again2:
    call byte_read
    mov [si], al
    call print_space
    inc si
    loop main_again2
    pop cx
    call print_newline
    loop main_again1

    ; get the second matrix elements
    lea si, msg4
    push si
    call str_write
    pop si
    lea si, matrix2
    mov cl, row_count
    mov ch, 00h
main_again3:
    push cx ; push in stack the counter for the outer loop
    mov cl, column_count
    mov ch, 00h
main_again4:
    call byte_read
    mov [si], al
    call print_space
    inc si
    loop main_again4
    pop cx
    call print_newline
    loop main_again3

    ; add the two matrices
    lea si, msg5
    push si
    call str_write
    pop si
    lea si, matrix1
    lea bx, matrix2
    mov cl, row_count
    mov ch, 00h
main_again5:
    push cx
    mov cl, column_count
    mov ch, 00h
main_again6:
    ; add the contents at the given index and print
    mov al, [si]
    add al, [bx]
    push ax
    call byte_write
    pop ax
    call print_space
    inc si
    inc bx
    loop main_again6
    call print_newline
    pop cx
    loop main_again5

    ret
endp

.startup
    mov ax, @data
    mov ds, ax
    call main
    mov ah, 4ch
    int 21h
end
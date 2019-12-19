.8086
.model small
.stack 100h
.data
    num_a db ?
    num_b db ?
    num_c db ?
    num_d db ?
    msg1 db "Enter a", 10, 13, "$"
    msg2 db "Enter b", 10, 13, "$"
    msg3 db "Enter c", 10, 13, "$"
    msg4 db "Enter d", 10 ,13, "$"
    msg5 db "(a * b) + (c * d) is", 10, 13, "$"
.code
    include utils.asm

main proc
    ; get a
    lea si, msg1
    push si
    call str_write
    pop si
    call byte_read
    mov num_a, al
    call print_newline

    ; get b
    lea si, msg2
    push si
    call str_write
    pop si
    call byte_read
    mov num_b, al
    call print_newline

    ; get c
    lea si, msg3
    push si
    call str_write
    pop si
    call byte_read
    mov num_c, al
    call print_newline

    ; get d
    lea si, msg4
    push si
    call str_write
    pop si
    call byte_read
    mov num_d, al
    call print_newline

    ; calculate the expression
    mov al, num_a
    mul num_b
    mov bx, ax
    mov al, num_c
    mul num_d
    add ax, bx

    ; print the the value of ax
    push ax
    call word_write
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
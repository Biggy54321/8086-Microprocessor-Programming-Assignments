.8086
.model small
.stack 100h
.data
    block1 db 100 dup (?)
    block2 db 100 dup (?)
    block_len db 00h
    msg1 db "Enter the length of block", 10, 13, "$"
    msg2 db "Enter the source block elements", 10, 13, "$"
    msg3 db "The transfered block is", 10, 13, "$"
.code
    include utils.asm

main proc
    ; get the length of the block
    lea si, msg1
    push si
    call str_write
    pop si
    call byte_read
    mov block_len, al
    call print_newline

    ; get the block elements
    lea si, msg2
    push si
    call str_write
    pop si
    lea si, block1
    mov cl, block_len
    mov ch, 00h
main_again1:
    call byte_read
    mov [si], al
    inc si
    call print_newline
    loop main_again1

    ; transer the block from source to destination
    lea si, block1
    lea di, block2
    mov cl, block_len
    mov ch, 00h
main_again2:
    mov al, [si]
    mov [di], al
    inc si
    inc di
    loop main_again2

    ; print destination block
    lea si, msg3
    push si
    call str_write
    pop si
    lea si, block2
    mov cl, block_len
    mov ch, 00h
main_again3:
    push [si]
    call byte_write
    pop [si]
    call print_space
    inc si
    loop main_again3

    ret
endp

.startup
    mov ax, @data
    mov ds, ax
    call main
    mov ah, 4ch
    int 21h
end
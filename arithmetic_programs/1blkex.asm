.8086
.model small
.stack 100h

.data
    block1 db 100 dup (?)
    block2 db 100 dup (?)
    block_len db 00h
    enter_len db "Enter the length", 10, 13, "$"
    enter_msg1 db "Enter block 1", 10, 13, "$"
    enter_msg2 db "Enter block 2", 10, 13, "$"
.code
    include utils.asm
main proc
    ; get the length of the blocks
    lea si, enter_len
    push si
    call str_write
    pop si
    call byte_read
    mov block_len, al

    call print_newline

    ; get the first block
    lea si, enter_msg1
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

    ; get the second block
    lea si, enter_msg2
    push si
    call str_write
    pop si
    lea si, block2
    mov cl, block_len
    mov ch, 00h
main_again2:
    call byte_read
    mov [si], al
    inc si
    call print_newline
    loop main_again2

    ; swap the two blocks
    lea si, block1
    lea di, block2
    mov cl, block_len
    mov ch, 00h
main_again3:
    mov al, [si]
    xchg al, [di]
    mov [si], al
    inc si
    inc di
    loop main_again3
    
    ; print the blocks after exchange
    lea si, block1
    mov cl, block_len
    mov ch, 00h
main_again4:
    push [si]
    call byte_write
    pop [si]
    call print_space
    inc si
    loop main_again4

    call print_newline

    lea si, block2
    mov cl, block_len
    mov ch, 00h
main_again5:
    push [si]
    call byte_write
    pop [si]
    call print_space
    inc si
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
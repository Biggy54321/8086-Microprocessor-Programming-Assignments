.8086
.model small
.stack 100h
.data
    block1 db 100 dup (?)
    block2 db 100 dup (?)
    len1 db ?
    len2 db ?
    msg1 db "Enter the length of block 1", 10, 13, "$"
    msg2 db "Enter the block 1 elements", 10, 13, "$"
    msg3 db "Enter the length of block 2", 10 , 13, "$"
    msg4 db "Enter the block 2 elements", 10, 13, "$"
    msg5 db "The overlapped block is", 10, 13, "$"

.code
    include utils.asm

main proc
    ; get the block 1
    lea si, msg1
    push si
    call str_write
    pop si
    
    call byte_read
    mov len1, al
    call print_newline
    
    lea si, msg2
    push si
    call str_write
    pop si

    lea si, block1
    mov cl, len1
    mov ch, 00h
main_again:
    call byte_read
    mov [si], al
    call print_space
    inc si
    loop main_again
    call print_newline

    ; get the block 2
    lea si, msg3
    push si
    call str_write
    pop si
    
    call byte_read
    mov len2, al
    call print_newline
    
    lea si, msg4
    push si
    call str_write
    pop si

    lea si, block2
    mov cl, len2
    mov ch, 00h
main_again1:
    call byte_read
    mov [si], al
    call print_space
    inc si
    loop main_again1
    call print_newline

    ; overlap block 1 on block 2
    lea si, block1
    lea di, block2
    mov cl, len1
    mov ch, 00h
main_again2:
    mov al, [si]
    mov [di], al
    inc si
    inc di
    loop main_again2

    ; print the overlapped block 2
    lea si, msg5
    push si
    call str_write
    pop si
    
    lea si, block2
    mov cl, len2
    mov ch, 00h
main_again3:
    push [si]
    call byte_write
    pop [si]
    inc si
    call print_space
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
.8086
.model small
.stack 100h
.data
    str1 db 100 dup (?)
    str_len db ?
    str_rev db 100 dup (?)
    msg1 db "Enter the string", 10, 13, "$"
    msg2 db "The reverse string is", 10, 13, "$"
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
main_again1:
    mov al, "$"
    cmp [si], al
    jz main_down
    inc si
    inc str_len
    jmp main_again1

main_down:
    ; reverse strings character and store in another string
    cld
    lea si, str1
    lea di, str_rev
    mov cl, str_len
    mov ch, 00h
    add di, cx
    mov al, "$"
    mov [di], al
    dec di
main_again2:
    movsb
    sub di, 0002h
    loop main_again2

    ; print reversed string
    lea si, msg2
    push si
    call str_write
    pop si
    lea si, str_rev
    push si
    call str_write
    pop si

    ret
endp

.startup
    mov ax, @data
    mov ds, ax
    mov es, ax
    call main
    mov ah, 4ch
    int 21h
end
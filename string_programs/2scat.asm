.8086
.model small
.stack 100h
.data
    str1 db 100 dup (?)
    str2 db 100 dup (?)
    str_cat db 100 dup (?)
    msg1 db "Enter string 1", 10, 13, "$"
    msg2 db "Enter string 2", 10, 13, "$"
    msg3 db "The concatenated string is", 10, 13, "$"
.code
    include utils.asm

main proc
    ; get the string one
    lea si, msg1
    push si
    call str_write
    pop si
    lea si, str1
    push si
    call str_read
    pop si

    ; get the string two
    lea si, msg2
    push si
    call str_write
    pop si
    lea si, str2
    push si
    call str_read
    pop si
    
    ; copy first string in the destination string till $
    cld
    lea di, str_cat
    lea si, str1
main_again1:
    lodsb
    cmp al, "$"
    jz main_down1
    stosb
    jmp main_again1

    ; copy the second string in the destination string with $
main_down1:
    lea si, str2
main_again2:
    lodsb
    stosb
    cmp al, "$"
    jz main_down2
    jmp main_again2

    ; print the concatenated string
main_down2:
    lea si, str_cat
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
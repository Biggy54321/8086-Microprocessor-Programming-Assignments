.8086
.model small
.stack 100h
.data
    str1 db 100 dup (?)
    str2 db 100 dup (?)
    str_len1 db ?
    str_len2 db ?
    msg1 db "Enter string 1", 10, 13, "$"
    msg2 db "Enter string 2", 10, 13, "$"
    msg3 db "str 1 is greater than str 2", 10, 13, "$"
    msg4 db "str 2 is greater than str 1", 10, 13, "$"
    msg5 db "str1 and str2 are same", 10, 13, "$"
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
    

    ; compare the two strings
    mov al, "$"
    lea si, str1
    lea di, str2
main_again:
    cmpsb
    jnz main_down
    cmp [si - 01h], al
    jz main_down3
    jmp main_again

    ; if control comes to this point implies that the two strings are unequal
main_down:
    jc main_down1
    lea si, msg3
    push si
    call str_write
    pop si
    jmp exit
main_down1:
    lea si, msg4
    push si
    call str_write
    pop si
    jmp exit

main_down3:
    lea si, msg5
    push si
    call str_write
    pop si

exit:
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
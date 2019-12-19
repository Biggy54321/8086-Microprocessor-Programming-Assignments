.8086
.model small
.stack 100h
.data
	str1 db 100 dup (?)
	str2 db 100 dup (?)
	msg1 db "Enter string", 10, 13, "$"
	msg2 db "The copied string is", 10, 13, "$"

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

	; copy the first string in the second string
	mov al, "$"
	lea di, str2
	lea si, str1
main_again:
	movsb
	cmp [si - 01h], al
	jz exit
	jmp main_again

exit:
	; print the moved string
	lea si, str2
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

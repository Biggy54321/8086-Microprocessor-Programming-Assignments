.8086
.model small
.stack 100h
.data
	str1 db 100 dup (?)
	str_change_case db 100 dup (?)
	msg1 db "Enter string 1", 10, 13, "$"
	msg2 db "The string which has changed case is", 10, 13, "$"

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

	; change the case till we encounter $
	lea si, msg2
	push si
	call str_write
	pop si
	lea si, str1
	lea di, str_change_case
main_again:	
	lodsb
	cmp al, "$"
	jz exit
	cmp al, "a"
	jc main_down
	sub al, 20h
	stosb
	jmp main_again
main_down:
	add al, 20h
	stosb
	jmp main_again

exit:
	; place $ at the end of the second string
	mov al, "$"
	mov [di], al
	; print the changed case string
	lea si, str_change_case
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

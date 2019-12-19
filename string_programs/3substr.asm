.8086
.model small
.stack 100h
.data
	str1 db 100 dup (?)
	str2 db 100 dup (?)
	msg1 db "Enter string 1", 10, 13, "$"
	msg2 db "Enter string 2", 10, 13, "$"
	msg3 db "The given string is a substring", 10, 13, "$"
	msg4 db "The given string is not a substring", 10, 13, "$"

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

	; check if the second string is substring of the first string
	mov al, "$"
	mov cx, 0000h
	lea si, str1
main_again1:
	lea di, str2
main_again2:
	cmpsb
	jz main_down
	; check if the last checked character was $ if yes then the substring is found
	cmp [di - 01h], al
	jz main_down1
	inc cx
	lea si, str1
	add si, cx
	; check if the current start position of the string is $ if yes then stop loop
	cmp [si], al
	jz main_down2
	jmp main_again1
main_down:
	cmp [di - 01h], al
	jz main_down1
	jmp main_again2

	; print the substring is found
main_down1:
	lea si, msg3
	push si
	call str_write
	pop si
	ret

	; print the substring is not found
main_down2:
	lea si, msg4
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

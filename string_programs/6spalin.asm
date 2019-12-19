.8086
.model small
.stack 100h
.data
	str1 db 100 dup (?)
	msg1 db "Enter string", 10, 13, "$"
	msg2 db "The given string is a palindrome", 10, 13, "$"
	msg3 db "The given string is not a palindrome", 10, 13, "$"

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

	; check if the given string is a palindrome or not
	lea di, str1
	mov al, "$"
main_again1:
	cmp [di], al
	jz main_down1
	inc di
	jmp main_again1
	
main_down1:
	cld
	dec di
	lea si, str1
main_again2:
	cmpsb
	jnz main_down2
	sub di, 0002h
	cmp si, di
	jc main_again2

	; if loop is completed then a palindrome is found
	lea si, msg2
	push si
	call str_write
	pop si
	ret

main_down2:
	; string is not a palindrome
	lea si, msg3
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

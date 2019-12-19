; parameters are passed through the stack and return values are passed through al
; in the below functions only ax, dx, di are changed in these are used in main then push them there first
; do not used ax register within functions to call each other

nibble_read proc
	; read ascii in al
	mov ah, 01h
	int 21h
	
	; convert ascii to hex
	cmp al, "A"
	jc nibble_read_down
	sub al, 07h
nibble_read_down:
	sub al, 30h

	ret
endp
	
nibble_write proc
	push bp
	mov bp, sp	
	push dx
	push ax

	; get the character to be printed from stack (only lower nibble of that byte)
	mov dx, [bp + 04h]

	; convert the character to its ascii value
	and dx, 000Fh
	cmp dl, 0Ah
	jc nibble_write_down
	add dl, 07h
nibble_write_down:
	add dl, 30h
	
	; print the character
	mov ah, 02h
	int 21h

	pop ax
	pop dx
	pop bp
	ret
endp

str_read proc
	push bp
	mov bp, sp
	push di
	push ax
	mov ax, @data
	mov es, ax
	; get the starting address of the location where string is to be stored
	mov di, [bp + 04h]

	; keep on reading character till we get enter	
	mov ah, 01h
str_read_again:
	int 21h
	cmp al, 0Dh
	jz str_read_down
	stosb
	jmp str_read_again
	
	; place $ at the end of the string
str_read_down:
	mov al, "$"
	mov [di], al

	pop ax
	pop di
	pop bp
	ret
endp
	

str_write proc
	push bp
	mov bp, sp
	push dx
	push ax

	; get the starting address of the string from the stack
	mov dx, [bp + 04h]
	
	; print the string
	mov ah, 09h
	int 21h

	pop ax
	pop dx
	pop bp
	ret
endp

byte_read proc
	push dx

	; call nibble_read two times
	call nibble_read
	mov dl, al
	shl dl, 04h

	call nibble_read
	xor al, dl

	pop dx
	ret
endp

byte_write proc
	push bp
	mov bp, sp
	push ax

	; get the byte from the stack
	mov al, [bp + 04h]

	; print the upper nibble first
	rol al, 04h
	push ax
	call nibble_write
	pop ax
	mov al, [bp + 04h]
	push ax
	call nibble_write
	pop ax

	pop ax
	pop bp
	ret
endp

word_read proc
	push dx
	; read two bytes in ax
	call byte_read
	mov dl, al
	call byte_read
	mov ah, dl

	pop dx
	ret
endp

word_write proc
	push bp
	mov bp, sp
	push dx
	
	; get the word from stack
	mov dx, [bp + 04h]
	mov dl, dh
	push dx
	call byte_write
	pop dx
	mov dx, [bp + 04h]
	push dx
	call byte_write
	pop dx

	pop dx
	pop bp
	ret
endp

print_newline proc
	push dx
	push ax

	; print the newline and carriage return characters
	mov ah, 02h
	mov dl, 0Ah
	int 21h
	mov dl, 0Dh
	int 21h

	pop ax
	pop dx
	ret
endp

print_space proc
	push dx
	push ax

	;print the space
	mov ah, 02h
	mov dl, 20h
	int 21h

	pop ax
	pop dx
	ret
endp
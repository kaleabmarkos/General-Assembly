;;   Description: assembly language. It prompts the user 
;;   to enter a name, processes the input, and then outputs
;;   the processed name with a comma separating the last name
;;   and the first name. If no name is given, it displays an
;;   error message. The program uses a set of procedures 
;;   (prompt and output) to achieve this functionality.

		Include pcmac.inc   ; Include a macro file for PC assembly programming
		.model small        ; Specify the memory model for the program
		.586                ; Use instructions compatible with the Intel 586 processor
		.stack 100h          ; Set the stack size to 100h (256 bytes)
		.data               ; Start the data segment

msg DB "Name:", '$'       ; Define a null-terminated string "Name:"
msg1 DB "No given name!", '$'  ; Define a null-terminated string for an error message
i    Dw ?               ; Define a word-sized variable i (used as a counter)
j   DW ?                ; Define a word-sized variable j
k   DW ?                ; Define a word-sized variable k
array db 80 dup(?)      ; Define an array of 80 bytes (used for storing input)

		.code               ; Start the code segment
		EXTRN	PutDec: near   ; Declare an external procedure PutDec
		Extern  GetDec: near  ; Declare an external procedure GetDec


prompt proc             ; Define a procedure named prompt
		sub si, si         ; Initialize si register to 0
		mov i, 0           ; Initialize i variable to 0
while_b:
		_putStr msg        ; Print the "Name:" prompt message

while_a:
		_GetCh             ; Read a character from input
		cmp al, 13         ; Compare the read character with carriage return
		je end_while_a     ; If it's a carriage return, exit the loop
		mov byte ptr[bx], al  ; Store the character in the array
		inc bx             ; Move to the next position in the array
		inc i              ; Increment the counter
		jmp while_a       ; Repeat the loop

end_While_a:
		cmp i, 0           ; Check if i is 0
		je errorn          ; If i is 0, jump to errorn
		jmp done           ; Otherwise, jump to done

errorn:
		_putCh 13          ; Print carriage return
		_putCh 10          ; Print line feed
		_putStr msg1       ; Print the error message
		_putCh 13          ; Print carriage return
		_putCh 10          ; Print line feed
		jmp while_b        ; Jump to the outer loop (while_b)

done:
		ret                ; Return from the prompt procedure
prompt endp


output proc             ; Define a procedure named output
		mov bx, offset array  ; Initialize bx to the address of the array
		mov cx, i            ; Copy the value of i to cx
		mov j, cx            ; Copy the value of cx to j

f_a:
		inc bx               ; Increment bx (move to the next position in the array)
		dec cx               ; Decrement cx (decrease the counter)
		jnz f_a              ; Repeat the loop until cx is not zero

w_a:
		dec bx               ; Decrement bx (move to the previous position in the array)
		inc k                ; Increment k (used for storing the length of the name)
		dec j                ; Decrement j (used for counting characters)

		jz s                 ; If j is zero, jump to s
		cmp byte ptr[bx], 32 ; Compare the character at the current position with space
		jne w_a              ; If not space, repeat the loop (move to the previous character)

f_b:
		mov dl, byte ptr[bx] ; Load the character at the current position into dl
		_putCh               ; Print the character
		inc bx               ; Move to the next position in the array
		inc cx               ; Increment cx
		cmp cx, k            ; Compare cx with k
		jne f_b              ; If not equal, repeat the loop

		_putCh ','           ; Print a comma
		_putCh ' '           ; Print a space

		mov bx, offset array ; Reset bx to the beginning of the array

		mov ax, i            ; Copy the value of i to ax
		sub ax, k            ; Subtract k from ax
		mov i, ax            ; Copy the result back to i

f_c:
		mov dl, byte ptr[bx] ; Load the character at the current position into dl
		_putCh               ; Print the character
		inc bx               ; Move to the next position in the array
		dec i                ; Decrement i
		jnz f_c              ; Repeat the loop until i is not zero
		jmp endit            ; Jump to endit

s:
		mov bx, offset array  ; Reset bx to the beginning of the array
sl:
		mov dl, byte ptr[bx]  ; Load the character at the current position into dl
		_putCh                ; Print the character
		inc bx                ; Move to the next position in the array
		dec i                 ; Decrement i
		jnz sl                ; Repeat the loop until i is not zero

endit:
		ret                  ; Return from the output procedure
output endp

Main	Proc              ; Define the main procedure
		_begin              ; Start of the program execution
		mov bx, offset array ; Initialize bx to the address of the array
		call prompt         ; Call the prompt procedure to get user input
		call output         ; Call the output procedure to process and display the input
		_Exit 0             ; Exit the program with code 0
Main 	endp 
	End main             ; End of the main procedure

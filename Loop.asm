;;	Description: This is short assembly language program
;;				 Asks for a symbol, a number and interates 
;;				 the symbole number times across the screen.
;;				 Overall, this program is a simple example of an
;;               assembly program that takes user input, performs 
;; 				 some operations based on that input, and displays 
;;				 the results in a scrolling fashion.
		.model small
		.586
		.stack 100h
		.data
M1		db "Enter a Character : ", '$'
M2    db "Number of times you want to iterate (if not 1-3 you will be asked again): ", '$'
charr     db ?
num     dw ?
newL    db 13, 10, '$'
		.code
		include PCMAC.INC
		EXTRN GetDec:near
main	proc		;;main function entry point of the program and calls 3 procedures or functions
		_Begin
		call GetChar	;;proc 1
		call GetNum		;;proc 2
		call Display	;;proc 3	
	    _Exit 0 		;;exits the program
main    endp

GetNum  proc		;;This procedure Get and store the number of times the user wants to iterate
		
do_loop:
		_PutStr newL
		_PutStr M2
		call GetDec		;;get the decimal
		mov num, ax
		cmp ax, 3		;;checks if the entered number is 1-3
		jg do_loop
		cmp ax, 1
		jl do_loop		;;if not jump back and ask the user again
endDo_loop:		 
		ret
GetNum	endp 			;;end proc



Delay	PROC  			;;This is a simple delay procedure using a loop to introduce a delay
		push cx 
		mov cx, 0 
for_2:	nop
		dec cx
		jnz for_2
		pop cx 
		ret
Delay	ENDP


GetChar  proc			;;This procedure gets and stores the charachter the user wants to display
		_PutStr M1		;;Prompts the M1
		_GetCh 			;;Get the character input
		mov charr, al
		ret
GetChar	ENDP


;;This procedure uses two nested loops (for_B and for_1) 
;;to iterate Through a specified number of times.
;;Inside the loop it uses _putch to display the character 
;;and introduces delays fro visual effect.
;;The character is first displayed forward and then backward.

Display proc  			
		mov bx, 0  		;;initialize a counter
for_B:
		cmp bx, num		;;checks bx is greater than or equal to the specified number 'num'
		jge endFor_B	;;If true, exits the loop otherwise, proceeds with the display process.
		mov cx,79   
for_1:	mov dl, charr		;; displays the character forward and introduces delays.
		_PutCh
		call delay
		_PutCh 8
		_PutCh 32
		dec cx
		jnz for_1
f_2:					;;After the forward display, this loop used to display the character backward.
		_PutCh 8
		mov dl, charr
		_PutCh
		call Delay
		_PutCh 8
		_PutCh 32
		_PutCh 8
		inc CX
		cmp cx, 79
		jne f_2
		inc bx
		jmp for_B
endFor_B:
		ret
Display endp
		end main		;;The End

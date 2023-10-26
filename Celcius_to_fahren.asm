;;	Name: Kaleab Gessese
;;	Class: CSc 314
;;	Assign: 04
;;	Due: 10/23/23
;;	Description: This is short assembly language program
;;				 Takes a Celcius(number) and converts it 
;;				 to Fahrenheit. So this is a Celcius to 
;;				 Farenheit converter.

		include pcmac.inc
		.model small
		.586
		.stack 100h
		.data
		
Msg		db"Enter the temprateure in Celcius: ",'$'		
answer	db ' degrees Fahrenheit',13,10,'$'
Celcius	dw ?
x		dw ?
		.code
		EXTERN PutDec : near
		EXTERN GetDec : near
main	Proc
		_Begin
		_PutStr Msg
		call GetDec ;;takes the value (the Celcius)
		mov Celcius, ax ;; that value we inputed is in ax so we mov it to Celcius
		mov ax, Celcius ;; now that is our multiplicand going to ax
		mov bx, 9 ;; mov 9 to another 16bit register
		imul bx ;;multiply our input by bx(9)
		mov bx, 5 ;; mov 5 the registers for division
		idiv bx ;;divide our dividend by bx 
		add ax, 32 ;; add 32 to ax (whree our quotient is in)
		mov x,ax ;;let a variable hold the value
		mov ax,x ;;mov our value to a register
		call PutDec ;; Display it
		_PutStr answer
		_Exit 0
main	endP
		end main

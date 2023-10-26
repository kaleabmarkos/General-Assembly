;;Description: This short assembly program that prints today's date.
;;
        Include pcmac.inc
        .MODEL  SMALL
        .586
        .STACK  100h

        .DATA
M		DW 0   ; Define a variable to store the month
D		DW 0   ; Define a variable to store the day
Y		DW 0   ; Define a variable to store the year
Message DB  'Today''s date is: ', '$' 


        .CODE
		EXTRN PutDec: near
		EXTRN GetDec: near
		
Hello   PROC

        _Begin ;starting our program
		_PutStr Message ;display the Message "Today's date is:" 
		_GetDate
		
		mov ah, 0 ;setting ah resgister to 0
		mov al, dl ;mov the value in dl to al register 
		mov D, ax 
		
		mov ah, 0 ;setting ah resgister to 0
		mov al,dh ;mov the value in dl to al register 
		mov M, ax
		call PutDec ;display out month
		_Putch '/' ;to display the '/' character
		mov ax, D
		call PutDec ;display out day
		_Putch '/' ;to display the '/' character
		mov ax, cx ;mov the value in cx to ax register
		mov Y, ax
		call PutDec ;display out year
        
		
		_Exit 0
Hello 	ENDP
		END Hello ;start the execution

TITLE Project #5     (Program#5.asm)
;__Header Block____________________________________________________________________________________________
;- Author:                             Brandon Schultz
;-- Date:                              11.16.21
;--- OSU email address:                schulbra@oregonstate.edu
;---- Course Section:                  CS 271 400 F2021
;----- References:
;__________________________________________________________________________________________________________
INCLUDE Irvine32.inc
;_____________________________________________________________________________________________																									 ;
; Constant vals:                                                                                                                                 
;  -Array Size = 200
;  -200 elements contained by arr will in the range [LO= 15 HI = 50].
;______________________________________________________________________________________________
ARRAYSIZE =		200		;  sets arr size initially  to always = 200
LO =			15		;  sets low range val of any one of 200 possible arr vals
HI =			50		;  sets high range val for any one of the 200 possible arr values
COUNT_LIST_SIZE =	20 		; 
;____________________________________________________________________________
; Offsets utilized by procedures to access stack parameters
;  -Additional informaiton is provided in comments for individual PROCs below.
;_____________________________________________________________________________
para_1 EQU [EBP + 8]
para_2 EQU [EBP + 12]
para_3 EQU [EBP + 16]
para_4 EQU [EBP + 20]
para_5 EQU [EBP + 24]
para_6 EQU [EBP + 28]
para_7 EQU [EBP + 32]
para_8 EQU [EBP + 36]
para_9 EQU [EBP + 40]
;para_10 EQU [EBP + 44]
;_________________________
; Variable definitions:
;_________________________
.data				    	
	displayboardTOP					BYTE	" ______________________________________________________________________________     ", 0;
	displayName				      	BYTE	"|  -Author:     Brandon Schultz                                                |    ", 0;
	displayProgram		            BYTE	"|  -Assignment: Project 5 - Arrays, Addressing, and Stack-Passed Parameters    |    ", 0;
	displayECPrompt1				BYTE	"|  **EC #1: Display the numbers ordered by column instead of by row.           |    ", 0;
	displayboardBott				BYTE	"\______________________________________________________________________________/    ", 0;
	displayboardBottf				BYTE	"\______________________________________________________________________/    ", 0;
	goodbyePrompt					BYTE    "|\\\\\\\\\\\\\\\\\\\\\\\\\\  Play on playa!  //////////////////////////|    ", 0;
	displaybardAlt					BYTE	"|______________________________________________________________________|    ", 0;
	displayCountPrompt				BYTE	 "Frequency of generated valuess in range of [LO= 15 HI = 50]:                       ", 0;
	displayCountPrompt_Alt			BYTE	 "15 -  -  -  -  -  -   -  -  -  -  -  -  -  -  -  -  -  -  50                       ", 0;
	displayCountPromptLim 			BYTE	 "**Note that - represents any val 16-49 shown in the above arrays.             ", 0; 
	displaybardAltB					BYTE	"|__________________________________________________________________|               ", 0;
	;displayCountPrompt_AltL		BYTE	 "|  |  |  |  |  |  |  |  |  |  |  |  |  |   |  |  |  |  |  |                        ", 0;
	playAgainPrompt	  			    BYTE	" 1 + [ENTER] = End Program      ||     2 + [ENTER] = More Arrays     ", 0;
;	blankSpaceLine		        	BYTE	"                                                                                   "   , 0;
	directionsPrompt				BYTE	 " Generates and displays 200 random numbers in range of [LO= 15 HI = 50] as an        " , 0;
	directionsPromptA				BYTE	 " unsorted and sorted list (ascending), finds and displays lists median, then counts  " , 0; 
	directionsPromptB				BYTE	 " and displays the number of times each value appears in the generated set of values: " , 0;
	displaybardAltIn				BYTE	"|___________________________________________________________________________________|", 0;
	medianStringPrompt  			BYTE	 "List Median Value: ", 0;
	unsortPrompt					BYTE	 "Your unsorted random numbers: "                                                     , 0;
	afterSortPrompt					BYTE     "Your sorted random numbers:   "                                                     , 0;                
;	blankSpace		              	BYTE	  "   "                                                                               , 0;
	randArray						DWORD	  ARRAYSIZE DUP(?)
	numCounts						DWORD	  20 DUP(?)
	endVal							DWORD	  1
.code
main PROC
	;-------------------------------------------------------------------------------------|
	; Adds to stack the following:
	; -Irvine's random funciton in order to create 200 elements in range [LO= 15 HI = 50].
	; - // Generates ARRAYSIZE random integers in the range from LO to HI.
	; - Boarder for top/bottom of assignment info template.
	; -  Program Title, name, EC status and programs directions.
	;-----------------------------------------------------------
	; Generates random seed
	call		Randomize 
	; Programs Introductory prompts and directions/boarders
	push		offset displaybardAltIn
	push		OFFSET directionsPromptB
	push		OFFSET directionsPromptA
	push		OFFSET directionsPrompt
	push		OFFSET displayboardBott
	push		OFFSET displayECPrompt1
	push		OFFSET displayProgram
	push		OFFSET displayName
	push		OFFSET displayboardTOP
	call		introduction
 ;_______________________________________________________
 ; Main loop for calling  procedures used to run program.
 ;_______________________________________________________
 programLoop:

	push		ARRAYSIZE					; _______________________________________________________________________________			 
	push		HI							;  - Procedures used to generate and push to stack an arr filled with ints in 	
	push		LO							;  the range [LO= 15 HI = 50].
	push		OFFSET randArray			; _______________________________________________________________________________
	call		fillArray	        		; Assigns to and fills 200 cap arr with elements in range [LO= 15 HI = 50]
											
	push		OFFSET unsortPrompt			; Displays prompt regarding unsorted arr benath text string.
	; Displays the list of integers before sorting, 20 numbers per line with one space between each value.
	push		ARRAYSIZE
	push		OFFSET randArray
	call		displayList					; Displays unorgainized array of 200 elements + contains methods for assigning 20 items/row, 
											; with 1 space between each element. Also used in display of sorted and counts randArray below.
	; Methods for sorting non-
	; ordered arr:
	push		ARRAYSIZE                   
	push		OFFSET randArray
	call		sortList 					 ; Sorts randArray contents by ascending value.
	push		OFFSET medianStringPrompt	 ; Displays prompt regarding median val displayed to the right.
	push		ARRAYSIZE
	push		OFFSET randArray
	call		displayMedian				 ; Finds + Displays median of now sorted list.
	push		OFFSET afterSortPrompt		 ; Prompt describing displayed sorted list disaplyed below it.
	push		ARRAYSIZE
	push		OFFSET randArray
	call		displayList					 ; Displays list elements in ascending order.
	push		LO
	push		OFFSET numCounts
	push		ARRAYSIZE
	push		OFFSET randArray
	call		countList
;   PUSH        OFFSET displaybardAlt
	push		OFFSET displayCountPrompt	; Prompt describing to user frequency of randArray elements
;	PUSH        OFFSET	displayCountPromptLim
	push		COUNT_LIST_SIZE
	push		OFFSET numCounts
	call		displayList
;	push		offset displayCountPrompt_AltL
	push		offset displayCountPrompt_Alt
	PUSH		OFFSET displayCountPromptLim
	push		offset displaybardAlt
	push		OFFSET playAgainPrompt		; DisplAYS prompt allowing user to quit or generate additional arrsay.
	call		endProgramProcedure			; Used to determine if program should quit or generate another randArray based on user input
	mov			endVal, EAX
	cmp			endVal, 1
	jne			programLoop
	PUSH        OFFSET displaybardAlt
	push		OFFSET goodbyePrompt
	push		OFFSET displayboardBottf
	call		goodbye
	exit							
main ENDP
;_________________________________
; Prints intro text/prompts.
;  para_1 OFFSET displayboardTOP
;  para_2 OFFSET displayName
;  para_3 OFFSET displayProgram
;  para_4 OFFSET displayECPrompt1
;  para_5 OFFSET displayboardBott
;  para_6 OFFSET directionsPrompt
;  para_7 OFFSET directionsPromptA
;  para_7 OFFSET directionsPromptB
;  para_8 offset displaybardAltIn
;  -EDX register changed.
;_________________________________
introduction PROC
	push		EBP
	mov			EBP, ESP
	call		CrLf
	mov			EDX, para_1
	call		WriteString
	call		CrLf
	mov			EDX, para_2
	call		WriteString
	call		CrLf
	mov			EDX, para_3
	call		WriteString
	call		CrLf
	mov			EDX, para_4
	call		WriteString
	call		CrLf
	mov			EDX, para_5
	call		WriteString
	call		CrLf
	call		CrLf

	mov			EDX, para_6
	call		WriteString
	call		CrLf

	mov			EDX, para_7
	call		WriteString
	call		CrLf

	mov			EDX, para_8
	call		WriteString
	call		CrLf


	mov			EDX, para_9
	call		WriteString
	call		CrLf

	;mov		EDX, para_10
	;call		WriteString
	;call		CrLf

	pop			EBP
	ret			9 * TYPE para_1
introduction ENDP
;_______________________________________________________________________________
; PROC that assigns values in the range [LO= 15 HI = 50] to arrays elements.
;  para_1 	OFFSET 	randArray
;  para_2 	OFFSET 	LO
;  para_3 	OFFSET 	HI
;  para_4 	OFFSET 	ARRAYSIZE
;  para_5 	OFFSET 	-
;  para_6 	OFFSET 	-
;  -ECX, EAX, ESI registers are altered
;________________________________________________________________________________
fillArray PROC
	push		EBP
	mov			EBP,ESP
	mov			ESI, para_1
	mov			ECX, para_4
randArrayFill:
	mov			EAX, para_3
	sub			EAX, para_2
	inc			EAX
	; generates each random number after randomize has generated a random seed.
	call		RandomRange
	add			EAX, para_2
	mov			[ESI], EAX
	add			ESI, TYPE DWORD
	loop		randArrayFill
	pop			EBP
	ret			4 * TYPE para_1
fillArray ENDP
;|_________________________________________________________________________________________________________|
; - PROC used to print an arrays of 200 elements, containing 20 elements per row with one space between each
;   element to the user 
;  para_1 	OFFSET 		randArray
;  para_2 	OFFSET 		ARRAYSIZE
;  para_3 	OFFSET 		unsortPrompt, afterSortPrompt, displayCountPrompt
;  para_4 	OFFSET	 	-
;  para_5 	OFFSET	 	- 
;  para_6 	OFFSET	 	-
;  para_7 	OFFSET 		-
;  -ECX, EAX, EBX, EDX, ESI registers are altered.
;||||_____________________________________________________________________________________________________/
displayList PROC
	push		EBP
	mov			EBP, ESP
	mov			ESI, para_1
	mov			ECX, para_2
	mov			EBX, 1
	call		CrLf
	mov			EDX, para_3			; Displays organized, sorted randArray and count prompts.
	call		WriteString
	call		CrLf
	;mov		EDX, para_4
	;call		WriteString
	;call		CrLf
 showRow:							; Loop for displaying first row of elelments. Ends when EBX =20
	mov			EAX, [ESI]			; and a new row is added after jumping to newRowIndicator.
	call		WriteDec
	mov			al, ' '
	call		WriteChar
	call		WriteChar
	cmp			EBX, 20
	je			newRowIndicator
	inc			EBX 
 showRowB:							 ; Counter used in the display of addtional rows
	add			ESI, TYPE DWORD
	loop		showRow
	jmp			endRowDisplay
 newRowIndicator:
	call		CrLf
	mov			EBX, 1
	jmp			showRowB
 endRowDisplay:						 ; randArray has been filled, quit procedure.
	call		CrLf
	pop			EBP
	ret			3 * TYPE para_1

displayList ENDP

;|___________________________________________________________________________________________|
; Sorts randArray contents in ascending order.
;  para_1 	OFFSET 	randArray
;  para_2 	OFFSET 	ARRAYSIZE
;  para_3 	OFFSET 	-
;  para_4 	OFFSET 	-
;  para_5 	OFFSET 	- 
;  para_6 	OFFSET 	-
;  para_7 	OFFSET 	-
;  -ECX, EAX, and ESI registers are altered.
;|___________________________________________________________________________________________|
sortList PROC
	push		EBP
	mov			EBP, ESP
	mov			ECX, para_2
	dec			ECX
 outerLoopStart:					 ; Loop used as temp randArray for exchanging of elements on stack.
	push		ECX
	mov			ESI, para_1
 exchangeLoopInner:					 ; Compares and exchanges elements.
	mov			EAX, [ESI]
	cmp			[ESI + TYPE DWORD], EAX
	jg			incrementEle
	add			ESI, TYPE DWORD
	push		ESI
	sub			ESI, TYPE DWORD
	push		ESI
	call		exchangeElements 
 incrementEle:						 ; Increments loops and ESI registers. 
	add			ESI, TYPE DWORD
	loop		exchangeLoopInner
	pop			ECX
	loop		outerLoopStart
	pop			EBP
	ret			2 * TYPE para_1
sortList ENDP
;_________________________________________________________________
; Sorts arr contents in ascending order.
;  para_1 OFFSET median val #1 //EAX
;  para_2 OFFSET median val #2 //EBX
;  para_3 OFFSET -
;  para_4 OFFSET -
;  para_5 OFFSET - 
;  para_6 OFFSET -
;  -EAX,EBX,EDX registers are altered.
;_________________________________________________________________
exchangeElements  PROC
	push		EBP
	mov			EBP, ESP
	pushad
	mov			EAX, [para_1]
	mov			EBX, [para_2]
	mov			EDX, [EAX]
	mov			EAX, [EBX]
	mov			EBX, EDX
	mov			[ESI], EAX
	mov			[ESI + TYPE DWORD], EBX
	popad
	pop			EBP
	ret			2 * TYPE DWORD
exchangeElements  ENDP
;_____________________________________________________________________________
;  ; Calculates median value after index of middle vals is found
;  para_1 OFFSET randArray
;  para_2 OFFSET ARRAYSIZE
;  para_3 OFFSET medianStringPrompt
;  para_4 OFFSET -
;  para_5 OFFSET - 
;  para_6 OFFSET -
;  -EAX, EBX, EDX registers are altered.
;_____________________________________________________________________________
displayMedian PROC
	push		EBP
	mov			EBP, ESP
	mov			EDX, para_3
	call		WriteString
	mov			EDX, 0
	mov			EAX, [para_2]
	mov			EBX, 2
	div			EBX
	cmp			EDX, 0
 ;Calculates median value after index of middle values is obtained.
 medianCaulc:
	mov			EAX, para_1
	add			EAX, 99 * TYPE DWORD
	mov			EBX, [EAX]
	add			EAX, TYPE DWORD
	mov			EAX, [EAX]
	add			EAX, EBX
	mov			EBX, 2
	div			EBX
	add			EAX, EDX
	call		WriteDec
	jmp			endMedProcedure
 ; Ends displayMedian proc
 endMedProcedure:
	pop			EBP
	ret			3 * TYPE para_1
displayMedian ENDP
;__________________________________________________________________________________________________________________
; ; Counts and displays to user the frequency of each number in range [LO= 15 HI = 50] in randomly generated array.
;  para_1 OFFSET randArray
;  para_2 OFFSET ARRAYSIZE
;  para_3 OFFSET numCounts
;  para_4 OFFSET LO
;  para_5 OFFSET - 
;  para_6 OFFSET -
;  -EAX,EBX,ECX,ESI,edi and EDX registers are altered.
;__________________________________________________________________________________________________________________
countList PROC
	push		EBP
	mov			EBP, ESP
	mov			EBX, para_4
	mov			edi, [para_3]
 findNumbersStartofList:                ; Scans array for values in range of 15-50, starting at lowest value = 15.
	mov			ESI, [para_1]
	mov			ECX, para_2
	mov			EAX, 0
 countNumbersCurr:                      ; Scans array for current value that will be added to count list.                                                                  
	cmp			EBX, [ESI]
	je			countNumbersCurrMatch   ; If a number is found program jumps to countNumbersCurrMatch and the
	add			ESI, TYPE DWORD
	loop		countNumbersCurr        ; arr is then searched for that value which is now being totaled.
	jmp			findNumbersNextInList
 countNumbersCurrMatch:                 ; Counts occurence of each value in arr until the 200                                    
	inc			EAX
	add			ESI, TYPE DWORD
	loop		countNumbersCurr
	jmp			findNumbersNextInList   ; items in the arr have been compared against the curr value.
 findNumbersNextInList:		
	mov			[edi], EAX              ; Used to add up occurence of each value to count list
	add			edi, TYPE DWORD
	inc			EBX
	cmp			EBX, 51                 ; Used to increment previously scanned for value through 50
	je			findNumbersEndofList    ; All ppossible values to match up and count have been totaled, end proc.
	jmp			findNumbersStartofList  ; Values between 16-50 exist that have yet to be totaled, keep going.
 findNumbersEndofList:
	pop			EBP
	ret			4 * TYPE para_1
countList ENDP
;_________________________________________________________________________________________________________
;	- PROC for ending/restarting program and adds style/ disclaimer and dashe prompts to listed count info
;  para_1 	OFFSET 	playAgainPrompt
;  para_2 	OFFSET 	displaybardAlt
;  para_3 	OFFSET 	displayCountPromptLim
;  para_4 	OFFSET	displayCountPrompt_Alt
;  para_5 	OFFSET - 
;  para_6 	OFFSET -
;  - EDX, EBX altered.
;_________________________________________________________________________________________________________
endProgramProcedure PROC
	push		EBP
	mov			EBP, ESP
	;mov		EDX, para_5
	;call		WriteString
	;call		CrLf
	mov			EDX, para_4
	call		WriteString
	call		CrLf
	mov			EDX, para_3
	call		WriteString
	call		CrLf
	mov			EDX, para_2
	call		WriteString
	call		CrLf
	mov			EDX, para_1
	call		WriteString
	call		ReadInt
	pop			EBP
	ret			4 * TYPE para_1
endProgramProcedure ENDP

;_________________________________________________________________________________________________________
; Goodbye message after ending program.
;	para_1 	OFFSET  displaybardAlt
;	para_2 	OFFSET  goodbyePrompt
;	para_3	OFFSET  displayboardBottf
;_________________________________________________________________________________________________________
goodbye PROC															
	call		CrLf
	push		EBP
	mov			EBP, ESP
	;mov		EDX, para_4
	;call		WriteString
	;call		CrLf
	mov			EDX, para_3
	call		WriteString
	call		CrLf
	mov			EDX, para_2
	call		WriteString
	call		CrLf
	mov			EDX, para_1
	call		WriteString
	call		CrLf
	pop			EBP
	ret			3 * TYPE para_1	
goodbye ENDP

END main

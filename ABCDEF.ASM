Progr           segment
                assume  cs:Progr, ds:dane, ss:stosik
;-------------------makra------------------------------
Clear MACRO VidAddress, ClearAtom, BufLength
		LES DI,DWORD PTR VidAddress 	;wpisz adres do ES:DI
		MOV AX,ClearAtom 		;do AX słowo wpisywane do bufora	
		MOV CX,BufLength		;do CX wielkosc bufora w bajtach
		SHR CX,1			;która podzielona przez 2 daje licznik
		REP STOSW			;wypełniamy bufor
ENDM

TRYB_TEKSTOWY MACRO VidAddress,wysokosc
    LOCAL narysuj_poziom
    LOCAL powt
	
	CMP wysokosc, 0Ah
	JL spr_min_tekst
	MOV wysokosc, 0Ah
spr_min_tekst:
	CMP wysokosc, 03h
	JG dalej_tekst
	MOV wysokosc, 03h
dalej_tekst:
	LES DI, DWORD PTR VidAddress ;wpisz adres do ES:DI
	ADD DI, iksWsp
	
	MOV AH, 07          ;normalny tekst - atrybut 7
	MOV AL,'X'
	MOV BX, 0
	MOV CX, -1
	
narysuj_poziom:
    ADD CX, 2
        
	PUSH DI
	PUSH CX
    REP STOSW
    POP CX
	POP DI
	
    INC BX
    ADD DI, 160
	SUB DI, 2 ; jedna pozycja do tyłu w stosunku do pierwszego iksa z ostatniego ciągu iksów
    CMP BX, wysokosc
    JNZ narysuj_poziom
	
	;pień
	LES DI,DWORD PTR VidAddress 	; reset pos to the middle
	ADD DI, iksWsp
	
	;oblicz pozycję pierwszego iksa
	MOV AL, 160
	MOV CX, wysokosc
	MUL CL
	;ADD DI, wysokosc*160
	ADD DI, AX
	MOV AL,'X'
	MOV AH, 07
	
	
	MOV CX, wysokosc
	powt:
		STOSW
		ADD DI, 160
		SUB DI, 2		; korekta stosw
	LOOP powt
ENDM

TRYB_GRAFICZNY MACRO rozm
	LOCAL dalej
	local spr_min
	CMP rozm, 02Eh
	JL spr_min
	MOV rozm, 02Eh
spr_min:
	CMP rozm, 04h
	JG dalej
	MOV rozm, 04h
dalej:
	MOV AX, rozm
	MOV BL, 2H
	MUL BL
	MOV BX, AX
	
	mov ax, 13h
	int 10h			; uruchom tryb graficzny 13h (320x200 256 kolorów)
	
	mov ax, 0a000h		;0A000:0000 - pierwszy piksel (bajt)
	mov es, ax
	
	graf_ustaw_poczatkowa_pozycje rozm
	graf_rysuj_ukosna 1

	sub di, rozm
	graf_rysuj_pozioma_krotka rozm
	sub di, rozm
	
	graf_rysuj_pozioma_dluga
	
	sub di, rozm
	graf_rysuj_pozioma_krotka rozm
	sub di, rozm
	
	; druga strona
	graf_ustaw_poczatkowa_pozycje rozm
	graf_rysuj_ukosna -1
	graf_rysuj_pozioma_krotka rozm
	graf_rysuj_pozioma_dluga
	graf_rysuj_pozioma_krotka rozm

ENDM

graf_rysuj_ukosna MACRO przesuniecie
	LOCAL UKOSNA
	mov	cx, BX
	UKOSNA:			
		mov byte ptr es:[di],4	
		add	di, 320
		add di, przesuniecie
	loop UKOSNA
ENDM

graf_ustaw_poczatkowa_pozycje MACRO rozm
	mov di, 60*320+150	;wiersz*320 + kolumna
	MOV AX, rozm		;----
	MOV CX, 320
	MUL CX
	sub di, ax			;---- przesuń o 'rozm' wierszy w górę
	
ENDM	

graf_rysuj_pozioma_krotka MACRO rozm
	mov cx, rozm
	mov al, 4
	rep stosb
ENDM

graf_rysuj_pozioma_dluga MACRO
	LOCAL POZIOMA
	mov	cx, BX
	POZIOMA:
		mov byte ptr es:[di],4
		add	di, 320
	loop POZIOMA
ENDM


;---------------------------program-------------------------------
start:          mov     ax,dane
                mov     ds,ax
                mov     ax,stosik
                mov     ss,ax
                mov     sp,offset szczyt

	inf_loop:
		Clear VidOrigin,0720H,4000	
	inf_loop2:
		LEA DX, WybierzTryb
		MOV AH, 09H
		INT 21H				
		xor ah, ah		
		int 16h			;oczekiwanie na naciśnięcie klawisza
		MOV wybor, al
	
	wyswietl_powtorz:	
		CMP wybor, '1'
		JZ loop_graf_przedluzenie
		CMP wybor, '2'
		JZ loop_text
		CMP wybor, '3'
		JZ koniec_przedluzenie
		JMP blad_wybor
	
	loop_graf_przedluzenie:
		JMP loop_graf
		
	koniec_przedluzenie:
		JMP koniec
	
	blad_wybor:
		LEA DX, BladTryb
		MOV AH, 09H
		INT 21H
		JMP inf_loop2

	loop_text:
		Clear VidOrigin,0720H,4000
		TRYB_TEKSTOWY VidOrigin, rozmiar
		JMP przycisk
		
	loop_graf:	
		Clear VidOrigin,0720H,4000
		TRYB_GRAFICZNY rozmiar
	
	przycisk:
		xor ah, ah		;oczekiwanie na naciśnięcie klawisza
		int 16h
		cmp al, 'a'
		JZ zmniejsz
		cmp al, 'd'
		JZ zwieksz
		cmp al, 'z'
		JZ koniec
		JMP przycisk
	
	zmniejsz:
		sub rozmiar,1
		JMP wyswietl_powtorz
    
	zwieksz:
		add rozmiar,1
		JMP wyswietl_powtorz
		
	koniec:	
			mov     ah,4ch
	        mov	    al,0
	        int	    21h
Progr           ends

dane            segment
		VidOrigin DD 0B8000000H
		iksWsp dw 5*160+80
		rozmiar dw 0AH
		wybor db '1'
		WybierzTryb db "Wybierz tryb: 1) Graficzny 2) Tekstowy 3) Wyjscie", 10, 13, "$"
		BladTryb db "Wybrano bledny znak.", 10, 13, "$"
dane            ends

stosik          segment stack
                dw    100h dup(0)
szczyt          Label word
stosik          ends

end start
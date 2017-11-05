ORG 800H  
CHOICE	RST 2 			 ;wczytanie znaku z klawiatury do akumulatora
	CPI '1'  		  	 ;porównanie wartości z akumulatorem, mnozenie
	CZ OPTION1  		 ;jeśli wynik=0 to zapisz aktualny adres i skocz do wskazanego adresu (option1)
	CPI '2'  			 ;porównanie wartości z akumulatorem, dzielenie
	CZ OPTION2  		 ;jeśli wynik=0 to zapisz aktualny adres i skocz do wskazanego adresu (option2)
	JMP CHOICE  		 ;skok bezwarunkowy do choice
OPTION1	MVI A,13		 ;do rejestru A przypisujemy wartość 13 
	RST 1 				 ;wydruk znaku z akumulatora na monitor
	RST 5  				 ;wczytanie 4 znaków hex do rejestrów DE
	MVI H,0  			 ;Wyzerowanie rejestru H
	MVI L,0  			 ;Wyzerowanie rejestru L
	MOV B,D				 ;skopiowanie zawartosci rejestru D do rejestru B
	MOV C,E 			 ;skopiowanie zawartosci rejestru E do rejestru C
	MVI A,'*'			 ;do rejestru A przypisujemy wartość * (hex, ascii)
	RST 1  				 ;wydruk znaku z akumulatora na monitor
	RST 5  				 ;wczytanie 4 znaków hex do rejestrów DE
	MVI A,0  			 ;do rejestru A przypisujemy wartość 0
	CMP E  				 ;porównanie akumulatora z rejestrem E + ustawienie flag
	JNZ MULTIPLICATION   ;jeśli wynik nie będzie równy 0 to skok do wskazanej etykiety
	CMP D  				 ;porównanie akumulatora z rejestrem D + ustawienie flag
	JZ END1  			 ;jeśli wynik=0 to skok do END1
MULTIPLICATION	DAD B  	 ;do zawartości rejestru HL przypisujemy sumę rejestrów HL i BC
	DCX D  				 ;dekrementacja zawartości rejestru DE 
	MVI A,0  			 ;do rejestru A przypisujemy wartość 0
	CMP E  				 ;porównanie akumulatora z rejestrem E + ustawienie flag
	JNZ MULTIPLICATION   ;jeśli wynik nie będzie równy 0 to skok do wskazanej etykiety
	CMP D  				 ;porównanie akumulatora z rejestrem D + ustawienie flag
	JNZ MULTIPLICATION 	 ;jeśli wynik nie będzie równy 0 to skok do wskazanej etykiety
END1	MVI A,'='		 ;do rejestru A przypisujemy wartość = (hex, ascii)
	RST 1  				 ;wydruk znaku z akumulatora na monitor
	MOV A,H  			 ;skopiowanie zawartosci rejestru H do rejestru A
	RST 4  				 ;wydruk 2 znaków heksadecymalnych z akumulatora
	MOV A,L  			 ;skopiowanie zawartosci rejestru L do rejestru A
	RST 4  				 ;wydruk 2 znaków heksadecymalnych z akumulatora
	RET  				 ;powrót bezwarunkowy, 1 stos niżej
OPTION2	MVI A,13		 ;do rejestru A przypisujemy wartość 13 
	RST 1 				 ;wydruk znaku z akumulatora na monitor
	MVI H,0  			 ;Wyzerowanie rejestru H
	MVI L,0  			 ;Wyzerowanie rejestru L
	RST 5  				 ;wczytanie 4 znaków hex do rejestrów DE
	MOV B,D				 ;skopiowanie zawartosci rejestru D do rejestru B
	MOV C,E 			 ;skopiowanie zawartosci rejestru E do rejestru C
	MVI A,'/'			 ;do rejestru A przypisujemy wartość / (hex, ascii)
	RST 1  				 ;wydruk znaku z akumulatora na monitor
	RST 5  				 ;wczytanie 4 znaków hex do rejestrów DE
	MVI A,0  			 ;do rejestru A przypisujemy wartość 0 (hex, ascii)
	CMP E  				 ;porównanie akumulatora z rejestrem E + ustawienie flag
	JNZ DIVISION1		 ;jeśli wynik nie będzie równy 0 to skok do wskazanej etykiety
	CMP D  				 ;porównanie akumulatora z rejestrem D + ustawienie flag
	JZ END2 			 ;jeśli wynik=0 to skok do END1
DIVISION1	CMC			 ;Jeśli jest CF = 1 to zmiana na 0
DIVISION2  
	MOV A,C				 ;skopiowanie zawartosci rejestru C do rejestru 
	SBB E				 ;akumulator = akumulator - (przeniesienie + rejestr E)
	MOV C,A				 ;skopiowanie zawartosci rejestru A do rejestru C
	MOV A,B				 ;skopiowanie zawartosci rejestru B do rejestru A
	SBB D    		     ;akumulator = akumulator - (przeniesienie + rejestr D)
	MOV B,A
	JC END2				 ;Jeśli rejestr CY (carry) będzie równy 1 to przejdź do wskazanej etykiety
	INX H 				 ;inkrementacja zawartości rejestru HL
	JMP DIVISION2		 ;skok bezwarunkowy do DIVISION
END2	MVI A,'='		 ;do rejestru A przypisujemy wartość = (hex, ascii)
	RST 1  				 ;wydruk znaku z akumulatora na monitor
	MOV A,H  			 ;skopiowanie zawartosci rejestru H do rejestru A
	RST 4  				 ;wydruk 2 znaków heksadecymalnych z akumulatora
	MOV A,L  			 ;skopiowanie zawartosci rejestru L do rejestru A
	RST 4  				 ;wydruk 2 znaków heksadecymalnych z akumulatora
	RET 				 ;powrót bezwarunkowy, 1 stos niżej
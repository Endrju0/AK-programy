;Dzielenie 8-bit liczby
ORG 800H  
	RST 5  			;wczytanie 4 znaków hex do rejestrów DE
	MOV A,D  		;skopiowanie zawartosci rejestru D do rejestru A(akumulatora)
	MOV B,E  		;skopiowanie zawartosci rejestru E do rejestru B
	MVI C,0  		;do rejestru C przypisujemy wartość 0
PETLA	SUB B  		;do rejestru A(akumulatora) przypisujemy różnicę rejestrów A-B
		JC KONIEC  	;Jeśli rejestr CY (carry) będzie równy 1 to przejdź do wskazanej etykiety (CY=1 gdy na najstarszym bicie
					;wyniku operacji wystąpiło przeniesienie lub pożyczka)
		INR C  		;inkrementacja rejestru C (C+1)
		JMP PETLA  	;skok do PETLA
KONIEC  MVI A,10  	;do rejestru A przypisujemy wartość 10
	RST 1  			;wydruk znaku z akumulatora na monitor
	MVI A,13  		;do rejestru A przypisujemy wartość 13
	RST 1  			;wydruk znaku z akumulatora na monitor
	MOV A,D  		;skopiowanie zawartosci rejestru D do rejestru A(akumulatora)
	RST 4  			;wydruk 2 znaków heksadecymalnych z akumulatora
	MVI A,'/'  		;do rejestru C przypisujemy wartość hex znaku / (ascii)
	RST 1  			;wydruk znaku z akumulatora na monitor
	MOV A,E  		;skopiowanie zawartosci rejestru E do rejestru A(akumulatora)
	RST 4  			;wydruk 2 znaków heksadecymalnych z akumulatora
	MVI A,'='  		;do rejestru A przypisujemy wartość hex = (ascii)
	RST 1  			;wydruk znaku z akumulatora na monitor
	MOV A,C  		;skopiowanie zawartosci rejestru C do rejestru A(akumulatora)
	RST 4  			;wydruk 2 znaków heksadecymalnych z akumulatora
HLT  

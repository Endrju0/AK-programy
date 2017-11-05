;Dodanie dwóch liczb 16-bitowych
ORG 800H
	RST 5		;wczytanie 4 znaków hex do rejestrów DE
	MOV H,D		;skopiowanie zawartosci rejestru D do rejestru H
	MOV L,E		;skopiowanie zawartosci rejestru E do rejestru L
	MVI A,'+'	;do akumulatora przypisujemy wartość + (hex, ascii)
	RST 1		;wydruk znaku z akumulatora na monitor
	RST 5		;wczytanie 4 znaków hex do rejestrów DE
	MVI A,'='	;do akumulatora przypisujemy wartość = (hex, ascii)
	RST 1		;wydruk znaku z akumulatora na monitor
	DAD D		;do zawartości rejestru HL przypisujemy sumę rejestrów HL i DE
	MOV A,H		;skopiowanie zawartosci rejestru H do rejestru A(akumulatora)
	RST 4		;wydruk 2 znaków heksadecymalnych z akumulatora
	MOV A,L		;skopiowanie zawartosci rejestru L do rejestru A(akumulatora)
	RST 4		;wydruk 2 znaków heksadecymalnych z akumulatora
HLT
;RST5 - wczytanie 4 znaków hex do rejestrów DE
ORG 800H
	RST 5			;wczytanie 4 znaków hex do rejestrów DE
	MOV A,D			;skopiowanie zawartosci rejestru D do rejestru A (akumulatora)
	ADD E			;Przypisanie do rejestru A(akumulatora) sumy rejestrów A i E
	LXI H,TEKST		;przypisanie do rejestrów HL etykiety TEKST
	RST 3			;wydruk łańcucha z pamięci od [HL] do "@"
	RST 4			;wydruk 2 znaków heksadecymalnych z akumulatora
HLT
TEKST DB 10,13,'suma = @'
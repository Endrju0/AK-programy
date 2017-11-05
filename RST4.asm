;RST4 - wydruk 2 znaków heksadecymalnych z akumulatora
ORG 800H
	LXI H,TEKST1	;przypisanie do rejestrów HL etykiety TEKST1
	RST 3			;wydruk łańcucha z pamięci od HL do @
	RST 2			;wczytanie znaku z klawiatury do akumulatora
	LXI H,TEKST2	;przypisanie do rejestrów HL etykiety TEKST2
	RST 3			;wydruk łańcucha z pamięci od HL do @
	RST 4			;wydruk 2 znaków heksadecymalnych z akumulatora
HLT
TEKST1 DB 'Wprowadz znak',10,13,'@'
TEKST2 DB 10,13,'heksadecymalnie:@'
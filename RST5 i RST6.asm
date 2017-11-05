;RST5 - wczytanie 4 znaków hex do rejestrów DE
;RST6 - wydruk zawartości rejestrów
ORG 800H
	LXI H,TEKST ;przypisanie do rejestrów HL etykiety TEKST
	RST 5		;wczytanie 4 znaków hex do rejestrów DE
	RST 6		;wydruk zawartości rejestrów
HLT
TEKST 	 DB 'Podaj 4 znaki do rejestrów DE',10,13,'@' 
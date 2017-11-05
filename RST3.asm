;RST3 - wydruk łańcucha z pamięci od [HL] do "@"
ORG 800H
	LXI H,TEKST		;do rejestru HL przypisujemy etykiete TEKST, która jest podana niżej
	RST 3	;wydruk łańcucha z pamięci od HL do @
	HLT
TEKST DB 'Witaj',10,13,'swiecie!!!@'	;wyżej wymieniona etykieta
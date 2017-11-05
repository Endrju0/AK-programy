;dzielnie 2 liczb 2-bit
ORG 800H
	RST 5						;wczytanie 4 znaków hex do rejestrów DE
	MOV A,D						;skopiowanie zawartosci rejestru D do rejestru A(akumulatora)
	MOV B,E						;skopiowanie zawartosci rejestru E do rejestru B
	MVI C,0						;do rejestru C przypisujemy wartość 0
PETLA SUB B						;do rejestru A(akumulatora) przypisujemy różnicę rejestrów A-B
	JC KONIEC					;Jeśli rejestr CY (carry) będzie równy 1 to przejdź do wskazanej etykiety
	INR C						;inkrementacja rejestru C (C+1)
	JMP PETLA					;skok do PETLA
KONIEC MVI A,10					;do rejestru A przypisujemy wartość 10
	RST 1						;wydruk znaku z akumulatora na monitor
	MVI A,13					;do rejestru A przypisujemy wartość 13
	RST 1						;wydruk znaku z akumulatora na monitor
	MOV A,D						;skopiowanie zawartosci rejestru D do rejestru A(akumulatora)
	RST 4						;wydruk 2 znaków heksadecymalnych z akumulatora
	MVI A,'/'					;do rejestru A przypisujemy wartość / (hex, ascii)
	RST 1						;wydruk znaku z akumulatora na monitor
	MOV A,E						;skopiowanie zawartosci rejestru E do rejestru A(akumulatora)
	RST 4						;wydruk 2 znaków heksadecymalnych z akumulatora
	MVI A,'='					;do rejestru A przypisujemy wartość = (hex, ascii)
	RST 1						;wydruk znaku z akumulatora na monitor
	MOV A,C						;skopiowanie zawartosci rejestru C do rejestru A(akumulatora)
	RST 4						;wydruk 2 znaków heksadecymalnych z akumulatora
HLT
	RST 3						;wydruk łańcucha z pamięci od HL do @
	RET							;powrót bezwarunkowy, 1 stos niżej
PROCEDURA_2 LXI H,TEXT_2		;do rejestru HL przypisujemy etykiete TEKST, która jest podana niżej
	RST 3 						;wydruk łańcucha z pamięci od HL do @
HLT
MENU DB 10,13,'Wpisz 1 lub 2 >','@'
TEXT_1 DB 10,13,'Wybrano opcje 1','@'
TEXT_2 DB 10,13,'koniec!!!','@'
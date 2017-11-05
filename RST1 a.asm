;RST1 - wydruk znaku z akumulatora na monitor
ORG 800H  
	MVI A,65	;do akumulatora przypisujemy wartość 65
	RST 1  		;wydruk znaku z akumulatora na monitor
	INR A		;inkrementacja rejestru A (akumulatora)
	RST 1		;wydruk znaku z akumulatora na monitor
	INR A		;inkrementacja rejestru A (akumulatora)
	RST 1		;wydruk znaku z akumulatora na monitor
HLT  

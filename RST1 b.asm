;RST1 - wydruk znaku z akumulatora na monitor
ORG 800H  
		MVI A,65 	 ;do akumulatora przypisujemy wartość 65
ZNAK	RST 1 		 ;wydruk znaku z akumulatora na monitor
		INR A  		 ;inkrementacja rejestru A (akumulatora)
		CPI 91  	 ;Porównaj A (akumulator) ze wskazaną wartością, ustaw flagi
	JNZ ZNAK  		 ;Jeśli wynik nie równa się zero przedź do wskazanego miejsca
HLT  

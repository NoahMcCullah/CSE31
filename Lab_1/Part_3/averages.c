#include <stdio.h>

main(){
	int input = 0;
	int posInputNumber = 0;
	int negInputNumber = 0;
	int posSum =0;
	int negSum = 0;
	int posAve = 0;
	int negAve = 0;
	
	do{
		
		printf("Please enter an integer: ");
		scanf("%d", &input);
		
		if(input > 0){
			posInputNumber++;
			posSum = posSum + input;
		}
		else if(input < 0){
			negInputNumber++;
			negSum = negSum + input;
		}
	}while(input != 0);
	
	posAve = posSum / posInputNumber;
	negAve = negSum / negInputNumber;
	
	printf("Positive average: %d", posAve);
	printf("Negative average: %d", negAve);

	return(0);
}
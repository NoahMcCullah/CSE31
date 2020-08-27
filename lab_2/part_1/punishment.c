#include <stdio.h>
#include <stdlib.h>

main () {

int lineNum;
int typoNum;

printf("Enter the number of lines for the punishment: ");
scanf("%d", &lineNum);

if(lineNum <= 0){
	printf("You entered an incorrect value for the number of lines!");
	exit(0);
}

printf("Enter the line for which we want to make a typo: ");
scanf("%d", &typoNum);

if(typoNum <= 0 | typoNum > lineNum){
	printf("You entered an incorrect value for the number of lines!");
	exit(0);
}

for(int i = 0;i < lineNum;i++){
	if(i == typoNum - 1){
		printf("C programming language is the bet! \n");
		continue;
	}
	printf("C programming language is the best! \n");
}

return (0);
}


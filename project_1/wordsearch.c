#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include<ctype.h>

// Declarations of the two functions you will implement
// Feel free to declare any helper functions
void printPuzzle(char** arr, int n);
void searchPuzzle(char** arr, int n, char** list, int listSize);
void wordFound(char** arr, char** words, int wordSize, int wordNumber, int rowAdd, int colAdd, int typeSearch);

// Main function, DO NOT MODIFY!!!	
int main(int argc, char **argv) {
    int bSize = 15;
	if (argc != 2) {
		fprintf(stderr, "Usage: %s <puzzle file name>\n", argv[0]);
		return 2;
	}
    int i, j;
    FILE *fptr;
    char **block = (char**)malloc(bSize * sizeof(char*));
	char **words = (char**)malloc(50 * sizeof(char*));

    // Open file for reading puzzle
    fptr = fopen(argv[1], "r");
    if (fptr == NULL) {
        printf("Cannot Open Puzzle File!\n");
        return 0;
    }

	// Read puzzle block into 2D arrays
    for(i=0; i<bSize; i++){
        *(block+i) = (char*)malloc(bSize * sizeof(char));

        fscanf(fptr, "%c %c %c %c %c %c %c %c %c %c %c %c %c %c %c\n", *(block+i), *(block+i)+1, *(block+i)+2, *(block+i)+3, *(block+i)+4, *(block+i)+5, *(block+i)+6, *(block+i)+7, *(block+i)+8, *(block+i)+9, *(block+i)+10, *(block+i)+11, *(block+i)+12, *(block+i)+13, *(block+i)+14 );
    }
	fclose(fptr);

	// Open file for reading word list
	fptr = fopen("states.txt", "r");
	if (fptr == NULL) {
        printf("Cannot Open Words File!\n");
        return 0;
    }
	
	// Save words into arrays
	for(i=0; i<50; i++){
		*(words+i) = (char*)malloc(20 * sizeof(char));
		fgets(*(words+i), 20, fptr);		
	}
	
	// Remove newline characters from each word (except for the last word)
	for(i=0; i<49; i++){
		*(*(words+i) + strlen(*(words+i))-1) = '\0';	
	}
	
	
	// Print out word list
	printf("Printing list of words:\n");
	for(i=0; i<50; i++){
		printf("%s\n", *(words + i));		
	}
	printf("\n");
	
	
	// Print out original puzzle grid
    printf("Printing puzzle before search:\n");
    printPuzzle(block, bSize);
	printf("\n");
	
	// Call searchPuzzle to find all words in the puzzle
	searchPuzzle(block, bSize, words, 50);
	printf("\n");
	
	// Print out final puzzle grid with found words in lower case
    printf("Printing puzzle after search:\n");
    printPuzzle(block, bSize);
	printf("\n");
	
    return 0;
}

void printPuzzle(char** arr, int n){
	// This function will print out the complete puzzle grid (arr). It must produce the output in the SAME format as the samples in the instructions.
	// Your implementation here
	for(int i = 0; i < n; i++){
		printf("%c %c %c %c %c %c %c %c %c %c %c %c %c %c %c\n", *(*(arr+i)), *(*(arr+i)+1), *(*(arr+i)+2), *(*(arr+i)+3), *(*(arr+i)+4), *(*(arr+i)+5), *(*(arr+i)+6), *(*(arr+i)+7), *(*(arr+i)+8), *(*(arr+i)+9), *(*(arr+i)+10), *(*(arr+i)+11), *(*(arr+i)+12), *(*(arr+i)+13), *(*(arr+i)+14) );
	}
	
}

void searchPuzzle(char** arr, int n, char** list, int listSize){
	// This function checks if arr contains words from list. If a word appears in arr, it will print out that word and then convert that word entry in arr into lower case.
	// Your implementation here
	printf("\nsearchPuzzle\n");
	
	int foundWord = 0;
	int word = 0, col = 0, row = 0, letter = 0;
	int wordSize = 0, type = 0;

	for(word = 0; word < listSize; word++){
		foundWord = 0;
		wordSize = strlen(*(list+word))-1;
		
		for(row = 0; row < n; row++){
			for(col = 0; col < n; col++){
			
				if(*(*(arr+row)+col) == *(*(list+word))){ //searches for first letter of current word
					
					//////////////////////////////////////////////////////////////////////////
					//Left to Right search, type = 1
					if(foundWord != 1){
						for(letter = 0; letter < wordSize; letter++){
							if(col+letter >=0 && col+letter < n){
								if(toupper(*(*(list+word)+letter)) != toupper(*(*(arr+row)+col+letter))){
									break;
								}
							}
							else{
								break;
							}
						}
						if(letter == wordSize){
							foundWord = 1;
							type = 1;
							//printf("%s found at %d, %d with Left to Right\n", *(list+word), row, col);
						}
					}
					//////////////////////////////////////////////////////////////////////////
					//Top to Bottom search, type = 2
					if(foundWord != 1){
						for(letter = 0; letter < wordSize; letter++){
							if(row+letter >=0 && row+letter < n){
								if(toupper(*(*(list+word)+letter)) != toupper(*(*(arr+row+letter)+col))){
									break;
								}
							}
							else{
								break;
							}
						}
						if(letter == wordSize){
							foundWord = 1;
							type = 2;
							//printf("%s found at %d, %d with Top to Bottom\n", *(list+word), col, row);
						}
					}
					///////////////////////////////////////////////////////////////////////////
					//Bottom to Top search, type = 3
					if(foundWord != 1){
						for(letter = 0; letter < wordSize; letter++){
							if(row-letter >=0 && row-letter < n){
								if(toupper(*(*(list+word)+letter)) != toupper(*(*(arr+row-letter)+col))){
									break;
								}
							}
							else{
								break;
							}
						}
						if(letter == wordSize){
							foundWord = 1;
							type = 3;
							//printf("%s found at %d, %d with Bottom to Top\n", *(list+word), col, row);
						}
					}
					////////////////////////////////////////////////////////////////////////////////
					//Diagonal Top to Bottom search, type = 4
					if(foundWord != 1){
						for(letter = 0; letter < wordSize; letter++){
							if(row+letter >= 0 && row+letter < n && col+letter >=0 && col+letter < n){
								if(toupper(*(*(list+word)+letter)) != toupper(*(*(arr+row+letter)+col+letter))){
									break;
								}
							}
							else{
								break;
							}
						}
						if(letter == wordSize){
							foundWord = 1;
							type = 4;
							//printf("%s found at %d, %d with Diagonal Top to Bottom\n", *(list+word), col, row);
						}
					}
					//////////////////////////////////////////////////////////////////////////////
					//Diagonal Bottom to Top search, type = 5
					if(foundWord != 1){
						for(letter = 0; letter < wordSize; letter++){
							if(row-letter >=0 && row-letter < n && col+letter >= 0 && col+letter < n){
								if(toupper(*(*(list+word)+letter)) != toupper(*(*(arr+row-letter)+col+letter))){
									break;
								}
							}
							else{
								break;
							}
						}
						if(letter == wordSize){
							foundWord = 1;
							type = 5;
							//printf("%s found at %d, %d with Diagonal Bottom to Top\n", *(list+word), col, row);
						}
					}
					/////////////////////////////////////////////////////////////////////////////
				}
				if(foundWord == 1){
					goto found;
				}
			}
		}
		if(foundWord == 1){
			found: 
				wordFound(arr, list, wordSize+1, word, row, col, type);
		}
	}
}

void wordFound(char** arr, char** words, int wordSize, int wordNumber, int rowAdd, int colAdd, int typeSearch){
		//print word
		printf("Word found: %s\n", *(words+wordNumber));
		
		//convert to lowercase
		if(typeSearch == 1){ //Left to Right
			for(int i = 0;i<wordSize;i++){
				*(*(arr+rowAdd)+colAdd+i) = tolower(*(*(words+wordNumber)+i));
			}
		}
		else if(typeSearch == 2){ //Top to Bottom
			for(int i = 0;i<wordSize;i++){
				*(*(arr+rowAdd+i)+colAdd) = tolower(*(*(words+wordNumber)+i));
			}
		}
		else if(typeSearch == 3){ //Bottom to Top
			for(int i = 0;i<wordSize;i++){
				*(*(arr+rowAdd-i)+colAdd) = tolower(*(*(words+wordNumber)+i));
			}
		}
		else if(typeSearch == 4){ //Diagonal Top to Bottom
			for(int i = 0;i<wordSize;i++){
				*(*(arr+rowAdd+i)+colAdd+i) = tolower(*(*(words+wordNumber)+i));
			}
		}
		else if(typeSearch == 5){ //Diagonal Bottom to Top
			for(int i = 0;i<wordSize;i++){
				*(*(arr+rowAdd-i)+colAdd+i) = tolower(*(*(words+wordNumber)+i));
			}
		}
		return;
}
lsearch
#include <stdio.h>
#include <malloc.h>

int** matMult(int **a, int **b, int size){
	// (4) Implement your matrix multiplication here. You will need to create a new //matrix to store the product.
	int **temp = (int**)malloc(size * sizeof(int*));
	int i = 0, j = 0;
	
	for(i = 0; i < size; i++){
		*(temp) = (int*)malloc(size * sizeof(int));
	}
	
	for(i = 0; i < size; i++){
		for(j = 0; j < size; j++){
				*(*(temp+i)+j) = *(*(a+i)+j) * *(*(b+i)+j);
		}
	}

	free(temp);
	return(temp);
}

void printArray(int **arr, int n){
	// (2) Implement your printArray function here
	for(int i = 0; i < n; i++){
		for(int j = 0; j < n; j ++){
			printf("%d ", *(*(arr+i)+j));
		}
		printf("\n");
	}
}

int main() {
	int n = 2;
	int **matC;
	int i = 0, j = 0;
	// (1) Define 2 n x n arrays (matrices). 
	int **matA = (int**)malloc(n * sizeof(int*));
	int **matB = (int**)malloc(n * sizeof(int*));
	
	for(i = 0; i < n; i++){
		*(matA+i) = (int*)malloc(n * sizeof(int));
		*(matB+i) = (int*)malloc(n * sizeof(int));
	}

	// (3) Call printArray to print out the 2 arrays here.
	printArray(matA, n);
	printArray(matB, n);
	
	//(5) Call matMult to multiply the 2 arrays here.
	matC = matMult(matA, matB, n);
	
	//(6) Call printArray to print out resulting array here.
	printArray(matC, n);

	free(matA);
	free(matB);
	free(matC);
    return 0;
}
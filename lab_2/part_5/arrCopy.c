#include<stdio.h>
#include<string.h>

void printArr(int *a, int size){
	//Your code here
	printf("printArr: ");
	for(int i =0; i < size; i++){
		printf("%d ", *a + i);
	}
}

int* arrCopy(int *a, int size){
	//Your code here
	int arrTemp[size];
	for(int i = 0; i < size; i++){
		arrTemp[i] = *a + i;
	}
	return (arrTemp);
}

int main(){
    int n;
    int *arr;
    int *arr_copy;
    int i;
    printf("Enter size of array:\n");
    scanf("%d",&n);

    //Dynamically create an int array of n items
	int arr1[n];
	arr = arr1;

    //Ask user to input content of array
	for(int i=0; i < n; i++){
		printf("Enter array content #%d: ", i+1);
		scanf("%d", arr1 + i);
	}
	
/*************** YOU MUST NOT MAKE CHANGES BEYOND THIS LINE! ***********/
	
	//Print original array
    printArr(arr, n);


	//Copy array
    arr_copy = arrCopy(arr, n);

	//Print new array
    printArr(arr_copy, n);

    return 0;
}
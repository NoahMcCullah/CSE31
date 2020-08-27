#include <stdio.h>

int main(int argc, char **argv) {
		int m = 10
		int n = 5
		int add = sum(m, n);
		
		print(add);
}

int sum(int one, int two){
	int res = one + two
	return res;
}
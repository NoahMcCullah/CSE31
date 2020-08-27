#include <stdio.h>

/*
    Read a set of values from the user.
    Store the sum in the sum variable and return the number of values read.
*/
struct ave{
	int values;
	double sum;
};

struct ave read_values(struct ave p) {
  int input =0;
  p.values=0;
  p.sum = 0;
  printf("Enter input values (enter 0 to finish):\n");
  scanf("%d",&input);
  while(input != 0) {
    p.values++;
    p.sum += input;
    scanf("%d",&input);
  }
  return p;
}

int main() {
  struct ave p1;
  p1 = read_values(p1);
  printf("Average: %g\n",p1.sum/p1.values);
  return 0;
}


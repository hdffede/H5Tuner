/***************************************/
/* 
Filename: random_num.c
Generates 10 random numbers

Used to demonstrate LD_PRELOAD 

Compile : gcc random_num.c -o random_num
*/
/***************************************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
 
int main(){
  srand(time(NULL));
  int i = 10;
  while(i--) printf("%d\n",rand()%100);
  return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <pdf_compressor.h>

int main()
{
int number = fetch_number();


printf("Rand %d", number);

return 0;
}

int fetch_number()
{

int c, n
srand(time(0))

n = rand( ) % 100 1;
return n
}
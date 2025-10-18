#include <stdio.h>
#include <stdlib.h>
#include "comm.h"

int main()
{
  printf("Hello World\n");
  system("devmem 0x80010000 32 1; devmem 0x80010000 32 0;");
  return 0;
}

#include <stdio.h>
#include <stdlib.h>

#define SIZE 16
//#define DEBUG

typedef union {
  float f;
  unsigned int i;
}foo;

int main(int argc, char** argv)
{
  int i;
  foo container;

  float input_a[SIZE];
  float input_b[SIZE];
  float output;

  // initialization
  for (i = 0; i < SIZE; i++)
    input_a[i] = (float)rand()/(float)(RAND_MAX);

  for (i = 0; i < SIZE; i++)
    input_b[i] = (float)rand()/(float)(RAND_MAX);

  output = 0.0f;


#ifdef DEBUG
  for (i = 0; i < SIZE; i++)
  {
    output += input_a[SIZE-1-i] * input_b[SIZE-1-i];
    container.f = input_a[SIZE-1-i];
    printf(" (%f %X) ", container.f, container.i);
    container.f = input_b[SIZE-1-i];
    printf(" (%f %X) ", container.f, container.i);
    container.f = output;
    printf("partial_output: (%f %X)\n", container.f, container.i);
  }
#endif

  // V*V = scalar
  for (i = 0; i < SIZE; i++)
    output += input_a[SIZE-1-i] * input_b[SIZE-1-i];

  // shape input txt
  FILE *fd;
  fd = fopen("./input.txt", "w");
  for (i = 0; i < SIZE; i++)
  {
    container.f = input_a[i];
    fprintf(fd, "%X\n", container.i);
  }

  for (i = 0; i < SIZE; i++)
  {
    container.f = input_b[i];
    fprintf(fd, "%X\n", container.i);
  }
  fclose(fd);

  // shape output txt
  fd = fopen("./output.txt", "w");
  container.f = output;
  fprintf(fd, "%X\n", container.i);

  fclose(fd);

  return 0;
}

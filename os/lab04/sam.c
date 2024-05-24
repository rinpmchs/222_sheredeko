#include <stdio.h>
#include <math.h>

void sam(char *arg) {
    int a = 25;
    int b = ceil(sqrt(a));
    printf("sam: you passed %s, and %d x %d = %d\n", arg, b, b, a);
}


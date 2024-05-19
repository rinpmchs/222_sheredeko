#include <stdio.h>

void swap(int& x, int& y) {
    x = x ^ y;
    y = x ^ y;
    x = x ^ y;
}

int main() {
    int x, y;
    printf("Enter x: ");
    scanf("%d", &x);

    printf("Enter y: ");
    scanf("%d", &y);

    swap(x, y);

    printf("x = %d, y = %d\n", x, y);
    return 0;
}

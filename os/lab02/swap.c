#include <stdio.h>

void swap(int& a, int& b) {
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
}

int main() {
    int a, b;
    printf("Enter a:\n");
    scanf("%d", &a);

    printf("Enter b:\n");
    scanf("%d", &b);

    swap(a, b);

    printf("a = %d, b = %d\n", a, b);
    return 0;
}

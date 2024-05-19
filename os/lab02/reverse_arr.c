#include <stdio.h>
#include <stdlib.h>

int main() {
    int N, i;

    printf("Enter N: ");
    scanf("%d", &N);

    int* array = (int*) malloc(sizeof(int) * N);

    printf("Enter %d numbers to an array:\n", N);
    for (i = 0; i < N; i++) {
        scanf("%d", &array[i]);
    }

    for (i = 0; i < N / 2; i++) {
        int temp = array[i];
        array[i] = array[N - i - 1];
        array[N - i - 1] = temp;
    }

    printf("Reversed array:\n");
    for (i = 0; i < N; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");

    free(array);
    return 0;
}

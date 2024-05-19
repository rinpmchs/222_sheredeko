#include <stdio.h>
#include <stdlib.h>

int main() {
    int N, M;

    printf("Enter N: ");
    scanf("%d", &N);
    printf("Enter M: ");
    scanf("%d", &M);

    int** matrix = (int**)malloc(N * sizeof(int*));
    for (int i = 0; i < N; i++) {
        matrix[i] = (int*)malloc(M * sizeof(int));
    }

    printf("Enter the matrix:\n");
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            scanf("%d", &matrix[i][j]);
        }
    }

    int** T_matrix = (int**) malloc(M * sizeof(int*));
    for (int j = 0; j < M; j++) {
        T_matrix[j] = (int*) malloc(N * sizeof(int));
    }

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            T_matrix[j][i] = matrix[i][j];
        }
    }

    printf("Transposed matrix:\n");
    for (int j = 0; j < M; j++) {
        for (int i = 0; i < N; i++) {
            printf("%d ", T_matrix[j][i]);
        }
        printf("\n");
    }

    for (int i = 0; i < N; i++) {
        free(matrix[i]);
    }
    free(matrix);

    for (int j = 0; j < M; j++) {
        free(T_matrix[j]);
    }
    free(T_matrix);

    return 0;
}

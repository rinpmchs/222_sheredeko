#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int value;
    struct Node* next;
} Node;

void append(Node** head, int value) {
    Node* new_node = (Node*) malloc(sizeof(Node));
    Node* last = *head;
    new_node->value = value;
    new_node->next = NULL;

    if (*head == NULL) {
        *head = new_node;
        return;
    }
    while (last->next != NULL) {
        last = last->next;
    }
    last->next = new_node;
}

void reverse(Node** head) {
    Node* prev = NULL;
    Node* cur = *head;
    Node* next = NULL;
    while (cur != NULL) {
        next = cur->next;
        cur->next = prev;
        prev = cur;
        cur = next;
    }
    *head = prev;
}

int main() {
    Node* head = NULL;
    int val;

    printf("Enter the list:\n");
    while (true) {
        scanf("%d", &val);
        if (val == 0) {
            break;
        }
        append(&head, val);
    }

    reverse(&head);

    Node* tmp;
    printf("Reversed List:\n");
    while (head != NULL) {
        printf("%d ", head->value);
        tmp = head;
        head = head->next;
        free(tmp);
    }
    return 0;
}

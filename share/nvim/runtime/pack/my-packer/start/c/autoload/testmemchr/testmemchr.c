#include <stdio.h>
#include <string.h>

int main() {
    int arr[] = {1, 2, 3, 4, 5};
    int n = sizeof(arr) / sizeof(arr[0]);
    int x = 6;

    if (memchr(arr, x, n * sizeof(int)) != NULL) {
        printf("The array contains %d\n", x);
    } else {
        printf("The array does not contain %d\n", x);
    }

    return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void split(char *str, char *buffer[], int *len) {
    char *token;
    int i = 0;

    token = strtok(str, ",");
    while (token != NULL) {
        int c = strtol(token, NULL, 16);
        printf("c: %d\n", c);
        buffer[i++] = token;
        token = strtok(NULL, ",");
    }

    *len = i;
}

int main() {
    char str[] = "0.207591855,0,,0x02";
    char *buffer[10];
    int len;

    split(str, buffer, &len);
    printf("len: %d\n", len);
    for (int i = 0; i < len; i++) {
        printf("%s\n", buffer[i]);
    }

    return 0;
}

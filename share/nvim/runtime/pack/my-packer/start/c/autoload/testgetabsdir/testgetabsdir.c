#include <stdio.h>
#include <windows.h>

void getExecutablePath(char *buffer) {
    GetModuleFileName(NULL, buffer, MAX_PATH);
    char *lastSlash = strrchr(buffer, '\\');
    if (lastSlash != NULL) {
        *(lastSlash + 1) = '\0';
    }
}

int main() {
    char buffer[MAX_PATH];
    getExecutablePath(buffer);
    printf("abs dir: %s\n", buffer);
    system("pause");
    return 0;
}

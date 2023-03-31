#include <windows.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    if (argc < 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        system("pause");
        return 1;
    }

    for (int i=1; i<argc; i++)
    {
        printf("%s\n", argv[i]);
    }

    system("pause");
    return 0;
}

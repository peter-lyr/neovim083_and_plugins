#include <windows.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    if (argc < 2) {
        printf("Usage: %s filename.csv\n", argv[0]);
        system("pause");
        return 1;
    }

    char *extension = strrchr(argv[1], '.');
    if (extension == NULL || strcmp(extension, ".csv") != 0) {
        printf("Error: %s is not a csv file\n", argv[1]);
        system("pause");
        return 1;
    }

    system("pause");
    return 0;
}

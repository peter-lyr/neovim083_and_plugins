#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

int main()
{
    struct stat buf;
    char *path = "C:\\test.md";
    if (stat(path, &buf) == -1)
    {
        printf("Failed to get file status.\n");
        system("pause");
        return 0;
    }
    if (S_ISDIR(buf.st_mode))
        printf("%s is a directory.\n", path);
    else if (S_ISREG(buf.st_mode))
        printf("%s is a file.\n", path);
    else
        printf("%s is neither a file nor a directory.\n", path);
    system("pause");
    return 0;
}

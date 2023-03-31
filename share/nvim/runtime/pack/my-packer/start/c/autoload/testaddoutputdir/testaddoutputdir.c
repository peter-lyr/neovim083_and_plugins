#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *add_output_dir(char *path)
{
    char *result = (char *)malloc(strlen(path) + 8);
    strcpy(result, path);
    char *last_slash = strrchr(result, '\\');
    char *fname = (char *)malloc(256);
    strcpy(fname, last_slash);
    if (last_slash != NULL)
    {
        *(last_slash + 1) = '\0';
        strcat(result, "output\\");
        strcat(result, fname + 1);
    }
    return result;
}

int main()
{
    char path[] = "c:\\usr\\local\\bin\\test.txt";
    printf("%s\n", path);
    char *result = add_output_dir(path);
    printf("%s\n", result);
    free(result);
    return 0;
}

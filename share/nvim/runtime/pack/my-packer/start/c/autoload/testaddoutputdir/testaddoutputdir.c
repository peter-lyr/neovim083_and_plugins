#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

char *add_output_dir(char *path)
{
    char *subdir = "output";
    char *result = (char *)malloc(strlen(path) + strlen(subdir) + 1);
    strcpy(result, path);
    char *last_slash = strrchr(result, '\\');
    char *fname = (char *)malloc(256);
    strcpy(fname, last_slash);
    if (last_slash != NULL)
    {
        *(last_slash + 1) = '\0';
        strcat(result, subdir);
        mkdir(result);
        strcat(result, fname);
    }
    return result;
}

int main()
{
    char path[] = "C:\\Users\\llydr\\Desktop\\neovim083_and_plugins\\share\\nvim\\runtime\\pack\\my-packer\\start\\c\\autoload\\testaddoutputdir\\testaddoutputdir.c";
    printf("%s\n", path);
    char *result = add_output_dir(path);
    printf("%s\n", result);
    free(result);
    return 0;
}

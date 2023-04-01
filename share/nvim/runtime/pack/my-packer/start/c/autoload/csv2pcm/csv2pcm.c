#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

char *add_output_dir(char *path, char *ext)
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
        strcat(result, ext);
    }
    return result;
}

int csv2pcm(char *filename)
{

    char *extension = strrchr(filename, '.');
    if (extension == NULL || strcmp(extension, ".csv") != 0) {
        printf("Not csv file: \"%s\"\n", filename);
        return -1;
    }

    FILE *fp;
    fp = fopen(filename, "r");
    if (fp == NULL)
    {
        printf("Error opening file\n");
        return -2;
    }

    char *output_filename = add_output_dir(filename, ".pcm");

    FILE *fp2;
    fp2 = fopen(output_filename, "wb");
    if (fp2 == NULL)
    {
        printf("Error opening file\n");
        return -3;
    }

    char buffer[1024];
    fgets(buffer, 1024, fp); // skip first line
    while (fgets(buffer, 1024, fp))
    {
        char *pch = strtok(buffer, ",");
        int cnt = 0;
        while (pch != NULL)
        {
            if (cnt == 1) // sel 2nd row
            {
                int c = atoi(pch);
                fwrite(&c, 1, 2, fp2);
            }
            cnt++;
            pch = strtok(NULL, ",");
        }
    }

    fclose(fp);
    fclose(fp2);

    printf("Ok: %s\n", output_filename);

    return 0;
}

int main(int argc, char *argv[])
{
    if (argc < 2) {
        printf("Usage: %s filename.csv filename2.csv ...\n", argv[0]);
        system("pause");
        return 1;
    }

    for (int i=1; i<argc; i++)
    {
        csv2pcm(argv[i]);
    }

    system("pause");
    return 0;
}

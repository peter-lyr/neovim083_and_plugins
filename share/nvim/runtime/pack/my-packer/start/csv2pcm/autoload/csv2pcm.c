#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    FILE *fp;
    fp = fopen("data.csv", "r");
    if (fp == NULL)
    {
        printf("Error opening file\n");
        exit(1);
    }

    FILE *fp2;
    fp2 = fopen("output.pcm", "wb");
    if (fp2 == NULL)
    {
        printf("Error opening file\n");
        exit(1);
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

    return 0;
}

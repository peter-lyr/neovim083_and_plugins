#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE_LENGTH 1024

void read_ini_file(char *filename, char *section, char *key, char *default_value, char *value)
{
    FILE *fp;
    char line[MAX_LINE_LENGTH];
    int found = 0;

    fp = fopen(filename, "r");
    if (fp != NULL)
    {
        while (fgets(line, MAX_LINE_LENGTH, fp) != NULL)
        {
            if (strstr(line, section) != NULL)
            {
                found = 1;
                break;
            }
        }
        fclose(fp);
    }

    if (!found) {
        fp = fopen(filename, "a");
        fprintf(fp, "[%s]\n", section);
        fprintf(fp, "%s=%s\n", key, default_value);
        fclose(fp);
        strncpy(value, default_value, MAX_LINE_LENGTH);
    }
    else
    {
        fp = fopen(filename, "r+");
        while (fgets(line, MAX_LINE_LENGTH, fp) != NULL)
        {
            if (strstr(line, key) != NULL)
            {
                strncpy(value, strchr(line, '=') + 1, MAX_LINE_LENGTH);
                break;
            }
        }
        if (feof(fp))
        {
            fprintf(fp, "%s=%s\n", key, default_value);
            strncpy(value, default_value, MAX_LINE_LENGTH);
        }
        fclose(fp);
    }
}

int main()
{
    char value_buf[MAX_LINE_LENGTH];

    read_ini_file("test.ini", "circle", "size", "DefaultValue", value_buf);

    int value = atoi(value_buf);
    if (value) {
        printf("value: %d\n", value);
    }

    return 0;
}

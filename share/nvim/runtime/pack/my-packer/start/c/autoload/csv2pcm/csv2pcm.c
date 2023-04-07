#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <windows.h>
#include <sys/stat.h>

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

void split(char *str, int *buffer, int *len) {
    char *token;
    int i = 0;

    token = strtok(str, ",");
    while (token != NULL) {
        int c = strtol(token, NULL, 10);
        buffer[i++] = c;
        token = strtok(NULL, ",");
    }

    *len = i;
}

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

void getExecutablePath(char *buffer) {
    GetModuleFileName(NULL, buffer, MAX_PATH);
    char *lastSlash = strrchr(buffer, '\\');
    if (lastSlash != NULL) {
        *(lastSlash + 1) = '\0';
    }
}

void scan_dir(const char *dir_name, char ***files, int *n)
{
    DIR *dir;
    struct dirent *ent;

    if ((dir = opendir(dir_name)) != NULL) {
        while ((ent = readdir(dir)) != NULL) {
            char *extension = strrchr(ent->d_name, '.');
            if (extension == NULL || (strcmp(extension, ".csv") != 0 && strcmp(extension, ".txt") != 0)) {
                continue;
            }
            if (ent->d_type == DT_REG) { /* If the entry is a regular file */
                *files = realloc(*files, sizeof(char*) * ++(*n));
                (*files)[*n-1] = malloc(strlen(ent->d_name) + 1);
                strcpy((*files)[*n-1], ent->d_name);
            }
        }
        closedir(dir);
    } else {
        perror("");
        exit(EXIT_FAILURE);
    }
}

int csv2pcm(char *filename, int skip_line_numbers, int *sel_columns, int sel_column_len)
{

    char *extension = strrchr(filename, '.');
    if (extension == NULL || (strcmp(extension, ".csv") != 0 && strcmp(extension, ".txt") != 0)) {
        printf("Not csv or txt file: \"%s\"\n", filename);
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

    printf("%s\n", output_filename);

    char buffer[1024];
    for (int i=0; i<skip_line_numbers; i++)
    {
        fgets(buffer, 1024, fp); // skip this line
    }
    int temp_cnt = 0;
    while (fgets(buffer, 1024, fp))
    {
        // Time [s],Packet ID,MOSI,MISO
        char *pch = strtok(buffer, ",");
        int cnt = 1;
        temp_cnt++;
        while (pch != NULL)
        {
            if (memchr(sel_columns, cnt, sel_column_len * sizeof(int)) != NULL)
            {
                int c = strtol(pch, NULL, 16);
                fwrite(&c, 1, 1, fp2);
                if (temp_cnt < 4)
                {
                    printf("%s(0x%02x),", pch, c);
                } else if (temp_cnt == 4) {
                    temp_cnt++;
                    printf("...\n");
                }
            }
            cnt++;
            pch = strtok(NULL, ",");
        }
        if (temp_cnt < 4)
        {
            printf("\n");
        }
    }

    fclose(fp);
    fclose(fp2);

    return 0;
}

int main(int argc, char *argv[])
{
    char skip_line_numbers_buffer[MAX_LINE_LENGTH];
    int skip_line_numbers;

    read_ini_file("csv2pcm.ini", "config", "skip_line_numbers", "1", skip_line_numbers_buffer);

    skip_line_numbers = atoi(skip_line_numbers_buffer);
    if (skip_line_numbers) {
        printf("skip_line_numbers: %d\n", skip_line_numbers);
    } else {
        printf("skip_line_numbers is not a number\n");
        return -1;
    }

    char sel_columns_buffer[MAX_LINE_LENGTH];
    int sel_columns[32];
    int sel_column_len;

    read_ini_file("csv2pcm.ini", "config", "sel_columns", "3", sel_columns_buffer);

    split(sel_columns_buffer, sel_columns, &sel_column_len);
    printf("sel_columns(non empty, first column is 1):\n");
    for (int i = 0; i < sel_column_len; i++) {
        printf("  %d\n", sel_columns[i]);
    }
    printf("\n");

    if (argc < 2) {
        printf("Another Usage(drag files to csv2pcm.exe):\n    csv2pcm.exe filename.csv filename2.csv ...\n");
        printf(" or csv2pcm.exe filename.txt filename2.txt ...\n\n");
        char **Files = NULL;
        int n = 0;

        char executable_dir[MAX_PATH];
        getExecutablePath(executable_dir);
        scan_dir(executable_dir, &Files, &n);
        char f[MAX_PATH];
        if (n == 0) {
            printf("No csv or txt file under %s\n", executable_dir);
        }
        for (int i = 0; i < n; i++) {
            *f = '\0';
            strcat(f, executable_dir);
            strcat(f, Files[i]);
            printf("%03d. ", i + 1);
            csv2pcm(f, skip_line_numbers, sel_columns, sel_column_len);
            free(Files[i]);
        }
        free(Files);
        system("pause");
        return 0;
    }

    for (int i=1; i<argc; i++)
    {
        printf("%03d. ", i);
        csv2pcm(argv[i], skip_line_numbers, sel_columns, sel_column_len);
    }

    system("pause");
    return 0;
}

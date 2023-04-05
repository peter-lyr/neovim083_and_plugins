// C语言如何读取.ini文件的变量？定义一个函数

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE_LEN 1024

int read_ini_file(const char *file_path, const char *section_name, const char *key_name, char *value)
{
    FILE *fp = NULL;
    char line[MAX_LINE_LEN] = {0};
    char *p = NULL;
    int len = 0;
    int ret = -1;
    int section_found = 0;

    if (file_path == NULL || section_name == NULL || key_name == NULL || value == NULL) {
        printf("Invalid parameter.\n");
        return -1;
    }

    fp = fopen(file_path, "r");
    if (fp == NULL) {
        printf("Failed to open file %s.\n", file_path);
        return -1;
    }

    while (fgets(line, MAX_LINE_LEN, fp) != NULL) {
        len = strlen(line);
        if (len <= 0) {
            continue;
        }

        // remove '\r' and '\n' at the end of line
        while (len > 0 && (line[len - 1] == '\r' || line[len - 1] == '\n')) {
            line[len - 1] = '\0';
            len--;
        }

        // check if this line is a section
        if (line[0] == '[' && line[len - 1] == ']') {
            if (section_found) {
                break; // section not found
            }
            if (strncmp(line + 1, section_name, len - 2) == 0) {
                section_found = 1;
            }
            continue;
        }

        // check if this line is a key-value pair
        if (section_found && (p = strchr(line, '=')) != NULL) {
            *p++ = '\0';
            if (strcmp(line, key_name) == 0) {
                strncpy(value, p, MAX_LINE_LEN);
                ret = strlen(value);
                break; // key-value pair found
            }
        }
    }

    fclose(fp);
    return ret;
}

int main() {
    char value_buf[MAX_LINE_LEN];
    int res = read_ini_file("test.ini", "circle", "size", value_buf);
    if (res == -1) {
        return 1;
    }
    int value = atoi(value_buf);
    if (value) {
        printf("value: %d\n", value);
    }
    return 0;
}

// C语言定义一个函数：共3个参数，第一个参数是需要扫描的目录，第二个是保存扫描到的文件名组成的数组指针，第三个是数组长度指针，功能是扫描一个文件夹下的所有文件，放到一个数组里，第二个参数指向它，第三个参数指向它的长度。

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>

void scan_dir(const char *dir_name, char ***files, int *n)
{
    DIR *dir;
    struct dirent *ent;

    if ((dir = opendir(dir_name)) != NULL) {
        while ((ent = readdir(dir)) != NULL) {
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

int main()
{
    char **Files = NULL;
    int n = 0;

    scan_dir(".", &Files, &n);

    /* ... */

    for (int i = 0; i < n; i++) {
        printf("%s\n", Files[i]);
        free(Files[i]);
    }
    free(Files);

    return EXIT_SUCCESS;
}

// C语言定义函数：获取当前绝对路径
// 将它定义成一个函数，在main里调用

#include <stdio.h>
#include <unistd.h>
#include <limits.h>

void get_absolute_path(char *buf) {
    if (getcwd(buf, PATH_MAX) == NULL) {
        perror("getcwd() error");
    }
}

int main() {
    char buf[PATH_MAX];
    printf("PATH_MAX: %d\n", PATH_MAX);
    get_absolute_path(buf);
    printf("Current working dir: %s\n", buf);
    return 0;
}

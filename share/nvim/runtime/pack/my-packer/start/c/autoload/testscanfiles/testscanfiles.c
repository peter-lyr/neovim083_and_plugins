#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>

int scan_files(const char *scan_dir)
{
    DIR *dir;
    struct dirent *ent;
    char **Files = NULL;
    int n = 0;

    if ((dir = opendir (scan_dir)) != NULL) {
        while ((ent = readdir (dir)) != NULL) {
            if (ent->d_type == DT_REG) { /* If the entry is a regular file */
                Files = realloc (Files, sizeof (char*) * ++n);
                Files[n-1] = malloc (strlen(ent->d_name) + 1);
                strcpy (Files[n-1], ent->d_name);
            }
        }
        closedir (dir);
    } else {
        perror ("");
        return EXIT_FAILURE;
    }

    /* ... */

    for (int i = 0; i < n; i++) {
        printf ("%s\n", Files[i]);
        free (Files[i]);
    }
    free (Files);

    return EXIT_SUCCESS;
}

int main()
{
    scan_files(".");
}
